// server.js — CineHive backend
require('dotenv').config();
const express = require('express');
const cors = require('cors');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const path = require('path');
const fs = require('fs');
const multer = require('multer');
const db = require('./db');

const app = express();
app.use(cors());
app.use(express.json());

const JWT_SECRET = process.env.JWT_SECRET;
const SITE_ADMIN_SECRET = process.env.SITE_ADMIN_SECRET_CODE;

// --- Profile picture uploads (local file / gallery picker) ---

const UPLOADS_DIR = path.join(__dirname, 'uploads', 'profile-pictures');
fs.mkdirSync(UPLOADS_DIR, { recursive: true });

// Serve uploaded pictures back out as plain static files, e.g.
// http://localhost:3000/uploads/profile-pictures/12-1234567890.jpg
app.use('/uploads', express.static(path.join(__dirname, 'uploads')));

const pictureStorage = multer.diskStorage({
  destination: (req, file, cb) => cb(null, UPLOADS_DIR),
  filename: (req, file, cb) => {
    const ext = path.extname(file.originalname).toLowerCase() || '.jpg';
    cb(null, `${req.user.userId}-${Date.now()}${ext}`);
  },
});

const ALLOWED_IMAGE_TYPES = ['image/jpeg', 'image/png', 'image/webp', 'image/gif'];

const uploadPicture = multer({
  storage: pictureStorage,
  limits: { fileSize: 5 * 1024 * 1024 }, // 5MB
  fileFilter: (req, file, cb) => {
    if (!ALLOWED_IMAGE_TYPES.includes(file.mimetype)) {
      return cb(new Error('Only JPG, PNG, WEBP, or GIF images are allowed'));
    }
    cb(null, true);
  },
});

// --- Auth routes ---

// Register a new user
// Expects JSON body: { username, email, password, dateOfBirth }
// --- Auth (updated) ---

// Get the list of cinemas (public — used by the sign-up form's
// cinema picker when someone registers as a CINEMA_ADMIN)
app.get('/cinemas', async (req, res) => {
  try {
    const result = await db.execute(`SELECT CINEMA_ID, CINEMA_NAME, CITY FROM CINEMA ORDER BY CINEMA_NAME`);
    res.json(result.rows);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to fetch cinemas' });
  }
});

// Register a new user as CUSTOMER, SITE_ADMIN, or CINEMA_ADMIN.
// CINEMA_ADMIN must include a valid cinemaId.
app.post('/auth/register', async (req, res) => {
  const { username, email, password, dateOfBirth, role, cinemaId, secretCode } = req.body;

  if (!username || !email || !password) {
    return res.status(400).json({ error: 'username, email, and password are required' });
  }

  const chosenRole = ['CUSTOMER', 'SITE_ADMIN', 'CINEMA_ADMIN'].includes(role) ? role : 'CUSTOMER';

  if (chosenRole === 'CINEMA_ADMIN' && !cinemaId) {
    return res.status(400).json({ error: 'cinemaId is required when registering as a cinema admin' });
  }

  if (chosenRole === 'SITE_ADMIN') {
    if (!SITE_ADMIN_SECRET) {
      return res.status(500).json({ error: 'Site admin registration is not configured' });
    }
    if (secretCode !== SITE_ADMIN_SECRET) {
      return res.status(403).json({ error: 'Incorrect site admin secret code' });
    }
  }

  try {
    if (chosenRole === 'CINEMA_ADMIN') {
      const cinemaCheck = await db.execute(`SELECT CINEMA_ID FROM CINEMA WHERE CINEMA_ID = :cinemaId`, { cinemaId });
      if (cinemaCheck.rows.length === 0) {
        return res.status(400).json({ error: 'Selected cinema does not exist' });
      }
    }

    const passwordHash = await bcrypt.hash(password, 10);
    const finalCinemaId = chosenRole === 'CINEMA_ADMIN' ? cinemaId : null;
    // Cinema admins need site-admin approval before they can log in.
    // Customers and site admins (gated by the secret code above) are approved immediately.
    const isApproved = chosenRole === 'CINEMA_ADMIN' ? 0 : 1;

    const result = await db.execute(
      `INSERT INTO APP_USER (USERNAME, EMAIL, PASSWORD_HASH, DATE_OF_BIRTH, DATE_JOINED, ROLE, CINEMA_ID, IS_APPROVED)
       VALUES (:username, :email, :passwordHash, :dateOfBirth, SYSDATE, :role, :cinemaId, :isApproved)
       RETURNING USER_ID INTO :userId`,
      {
        username,
        email,
        passwordHash,
        dateOfBirth: dateOfBirth || null,
        role: chosenRole,
        cinemaId: finalCinemaId,
        isApproved,
        userId: { dir: db.oracledb.BIND_OUT, type: db.oracledb.NUMBER }
      }
    );
    const userId = result.outBinds.userId[0];

    if (!isApproved) {
      // Don't issue a token — this account can't log in until a site admin approves it.
      return res.status(201).json({
        message: 'Account created. A site admin must approve your cinema admin account before you can log in.',
        pending: true,
      });
    }

    const token = jwt.sign({ userId, username, role: chosenRole, cinemaId: finalCinemaId }, JWT_SECRET, { expiresIn: '7d' });
    res.status(201).json({ message: 'User registered', userId, role: chosenRole, cinemaId: finalCinemaId, token });
  } catch (err) {
    console.error(err);
    if (err.errorNum === 1) {
      return res.status(409).json({ error: 'Username or email already exists' });
    }
    res.status(500).json({ error: 'Failed to register user' });
  }
});

// Log in — token now carries role and cinemaId (for admins)
app.post('/auth/login', async (req, res) => {
  const { email, password } = req.body;

  if (!email || !password) {
    return res.status(400).json({ error: 'email and password are required' });
  }

  try {
    const result = await db.execute(
      `SELECT USER_ID, USERNAME, PASSWORD_HASH, ROLE, CINEMA_ID, IS_APPROVED FROM APP_USER WHERE EMAIL = :email`,
      { email }
    );

    if (result.rows.length === 0) {
      return res.status(401).json({ error: 'Invalid email or password' });
    }

    const user = result.rows[0];
    const match = await bcrypt.compare(password, user.PASSWORD_HASH);

    if (!match) {
      return res.status(401).json({ error: 'Invalid email or password' });
    }

    if (user.IS_APPROVED === 0) {
      return res.status(403).json({ error: 'Your cinema admin account is pending approval from a site admin.' });
    }

    const token = jwt.sign(
      { userId: user.USER_ID, username: user.USERNAME, role: user.ROLE, cinemaId: user.CINEMA_ID },
      JWT_SECRET,
      { expiresIn: '7d' }
    );
    res.json({
      message: 'Login successful',
      userId: user.USER_ID,
      username: user.USERNAME,
      role: user.ROLE,
      cinemaId: user.CINEMA_ID,
      token,
    });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to log in' });
  }
});

// Middleware: only allow the site-wide movie-catalog admin through
function requireSiteAdmin(req, res, next) {
  if (req.user.role !== 'SITE_ADMIN') {
    return res.status(403).json({ error: 'Site admin access required' });
  }
  next();
}

// Middleware: only allow a per-cinema admin through
function requireCinemaAdmin(req, res, next) {
  if (req.user.role !== 'CINEMA_ADMIN') {
    return res.status(403).json({ error: 'Cinema admin access required' });
  }
  next();
}

// Middleware: blocks SITE_ADMIN/CINEMA_ADMIN from customer-only actions
// (booking, watchlist, reviews) — the frontend already hides these, this
// is the server-side backstop.
function requireCustomer(req, res, next) {
  if (req.user.role !== 'CUSTOMER') {
    return res.status(403).json({ error: 'This action is only available to customer accounts' });
  }
  next();
}

// Middleware: verifies a JWT and attaches the user to req.user
function requireAuth(req, res, next) {
  const authHeader = req.headers.authorization;
  if (!authHeader || !authHeader.startsWith('Bearer ')) {
    return res.status(401).json({ error: 'Missing or invalid Authorization header' });
  }
  const token = authHeader.split(' ')[1];
  try {
    const payload = jwt.verify(token, JWT_SECRET);
    req.user = payload;
    next();
  } catch (err) {
    return res.status(401).json({ error: 'Invalid or expired token' });
  }
}

// --- Routes ---

// Health check
app.get('/', (req, res) => {
  res.json({ message: 'CineHive API is running' });
});

// Get all movies
app.get('/movies', async (req, res) => {
  try {
    const result = await db.execute(
      `SELECT MOVIE_ID, TITLE, RELEASE_DATE, DURATION, LANGUAGE,
              DESCRIPTION, TRAILER_URL, POSTER_URL,BACKDROP_URL, BOX_OFFICE, BUDGET
       FROM MOVIE
       ORDER BY MOVIE_ID`
    );
    res.json(result.rows);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to fetch movies' });
  }
});


// Get the manually curated set of featured movies for the homepage hero rotation
app.get('/movies/featured', async (req, res) => {
  try {
    const result = await db.execute(
      `SELECT MOVIE_ID, TITLE, RELEASE_DATE, DURATION, LANGUAGE,
              DESCRIPTION, TRAILER_URL, POSTER_URL, BACKDROP_URL, BOX_OFFICE, BUDGET
       FROM MOVIE
       WHERE IS_FEATURED = 1
       ORDER BY MOVIE_ID`
    );
    res.json(result.rows);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to fetch featured movies' });
  }
});

// Search movies by title (case-insensitive partial match)
// Search movies by title (case-insensitive partial match), optionally
// narrowed to one genre via ?genreId= (the "All ▾" filter in the search bar).
// A genreId with no q browses that genre's full catalog; a q with no
// genreId behaves like a plain title search.
app.get('/movies/search', async (req, res) => {
  const q = (req.query.q || '').trim();
  const genreId = req.query.genreId ? Number(req.query.genreId) : null;
  if (!q && !genreId) {
    return res.json([]);
  }
  try {
    const params = {};
    const whereClauses = [];
    let genreJoin = '';
    if (genreId) {
      genreJoin = 'JOIN MOVIE_GENRE mg ON mg.MOVIE_ID = m.MOVIE_ID';
      whereClauses.push('mg.GENRE_ID = :genreId');
      params.genreId = genreId;
    }
    if (q) {
      whereClauses.push("UPPER(m.TITLE) LIKE UPPER('%' || :q || '%')");
      params.q = q;
    }
    const whereSql = whereClauses.length ? `WHERE ${whereClauses.join(' AND ')}` : '';
    const result = await db.execute(
      `SELECT DISTINCT m.MOVIE_ID, m.TITLE, m.RELEASE_DATE, m.DURATION, m.LANGUAGE, m.POSTER_URL, m.BACKDROP_URL
       FROM MOVIE m
       ${genreJoin}
       ${whereSql}
       ORDER BY m.RELEASE_DATE DESC
       FETCH FIRST 40 ROWS ONLY`,
      params
    );
    res.json(result.rows);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to search movies' });
  }
});

// "Now Showing" must be declared before /movies/:id so Express does not
// interpret "now-showing" as a movie ID.
app.get('/movies/now-showing', async (req, res) => {
  const cinemaId = req.query.cinemaId ? Number(req.query.cinemaId) : null;

  try {
    const result = await db.execute(
      `SELECT m.MOVIE_ID, m.TITLE, m.POSTER_URL, m.BACKDROP_URL, m.DURATION, m.LANGUAGE, m.RELEASE_DATE,
              c.CINEMA_ID, c.CINEMA_NAME, c.CITY,
              MIN(st.START_TIME) AS NEXT_SHOWTIME
       FROM MOVIE m
       JOIN SHOWTIME st ON st.MOVIE_ID = m.MOVIE_ID
       JOIN SCREEN sc ON sc.SCREEN_ID = st.SCREEN_ID
       JOIN CINEMA c ON c.CINEMA_ID = sc.CINEMA_ID
       WHERE st.START_TIME > SYSTIMESTAMP
       ${cinemaId ? 'AND c.CINEMA_ID = :cinemaId' : ''}
       GROUP BY m.MOVIE_ID, m.TITLE, m.POSTER_URL, m.BACKDROP_URL, m.DURATION, m.LANGUAGE, m.RELEASE_DATE,
                c.CINEMA_ID, c.CINEMA_NAME, c.CITY
       ORDER BY m.TITLE, NEXT_SHOWTIME`,
      cinemaId ? { cinemaId } : {}
    );

    const byMovie = new Map();
    for (const row of result.rows) {
      if (!byMovie.has(row.MOVIE_ID)) {
        byMovie.set(row.MOVIE_ID, {
          MOVIE_ID: row.MOVIE_ID,
          TITLE: row.TITLE,
          POSTER_URL: row.POSTER_URL,
          BACKDROP_URL: row.BACKDROP_URL,
          DURATION: row.DURATION,
          LANGUAGE: row.LANGUAGE,
          RELEASE_DATE: row.RELEASE_DATE,
          NEXT_SHOWTIME: row.NEXT_SHOWTIME,
          CINEMAS: [],
        });
      }

      const movie = byMovie.get(row.MOVIE_ID);
      movie.CINEMAS.push({
        CINEMA_ID: row.CINEMA_ID,
        CINEMA_NAME: row.CINEMA_NAME,
        CITY: row.CITY,
      });
      if (new Date(row.NEXT_SHOWTIME) < new Date(movie.NEXT_SHOWTIME)) {
        movie.NEXT_SHOWTIME = row.NEXT_SHOWTIME;
      }
    }

    res.json(
      Array.from(byMovie.values()).sort(
        (a, b) => new Date(a.NEXT_SHOWTIME) - new Date(b.NEXT_SHOWTIME)
      )
    );
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to fetch now-showing movies' });
  }
});

// Get a single movie by ID
app.get('/movies/:id', async (req, res) => {
  try {
    const result = await db.execute(
      `SELECT MOVIE_ID, TITLE, RELEASE_DATE, DURATION, LANGUAGE,
              DESCRIPTION, TRAILER_URL, POSTER_URL,BACKDROP_URL, BOX_OFFICE, BUDGET
       FROM MOVIE
       WHERE MOVIE_ID = :id`,
      { id: req.params.id }
    );
    if (result.rows.length === 0) {
      return res.status(404).json({ error: 'Movie not found' });
    }
    res.json(result.rows[0]);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to fetch movie' });
  }
});

// Get showtimes for a movie
app.get('/movies/:id/showtimes', async (req, res) => {
  try {
    const result = await db.execute(
      `SELECT SHOWTIME_ID, MOVIE_ID, SCREEN_ID, SHOW_DATE, START_TIME, END_TIME, TICKET_PRICE
       FROM SHOWTIME
       WHERE MOVIE_ID = :id AND START_TIME > SYSTIMESTAMP
       ORDER BY SHOW_DATE, START_TIME`,
      { id: req.params.id }
    );
    res.json(result.rows);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to fetch showtimes' });
  }
});


app.get('/movies/:id/genres', async (req, res) => {
  try {
    const result = await db.execute(
      `SELECT g.GENRE_ID, g.GENRE_NAME
       FROM MOVIE_GENRE mg
       JOIN GENRE g ON g.GENRE_ID = mg.GENRE_ID
       WHERE mg.MOVIE_ID = :id
       ORDER BY g.GENRE_NAME`,
      { id: req.params.id }
    );
    res.json(result.rows);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to fetch genres' });
  }
});


// Get available seats for a showtime, plus cinema/screen info and base ticket price
app.get('/showtimes/:id/seats', async (req, res) => {
  try {
    const infoResult = await db.execute(
      `SELECT c.CINEMA_NAME, sc.SCREEN_NAME, st.TICKET_PRICE
       FROM SHOWTIME st
       JOIN SCREEN sc ON sc.SCREEN_ID = st.SCREEN_ID
       JOIN CINEMA c ON c.CINEMA_ID = sc.CINEMA_ID
       WHERE st.SHOWTIME_ID = :id`,
      { id: req.params.id }
    );

    const seatsResult = await db.execute(
      `SELECT s.SEAT_ID, s.ROW_NUMBER, s.SEAT_NUMBER, s.SEAT_TYPE,
              CASE WHEN bs.SEAT_ID IS NOT NULL THEN 1 ELSE 0 END AS IS_BOOKED
       FROM SEAT s
       JOIN SHOWTIME st ON st.SCREEN_ID = s.SCREEN_ID
       LEFT JOIN (
         SELECT bs.SEAT_ID FROM BOOKING_SEAT bs
         JOIN BOOKING b ON b.BOOKING_ID = bs.BOOKING_ID
         WHERE bs.SHOWTIME_ID = :id AND b.PAYMENT_STATUS != 'REFUNDED'
       ) bs ON bs.SEAT_ID = s.SEAT_ID
       WHERE st.SHOWTIME_ID = :id
       ORDER BY s.ROW_NUMBER, s.SEAT_NUMBER`,
      { id: req.params.id }
    );

    res.json({
      cinemaName: infoResult.rows[0]?.CINEMA_NAME ?? null,
      screenName: infoResult.rows[0]?.SCREEN_NAME ?? null,
      basePrice: infoResult.rows[0]?.TICKET_PRICE ?? null,
      seats: seatsResult.rows,
    });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to fetch seats' });
  }
});

// Create a booking with one or more seats (requires login)
// Expects JSON body: { showtimeId, seatIds: [1,2,3] }
app.post('/bookings', requireAuth, requireCustomer, async (req, res) => {
  const userId = req.user.userId;
  const { showtimeId, seatIds } = req.body;

  if (!showtimeId || !Array.isArray(seatIds) || seatIds.length === 0) {
    return res.status(400).json({ error: 'showtimeId and a non-empty seatIds array are required' });
  }

  const PREMIUM_MULTIPLIER = 1.5;

  let connection;
  try {
    connection = await db.getRawConnection();

    // Look up base ticket price and start time for this showtime
    const priceResult = await connection.execute(
      `SELECT TICKET_PRICE, START_TIME FROM SHOWTIME WHERE SHOWTIME_ID = :showtimeId`,
      { showtimeId }
    );
    if (priceResult.rows.length === 0) {
      await connection.close();
      return res.status(404).json({ error: 'Showtime not found' });
    }
    if (new Date(priceResult.rows[0].START_TIME) <= new Date()) {
      await connection.close();
      return res.status(409).json({ error: 'This showtime has already started' });
    }
    const basePrice = priceResult.rows[0].TICKET_PRICE;

    // Look up each selected seat's type so premium seats can be priced higher
    const seatTypesResult = await connection.execute(
      `SELECT SEAT_ID, SEAT_TYPE FROM SEAT WHERE SEAT_ID IN (${seatIds.map((_, i) => `:s${i}`).join(',')})`,
      Object.fromEntries(seatIds.map((id, i) => [`s${i}`, id]))
    );
    if (seatTypesResult.rows.length !== seatIds.length) {
      await connection.close();
      return res.status(404).json({ error: 'One or more seats not found' });
    }

    const seatPriceMap = {};
    let totalAmount = 0;
    for (const row of seatTypesResult.rows) {
      const price = row.SEAT_TYPE === 'PREMIUM' ? basePrice * PREMIUM_MULTIPLIER : basePrice;
      seatPriceMap[row.SEAT_ID] = price;
      totalAmount += price;
    }

    // Insert the booking, capturing the generated BOOKING_ID
    const bookingResult = await connection.execute(
      `INSERT INTO BOOKING (USER_ID, SHOWTIME_ID, BOOKING_DATE, TOTAL_AMOUNT, PAYMENT_STATUS)
       VALUES (:userId, :showtimeId, SYSTIMESTAMP, :totalAmount, 'PENDING')
       RETURNING BOOKING_ID INTO :bookingId`,
      {
        userId,
        showtimeId,
        totalAmount,
        bookingId: { dir: db.oracledb.BIND_OUT, type: db.oracledb.NUMBER }
      },
      { autoCommit: false }
    );
    const bookingId = bookingResult.outBinds.bookingId[0];

    // Insert one BOOKING_SEAT row per seat
    for (const seatId of seatIds) {
      await connection.execute(
        `INSERT INTO BOOKING_SEAT (BOOKING_ID, SHOWTIME_ID, SEAT_ID)
         VALUES (:bookingId, :showtimeId, :seatId)`,
        { bookingId, showtimeId, seatId },
        { autoCommit: false }
      );
    }

    await connection.commit();
    res.status(201).json({ message: 'Booking created', bookingId, totalAmount, seatCount: seatIds.length });
  } catch (err) {
    if (connection) await connection.rollback();
    console.error(err);
    if (err.errorNum === 1) {
      return res.status(409).json({ error: 'One or more selected seats are already booked' });
    }
    res.status(500).json({ error: 'Failed to create booking' });
  } finally {
    if (connection) {
      try { await connection.close(); } catch (e) { console.error(e); }
    }
  }
});

// --- Cast & crew ---

// Get cast for a movie
app.get('/movies/:id/cast', async (req, res) => {
  try {
    const result = await db.execute(
      `SELECT a.ACTOR_ID, a.ACTOR_NAME, a.PHOTO_URL, ai.ROLE
       FROM ACTS_IN ai
       JOIN ACTOR a ON a.ACTOR_ID = ai.ACTOR_ID
       WHERE ai.MOVIE_ID = :id
       ORDER BY ai.ACTOR_ID`,
      { id: req.params.id }
    );
    res.json(result.rows);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to fetch cast' });
  }
});

// Get director(s) for a movie
app.get('/movies/:id/directors', async (req, res) => {
  try {
    const result = await db.execute(
      `SELECT d.DIRECTOR_ID, d.DIRECTOR_NAME, d.PHOTO_URL
       FROM DIRECTS dr
       JOIN DIRECTOR d ON d.DIRECTOR_ID = dr.DIRECTOR_ID
       WHERE dr.MOVIE_ID = :id`,
      { id: req.params.id }
    );
    res.json(result.rows);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to fetch directors' });
  }
});

// Get an actor's profile + filmography
app.get('/actors/:id', async (req, res) => {
  try {
    const actorResult = await db.execute(
      `SELECT ACTOR_ID, ACTOR_NAME, DATE_OF_BIRTH, NATIONALITY, PHOTO_URL, BIOGRAPHY
       FROM ACTOR WHERE ACTOR_ID = :id`,
      { id: req.params.id }
    );
    if (actorResult.rows.length === 0) {
      return res.status(404).json({ error: 'Actor not found' });
    }
    const filmographyResult = await db.execute(
      `SELECT m.MOVIE_ID, m.TITLE, m.POSTER_URL, m.RELEASE_DATE, ai.ROLE
       FROM ACTS_IN ai
       JOIN MOVIE m ON m.MOVIE_ID = ai.MOVIE_ID
       WHERE ai.ACTOR_ID = :id
       ORDER BY m.RELEASE_DATE DESC`,
      { id: req.params.id }
    );
    res.json({ ...actorResult.rows[0], filmography: filmographyResult.rows });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to fetch actor' });
  }
});

// Get a director's profile + filmography
app.get('/directors/:id', async (req, res) => {
  try {
    const directorResult = await db.execute(
      `SELECT DIRECTOR_ID, DIRECTOR_NAME, DATE_OF_BIRTH, NATIONALITY, PHOTO_URL, BIOGRAPHY
       FROM DIRECTOR WHERE DIRECTOR_ID = :id`,
      { id: req.params.id }
    );
    if (directorResult.rows.length === 0) {
      return res.status(404).json({ error: 'Director not found' });
    }
    const filmographyResult = await db.execute(
      `SELECT m.MOVIE_ID, m.TITLE, m.POSTER_URL, m.RELEASE_DATE
       FROM DIRECTS dr
       JOIN MOVIE m ON m.MOVIE_ID = dr.MOVIE_ID
       WHERE dr.DIRECTOR_ID = :id
       ORDER BY m.RELEASE_DATE DESC`,
      { id: req.params.id }
    );
    res.json({ ...directorResult.rows[0], filmography: filmographyResult.rows });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to fetch director' });
  }
});

// --- Watchlist (requires login) ---

// Get the logged-in user's watchlist
app.get('/watchlist', requireAuth, requireCustomer, async (req, res) => {
  try {
    const result = await db.execute(
      `SELECT m.MOVIE_ID, m.TITLE, m.POSTER_URL, m.DURATION, m.LANGUAGE, w.ADDED_DATE
       FROM WATCHLIST w
       JOIN MOVIE m ON m.MOVIE_ID = w.MOVIE_ID
       WHERE w.USER_ID = :userId
       ORDER BY w.ADDED_DATE DESC`,
      { userId: req.user.userId }
    );
    res.json(result.rows);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to fetch watchlist' });
  }
});

// Add a movie to the watchlist
app.post('/watchlist', requireAuth, requireCustomer, async (req, res) => {
  const { movieId } = req.body;
  if (!movieId) return res.status(400).json({ error: 'movieId is required' });

  try {
    await db.execute(
      `INSERT INTO WATCHLIST (USER_ID, MOVIE_ID, ADDED_DATE) VALUES (:userId, :movieId, SYSTIMESTAMP)`,
      { userId: req.user.userId, movieId }
    );
    res.status(201).json({ message: 'Added to watchlist' });
  } catch (err) {
    console.error(err);
    if (err.errorNum === 1) {
      return res.status(409).json({ error: 'Movie already in watchlist' });
    }
    res.status(500).json({ error: 'Failed to add to watchlist' });
  }
});

// Remove a movie from the watchlist
app.delete('/watchlist/:movieId', requireAuth, requireCustomer, async (req, res) => {
  try {
    const result = await db.execute(
      `DELETE FROM WATCHLIST WHERE USER_ID = :userId AND MOVIE_ID = :movieId`,
      { userId: req.user.userId, movieId: req.params.movieId }
    );
    res.json({ message: 'Removed from watchlist', rowsAffected: result.rowsAffected });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to remove from watchlist' });
  }
});

// --- Reviews & ratings ---

// Get reviews for a movie (with reviewer usernames)
app.get('/movies/:id/reviews', async (req, res) => {
  try {
    const result = await db.execute(
      `SELECT r.REVIEW_ID, r.USER_ID, u.USERNAME, r.REVIEW_TEXT, r.REVIEW_DATE
       FROM REVIEW r
       JOIN APP_USER u ON u.USER_ID = r.USER_ID
       WHERE r.MOVIE_ID = :id
       ORDER BY r.REVIEW_DATE DESC`,
      { id: req.params.id }
    );
    res.json(result.rows);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to fetch reviews' });
  }
});

// Post a review (requires login)
app.post('/movies/:id/reviews', requireAuth, requireCustomer, async (req, res) => {
  const { reviewText } = req.body;
  if (!reviewText) return res.status(400).json({ error: 'reviewText is required' });

  try {
    const result = await db.execute(
      `INSERT INTO REVIEW (USER_ID, MOVIE_ID, REVIEW_TEXT, REVIEW_DATE)
       VALUES (:userId, :movieId, :reviewText, SYSTIMESTAMP)
       RETURNING REVIEW_ID INTO :reviewId`,
      {
        userId: req.user.userId,
        movieId: req.params.id,
        reviewText,
        reviewId: { dir: db.oracledb.BIND_OUT, type: db.oracledb.NUMBER }
      }
    );
    res.status(201).json({ message: 'Review posted', reviewId: result.outBinds.reviewId[0] });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to post review' });
  }
});

// Get average rating + the logged-in user's own rating (if logged in)
app.get('/movies/:id/rating', async (req, res) => {
  try {
    const avgResult = await db.execute(
      `SELECT ROUND(AVG(RATING_VALUE), 1) AS AVG_RATING, COUNT(*) AS RATING_COUNT
       FROM RATING WHERE MOVIE_ID = :id`,
      { id: req.params.id }
    );

    let myRating = null;
    const authHeader = req.headers.authorization;
    if (authHeader && authHeader.startsWith('Bearer ')) {
      try {
        const payload = jwt.verify(authHeader.split(' ')[1], JWT_SECRET);
        const mine = await db.execute(
          `SELECT RATING_VALUE FROM RATING WHERE USER_ID = :userId AND MOVIE_ID = :movieId`,
          { userId: payload.userId, movieId: req.params.id }
        );
        if (mine.rows.length > 0) myRating = mine.rows[0].RATING_VALUE;
      } catch (e) { /* invalid token, treat as anonymous */ }
    }

    res.json({ ...avgResult.rows[0], myRating });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to fetch rating' });
  }
});

// Set (or update) the logged-in user's rating for a movie
app.post('/movies/:id/rating', requireAuth, async (req, res) => {
  const { ratingValue } = req.body;
  if (ratingValue == null || ratingValue < 0 || ratingValue > 10) {
    return res.status(400).json({ error: 'ratingValue must be between 0 and 10' });
  }

  try {
    await db.execute(
      `MERGE INTO RATING r
       USING (SELECT :userId AS USER_ID, :movieId AS MOVIE_ID FROM dual) src
       ON (r.USER_ID = src.USER_ID AND r.MOVIE_ID = src.MOVIE_ID)
       WHEN MATCHED THEN UPDATE SET RATING_VALUE = :ratingValue, RATING_DATE = SYSTIMESTAMP
       WHEN NOT MATCHED THEN INSERT (USER_ID, MOVIE_ID, RATING_VALUE, RATING_DATE)
         VALUES (:userId, :movieId, :ratingValue, SYSTIMESTAMP)`,
      { userId: req.user.userId, movieId: req.params.id, ratingValue }
    );
    res.json({ message: 'Rating saved' });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to save rating' });
  }
});

// --- Booking history ---

// Get the logged-in user's past bookings
app.get('/bookings/me', requireAuth, requireCustomer, async (req, res) => {
  try {
    const result = await db.execute(
      `SELECT b.BOOKING_ID, b.BOOKING_DATE, b.TOTAL_AMOUNT, b.PAYMENT_STATUS,
              m.TITLE, m.POSTER_URL, st.SHOW_DATE, st.START_TIME,
              (SELECT COUNT(*) FROM BOOKING_SEAT bs WHERE bs.BOOKING_ID = b.BOOKING_ID) AS SEAT_COUNT
       FROM BOOKING b
       JOIN SHOWTIME st ON st.SHOWTIME_ID = b.SHOWTIME_ID
       JOIN MOVIE m ON m.MOVIE_ID = st.MOVIE_ID
       WHERE b.USER_ID = :userId
       ORDER BY b.BOOKING_DATE DESC`,
      { userId: req.user.userId }
    );
    res.json(result.rows);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to fetch booking history' });
  }
});

// Cancel a booking (only if it belongs to the user and the showtime hasn't started yet)
app.post('/bookings/:id/cancel', requireAuth, requireCustomer, async (req, res) => {
  try {
    const bookingResult = await db.execute(
      `SELECT b.BOOKING_ID, b.USER_ID, b.PAYMENT_STATUS, st.SHOW_DATE, st.START_TIME
       FROM BOOKING b
       JOIN SHOWTIME st ON st.SHOWTIME_ID = b.SHOWTIME_ID
       WHERE b.BOOKING_ID = :bookingId`,
      { bookingId: req.params.id }
    );

    if (bookingResult.rows.length === 0) {
      return res.status(404).json({ error: 'Booking not found' });
    }

    const booking = bookingResult.rows[0];

    if (booking.USER_ID !== req.user.userId) {
      return res.status(403).json({ error: 'You can only cancel your own bookings' });
    }

    if (booking.PAYMENT_STATUS === 'REFUNDED') {
      return res.status(409).json({ error: 'Booking is already cancelled' });
    }

    if (new Date(booking.START_TIME) <= new Date()) {
      return res.status(409).json({ error: 'Cannot cancel a showtime that has already started' });
    }

    await db.execute(
      `UPDATE BOOKING SET PAYMENT_STATUS = 'REFUNDED' WHERE BOOKING_ID = :bookingId`,
      { bookingId: req.params.id }
    );

    res.json({ message: 'Booking cancelled' });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to cancel booking' });
  }
});

// Get the flat list of genres that have at least one movie (for the search
// bar's genre filter dropdown, and anywhere else that just needs the list).
app.get('/genres', async (req, res) => {
  try {
    const result = await db.execute(
      `SELECT DISTINCT g.GENRE_ID, g.GENRE_NAME
       FROM GENRE g
       JOIN MOVIE_GENRE mg ON mg.GENRE_ID = g.GENRE_ID
       ORDER BY g.GENRE_NAME`
    );
    res.json(result.rows);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to fetch genres' });
  }
});

// Get movies grouped by genre (only genres that have at least one movie)
app.get('/catalog/by-genre', async (req, res) => {
  try {
    const genresResult = await db.execute(`SELECT GENRE_ID, GENRE_NAME FROM GENRE ORDER BY GENRE_NAME`);
    const rows = [];

    for (const g of genresResult.rows) {
      const moviesResult = await db.execute(
        `SELECT m.MOVIE_ID, m.TITLE, m.POSTER_URL,m.BACKDROP_URL, m.DURATION, m.LANGUAGE, m.RELEASE_DATE, m.BOX_OFFICE
         FROM MOVIE_GENRE mg
         JOIN MOVIE m ON m.MOVIE_ID = mg.MOVIE_ID
         WHERE mg.GENRE_ID = :id
         ORDER BY m.RELEASE_DATE DESC`,
        { id: g.GENRE_ID }
      );
      if (moviesResult.rows.length > 0) {
        rows.push({ genreId: g.GENRE_ID, genreName: g.GENRE_NAME, movies: moviesResult.rows });
      }
    }

    res.json(rows);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to fetch catalog by genre' });
  }
});

// --- Admin routes (all require login + ADMIN role) ---

// Get the logged-in admin's own cinema info
app.get('/admin/me', requireAuth, requireCinemaAdmin, async (req, res) => {
  try {
    const result = await db.execute(
      `SELECT CINEMA_ID, CINEMA_NAME, ADDRESS, CITY FROM CINEMA WHERE CINEMA_ID = :cinemaId`,
      { cinemaId: req.user.cinemaId }
    );
    if (result.rows.length === 0) {
      return res.status(404).json({ error: 'No cinema assigned to this admin' });
    }
    res.json(result.rows[0]);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to fetch cinema info' });
  }
});

// Get the screens belonging to the admin's cinema (for the showtime form)
app.get('/admin/screens', requireAuth, requireCinemaAdmin, async (req, res) => {
  try {
    const result = await db.execute(
      `SELECT SCREEN_ID, SCREEN_NAME, CAPACITY FROM SCREEN WHERE CINEMA_ID = :cinemaId ORDER BY SCREEN_ID`,
      { cinemaId: req.user.cinemaId }
    );
    res.json(result.rows);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to fetch screens' });
  }
});

// Get all genres (for the Add Movie form)
// Get pending cinema admin sign-ups awaiting approval
app.get('/admin/pending-cinema-admins', requireAuth, requireSiteAdmin, async (req, res) => {
  try {
    const result = await db.execute(
      `SELECT u.USER_ID, u.USERNAME, u.EMAIL, u.DATE_JOINED, c.CINEMA_NAME, c.CITY
       FROM APP_USER u
       JOIN CINEMA c ON c.CINEMA_ID = u.CINEMA_ID
       WHERE u.ROLE = 'CINEMA_ADMIN' AND u.IS_APPROVED = 0
       ORDER BY u.DATE_JOINED`
    );
    res.json(result.rows);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to fetch pending cinema admins' });
  }
});

// Approve a pending cinema admin
app.post('/admin/pending-cinema-admins/:userId/approve', requireAuth, requireSiteAdmin, async (req, res) => {
  try {
    const result = await db.execute(
      `UPDATE APP_USER SET IS_APPROVED = 1 WHERE USER_ID = :userId AND ROLE = 'CINEMA_ADMIN' AND IS_APPROVED = 0`,
      { userId: req.params.userId }
    );
    if (result.rowsAffected === 0) {
      return res.status(404).json({ error: 'No matching pending cinema admin found' });
    }
    res.json({ message: 'Cinema admin approved' });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to approve cinema admin' });
  }
});

// Reject (delete) a pending cinema admin sign-up
app.delete('/admin/pending-cinema-admins/:userId', requireAuth, requireSiteAdmin, async (req, res) => {
  try {
    const result = await db.execute(
      `DELETE FROM APP_USER WHERE USER_ID = :userId AND ROLE = 'CINEMA_ADMIN' AND IS_APPROVED = 0`,
      { userId: req.params.userId }
    );
    if (result.rowsAffected === 0) {
      return res.status(404).json({ error: 'No matching pending cinema admin found' });
    }
    res.json({ message: 'Sign-up rejected' });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to reject cinema admin' });
  }
});

// --- Site admin: customer oversight ---

// List all customers with aggregate activity counts
app.get('/admin/customers', requireAuth, requireSiteAdmin, async (req, res) => {
  try {
    const result = await db.execute(
      `SELECT u.USER_ID, u.USERNAME, u.EMAIL, u.DATE_JOINED,
              NVL((SELECT COUNT(*) FROM BOOKING b WHERE b.USER_ID = u.USER_ID AND b.PAYMENT_STATUS != 'REFUNDED'), 0) AS BOOKING_COUNT,
              NVL((SELECT SUM(b.TOTAL_AMOUNT) FROM BOOKING b WHERE b.USER_ID = u.USER_ID AND b.PAYMENT_STATUS != 'REFUNDED'), 0) AS TOTAL_SPENT,
              NVL((SELECT COUNT(*) FROM REVIEW r WHERE r.USER_ID = u.USER_ID), 0) AS REVIEW_COUNT,
              NVL((SELECT COUNT(*) FROM RATING rt WHERE rt.USER_ID = u.USER_ID), 0) AS RATING_COUNT
       FROM APP_USER u
       WHERE u.ROLE = 'CUSTOMER'
       ORDER BY u.DATE_JOINED DESC`
    );
    res.json(result.rows);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to fetch customers' });
  }
});

// Full activity detail for one customer: bookings, reviews, ratings
app.get('/admin/customers/:id/activity', requireAuth, requireSiteAdmin, async (req, res) => {
  try {
    const bookings = await db.execute(
      `SELECT b.BOOKING_ID, m.TITLE, st.SHOW_DATE, st.START_TIME, b.TOTAL_AMOUNT, b.PAYMENT_STATUS, b.BOOKING_DATE
       FROM BOOKING b
       JOIN SHOWTIME st ON st.SHOWTIME_ID = b.SHOWTIME_ID
       JOIN MOVIE m ON m.MOVIE_ID = st.MOVIE_ID
       WHERE b.USER_ID = :id
       ORDER BY b.BOOKING_DATE DESC`,
      { id: req.params.id }
    );
    const reviews = await db.execute(
      `SELECT r.REVIEW_ID, m.TITLE, r.REVIEW_TEXT, r.REVIEW_DATE
       FROM REVIEW r JOIN MOVIE m ON m.MOVIE_ID = r.MOVIE_ID
       WHERE r.USER_ID = :id
       ORDER BY r.REVIEW_DATE DESC`,
      { id: req.params.id }
    );
    const ratings = await db.execute(
      `SELECT m.TITLE, rt.RATING_VALUE, rt.RATING_DATE
       FROM RATING rt JOIN MOVIE m ON m.MOVIE_ID = rt.MOVIE_ID
       WHERE rt.USER_ID = :id
       ORDER BY rt.RATING_DATE DESC`,
      { id: req.params.id }
    );
    res.json({ bookings: bookings.rows, reviews: reviews.rows, ratings: ratings.rows });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to fetch customer activity' });
  }
});

// --- Site admin: full cinema admin management ---

// List every cinema admin account (pending and approved)
app.get('/admin/cinema-admins', requireAuth, requireSiteAdmin, async (req, res) => {
  try {
    const result = await db.execute(
      `SELECT u.USER_ID, u.USERNAME, u.EMAIL, u.DATE_JOINED, u.IS_APPROVED, c.CINEMA_NAME, c.CITY
       FROM APP_USER u
       JOIN CINEMA c ON c.CINEMA_ID = u.CINEMA_ID
       WHERE u.ROLE = 'CINEMA_ADMIN'
       ORDER BY u.IS_APPROVED, u.DATE_JOINED DESC`
    );
    res.json(result.rows);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to fetch cinema admins' });
  }
});

// Approve (or re-approve) a cinema admin
app.post('/admin/cinema-admins/:userId/approve', requireAuth, requireSiteAdmin, async (req, res) => {
  try {
    const result = await db.execute(
      `UPDATE APP_USER SET IS_APPROVED = 1 WHERE USER_ID = :userId AND ROLE = 'CINEMA_ADMIN'`,
      { userId: req.params.userId }
    );
    if (result.rowsAffected === 0) {
      return res.status(404).json({ error: 'Cinema admin not found' });
    }
    res.json({ message: 'Cinema admin approved' });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to approve cinema admin' });
  }
});

// Revoke an already-approved cinema admin's access (they can't log in until re-approved)
app.post('/admin/cinema-admins/:userId/revoke', requireAuth, requireSiteAdmin, async (req, res) => {
  try {
    const result = await db.execute(
      `UPDATE APP_USER SET IS_APPROVED = 0 WHERE USER_ID = :userId AND ROLE = 'CINEMA_ADMIN'`,
      { userId: req.params.userId }
    );
    if (result.rowsAffected === 0) {
      return res.status(404).json({ error: 'Cinema admin not found' });
    }
    res.json({ message: 'Cinema admin access revoked' });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to revoke cinema admin' });
  }
});

// Permanently delete a cinema admin account
app.delete('/admin/cinema-admins/:userId', requireAuth, requireSiteAdmin, async (req, res) => {
  try {
    const result = await db.execute(
      `DELETE FROM APP_USER WHERE USER_ID = :userId AND ROLE = 'CINEMA_ADMIN'`,
      { userId: req.params.userId }
    );
    if (result.rowsAffected === 0) {
      return res.status(404).json({ error: 'Cinema admin not found' });
    }
    res.json({ message: 'Cinema admin account deleted' });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to delete cinema admin' });
  }
});

app.get('/admin/genres', requireAuth, requireSiteAdmin, async (req, res) => {
  try {
    const result = await db.execute(`SELECT GENRE_ID, GENRE_NAME FROM GENRE ORDER BY GENRE_NAME`);
    res.json(result.rows);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to fetch genres' });
  }
});

// --- Site admin: featured movies (homepage hero rotation) ---

// Get every movie with its current IS_FEATURED status, for the Featured Movies admin screen
app.get('/admin/featured-movies', requireAuth, requireSiteAdmin, async (req, res) => {
  try {
    const result = await db.execute(
      `SELECT MOVIE_ID, TITLE, POSTER_URL, RELEASE_DATE, IS_FEATURED
       FROM MOVIE
       ORDER BY TITLE`
    );
    res.json(result.rows);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to fetch movies' });
  }
});

// Add a movie to the homepage hero rotation
app.post('/admin/movies/:id/feature', requireAuth, requireSiteAdmin, async (req, res) => {
  try {
    const result = await db.execute(
      `UPDATE MOVIE SET IS_FEATURED = 1 WHERE MOVIE_ID = :id`,
      { id: req.params.id }
    );
    if (result.rowsAffected === 0) {
      return res.status(404).json({ error: 'Movie not found' });
    }
    res.json({ message: 'Movie featured' });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to feature movie' });
  }
});

// Remove a movie from the homepage hero rotation
app.post('/admin/movies/:id/unfeature', requireAuth, requireSiteAdmin, async (req, res) => {
  try {
    const result = await db.execute(
      `UPDATE MOVIE SET IS_FEATURED = 0 WHERE MOVIE_ID = :id`,
      { id: req.params.id }
    );
    if (result.rowsAffected === 0) {
      return res.status(404).json({ error: 'Movie not found' });
    }
    res.json({ message: 'Movie unfeatured' });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to unfeature movie' });
  }
});

// Add a new movie to the shared catalog (any admin can add — movies aren't cinema-owned)
// Expects: { title, releaseDate, duration, language, description, trailerUrl, posterUrl,
//            genreIds: [1,2], directorName, castNames: ["Name One", "Name Two"] }
app.post('/admin/movies', requireAuth, requireSiteAdmin, async (req, res) => {
  const {
    title, releaseDate, duration, language, description,
    trailerUrl, posterUrl, genreIds, directorName, castNames
  } = req.body;

  if (!title || !releaseDate || !duration || !language) {
    return res.status(400).json({ error: 'title, releaseDate, duration, and language are required' });
  }

  let connection;
  try {
    connection = await db.getRawConnection();

    const movieResult = await connection.execute(
      `INSERT INTO MOVIE (TITLE, RELEASE_DATE, DURATION, LANGUAGE, DESCRIPTION, TRAILER_URL, POSTER_URL)
       VALUES (:title, TO_DATE(:releaseDate, 'YYYY-MM-DD'), :duration, :language, :description, :trailerUrl, :posterUrl)
       RETURNING MOVIE_ID INTO :movieId`,
      {
        title, releaseDate, duration, language,
        description: description || null,
        trailerUrl: trailerUrl || null,
        posterUrl: posterUrl || null,
        movieId: { dir: db.oracledb.BIND_OUT, type: db.oracledb.NUMBER }
      },
      { autoCommit: false }
    );
    const movieId = movieResult.outBinds.movieId[0];

    if (Array.isArray(genreIds)) {
      for (const genreId of genreIds) {
        await connection.execute(
          `INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) VALUES (:movieId, :genreId)`,
          { movieId, genreId },
          { autoCommit: false }
        );
      }
    }

    if (directorName && directorName.trim()) {
      const existing = await connection.execute(
        `SELECT DIRECTOR_ID FROM DIRECTOR WHERE DIRECTOR_NAME = :name`,
        { name: directorName.trim() }
      );
      let directorId;
      if (existing.rows.length > 0) {
        directorId = existing.rows[0].DIRECTOR_ID;
      } else {
        const insertRes = await connection.execute(
          `INSERT INTO DIRECTOR (DIRECTOR_NAME) VALUES (:name) RETURNING DIRECTOR_ID INTO :id`,
          { name: directorName.trim(), id: { dir: db.oracledb.BIND_OUT, type: db.oracledb.NUMBER } },
          { autoCommit: false }
        );
        directorId = insertRes.outBinds.id[0];
      }
      await connection.execute(
        `INSERT INTO DIRECTS (DIRECTOR_ID, MOVIE_ID) VALUES (:directorId, :movieId)`,
        { directorId, movieId },
        { autoCommit: false }
      );
    }

    if (Array.isArray(castNames)) {
      for (const name of castNames) {
        const trimmed = (name || '').trim();
        if (!trimmed) continue;
        const existing = await connection.execute(
          `SELECT ACTOR_ID FROM ACTOR WHERE ACTOR_NAME = :name`,
          { name: trimmed }
        );
        let actorId;
        if (existing.rows.length > 0) {
          actorId = existing.rows[0].ACTOR_ID;
        } else {
          const insertRes = await connection.execute(
            `INSERT INTO ACTOR (ACTOR_NAME) VALUES (:name) RETURNING ACTOR_ID INTO :id`,
            { name: trimmed, id: { dir: db.oracledb.BIND_OUT, type: db.oracledb.NUMBER } },
            { autoCommit: false }
          );
          actorId = insertRes.outBinds.id[0];
        }
        await connection.execute(
          `INSERT INTO ACTS_IN (ACTOR_ID, MOVIE_ID) VALUES (:actorId, :movieId)`,
          { actorId, movieId },
          { autoCommit: false }
        );
      }
    }

    await connection.commit();
    res.status(201).json({ message: 'Movie added', movieId });
  } catch (err) {
    if (connection) await connection.rollback();
    console.error(err);
    res.status(500).json({ error: 'Failed to add movie' });
  } finally {
    if (connection) {
      try { await connection.close(); } catch (e) { console.error(e); }
    }
  }
});

// List all movies for the admin "Edit Movies" browser — lightweight rows,
// optionally narrowed by title so a large catalog stays easy to search.
app.get('/admin/movies', requireAuth, requireSiteAdmin, async (req, res) => {
  const q = (req.query.q || '').trim();
  try {
    const result = await db.execute(
      `SELECT MOVIE_ID, TITLE, RELEASE_DATE, POSTER_URL
       FROM MOVIE
       ${q ? "WHERE UPPER(TITLE) LIKE UPPER('%' || :q || '%')" : ''}
       ORDER BY TITLE
       FETCH FIRST 50 ROWS ONLY`,
      q ? { q } : {}
    );
    res.json(result.rows);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to fetch movies' });
  }
});

// Get one movie's full editable details in a single call: core fields plus
// its current genres, director, and cast, for prefilling the edit form.
app.get('/admin/movies/:id', requireAuth, requireSiteAdmin, async (req, res) => {
  try {
    const movieResult = await db.execute(
      `SELECT MOVIE_ID, TITLE, RELEASE_DATE, DURATION, LANGUAGE, DESCRIPTION, TRAILER_URL, POSTER_URL
       FROM MOVIE WHERE MOVIE_ID = :id`,
      { id: req.params.id }
    );
    if (movieResult.rows.length === 0) {
      return res.status(404).json({ error: 'Movie not found' });
    }

    const genresResult = await db.execute(
      `SELECT g.GENRE_ID FROM MOVIE_GENRE g WHERE g.MOVIE_ID = :id`,
      { id: req.params.id }
    );
    const directorResult = await db.execute(
      `SELECT d.DIRECTOR_NAME
       FROM DIRECTS dr JOIN DIRECTOR d ON d.DIRECTOR_ID = dr.DIRECTOR_ID
       WHERE dr.MOVIE_ID = :id`,
      { id: req.params.id }
    );
    const castResult = await db.execute(
      `SELECT a.ACTOR_NAME
       FROM ACTS_IN ai JOIN ACTOR a ON a.ACTOR_ID = ai.ACTOR_ID
       WHERE ai.MOVIE_ID = :id
       ORDER BY ai.ACTOR_ID`,
      { id: req.params.id }
    );

    res.json({
      ...movieResult.rows[0],
      GENRE_IDS: genresResult.rows.map((r) => r.GENRE_ID),
      DIRECTOR_NAME: directorResult.rows[0]?.DIRECTOR_NAME || '',
      CAST_NAMES: castResult.rows.map((r) => r.ACTOR_NAME),
    });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to fetch movie' });
  }
});

// Update an existing movie's core details, genres, director, and cast.
// Same request shape as POST /admin/movies. Genre/director/cast links are
// fully replaced with whatever is sent, so an empty array clears them.
app.put('/admin/movies/:id', requireAuth, requireSiteAdmin, async (req, res) => {
  const movieId = req.params.id;
  const {
    title, releaseDate, duration, language, description,
    trailerUrl, posterUrl, genreIds, directorName, castNames
  } = req.body;

  if (!title || !releaseDate || !duration || !language) {
    return res.status(400).json({ error: 'title, releaseDate, duration, and language are required' });
  }

  let connection;
  try {
    connection = await db.getRawConnection();

    const existing = await connection.execute(
      `SELECT MOVIE_ID FROM MOVIE WHERE MOVIE_ID = :movieId`,
      { movieId }
    );
    if (existing.rows.length === 0) {
      await connection.close();
      return res.status(404).json({ error: 'Movie not found' });
    }

    await connection.execute(
      `UPDATE MOVIE
       SET TITLE = :title,
           RELEASE_DATE = TO_DATE(:releaseDate, 'YYYY-MM-DD'),
           DURATION = :duration,
           LANGUAGE = :language,
           DESCRIPTION = :description,
           TRAILER_URL = :trailerUrl,
           POSTER_URL = :posterUrl
       WHERE MOVIE_ID = :movieId`,
      {
        title, releaseDate, duration, language,
        description: description || null,
        trailerUrl: trailerUrl || null,
        posterUrl: posterUrl || null,
        movieId,
      },
      { autoCommit: false }
    );

    // Genres: drop and re-insert whatever the form currently has selected.
    await connection.execute(
      `DELETE FROM MOVIE_GENRE WHERE MOVIE_ID = :movieId`,
      { movieId },
      { autoCommit: false }
    );
    if (Array.isArray(genreIds)) {
      for (const genreId of genreIds) {
        await connection.execute(
          `INSERT INTO MOVIE_GENRE (MOVIE_ID, GENRE_ID) VALUES (:movieId, :genreId)`,
          { movieId, genreId },
          { autoCommit: false }
        );
      }
    }

    // Director: drop the old link; add the new one (creating the DIRECTOR row if needed).
    await connection.execute(
      `DELETE FROM DIRECTS WHERE MOVIE_ID = :movieId`,
      { movieId },
      { autoCommit: false }
    );
    if (directorName && directorName.trim()) {
      const existingDirector = await connection.execute(
        `SELECT DIRECTOR_ID FROM DIRECTOR WHERE DIRECTOR_NAME = :name`,
        { name: directorName.trim() }
      );
      let directorId;
      if (existingDirector.rows.length > 0) {
        directorId = existingDirector.rows[0].DIRECTOR_ID;
      } else {
        const insertRes = await connection.execute(
          `INSERT INTO DIRECTOR (DIRECTOR_NAME) VALUES (:name) RETURNING DIRECTOR_ID INTO :id`,
          { name: directorName.trim(), id: { dir: db.oracledb.BIND_OUT, type: db.oracledb.NUMBER } },
          { autoCommit: false }
        );
        directorId = insertRes.outBinds.id[0];
      }
      await connection.execute(
        `INSERT INTO DIRECTS (DIRECTOR_ID, MOVIE_ID) VALUES (:directorId, :movieId)`,
        { directorId, movieId },
        { autoCommit: false }
      );
    }

    // Cast: drop the old lineup; add the new one (creating ACTOR rows as needed).
    await connection.execute(
      `DELETE FROM ACTS_IN WHERE MOVIE_ID = :movieId`,
      { movieId },
      { autoCommit: false }
    );
    if (Array.isArray(castNames)) {
      for (const name of castNames) {
        const trimmed = (name || '').trim();
        if (!trimmed) continue;
        const existingActor = await connection.execute(
          `SELECT ACTOR_ID FROM ACTOR WHERE ACTOR_NAME = :name`,
          { name: trimmed }
        );
        let actorId;
        if (existingActor.rows.length > 0) {
          actorId = existingActor.rows[0].ACTOR_ID;
        } else {
          const insertRes = await connection.execute(
            `INSERT INTO ACTOR (ACTOR_NAME) VALUES (:name) RETURNING ACTOR_ID INTO :id`,
            { name: trimmed, id: { dir: db.oracledb.BIND_OUT, type: db.oracledb.NUMBER } },
            { autoCommit: false }
          );
          actorId = insertRes.outBinds.id[0];
        }
        await connection.execute(
          `INSERT INTO ACTS_IN (ACTOR_ID, MOVIE_ID) VALUES (:actorId, :movieId)`,
          { actorId, movieId },
          { autoCommit: false }
        );
      }
    }

    await connection.commit();
    res.json({ message: 'Movie updated' });
  } catch (err) {
    if (connection) await connection.rollback();
    console.error(err);
    res.status(500).json({ error: 'Failed to update movie' });
  } finally {
    if (connection) {
      try { await connection.close(); } catch (e) { console.error(e); }
    }
  }
});

// Get showtimes for the admin's own cinema
app.get('/admin/showtimes', requireAuth, requireCinemaAdmin, async (req, res) => {
  try {
    const result = await db.execute(
      `SELECT st.SHOWTIME_ID, st.MOVIE_ID, m.TITLE, st.SCREEN_ID, sc.SCREEN_NAME, sc.CAPACITY,
              st.SHOW_DATE, st.START_TIME, st.END_TIME, st.TICKET_PRICE,
              NVL((SELECT COUNT(*) FROM BOOKING_SEAT bs
                   JOIN BOOKING b ON b.BOOKING_ID = bs.BOOKING_ID
                   WHERE bs.SHOWTIME_ID = st.SHOWTIME_ID AND b.PAYMENT_STATUS != 'REFUNDED'), 0) AS SEATS_SOLD,
              NVL((SELECT SUM(b.TOTAL_AMOUNT) FROM BOOKING b
                   WHERE b.SHOWTIME_ID = st.SHOWTIME_ID AND b.PAYMENT_STATUS != 'REFUNDED'), 0) AS AMOUNT_SOLD
       FROM SHOWTIME st
       JOIN SCREEN sc ON sc.SCREEN_ID = st.SCREEN_ID
       JOIN MOVIE m ON m.MOVIE_ID = st.MOVIE_ID
       WHERE sc.CINEMA_ID = :cinemaId
       ORDER BY st.SHOW_DATE DESC, st.START_TIME DESC`,
      { cinemaId: req.user.cinemaId }
    );
    res.json(result.rows);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to fetch showtimes' });
  }
});

// Get the full seat map for one of the admin's own showtimes, with a
// booked/available flag per seat (read-only — for checking sales)
app.get('/admin/showtimes/:id/seats', requireAuth, requireCinemaAdmin, async (req, res) => {
  try {
    const ownershipCheck = await db.execute(
      `SELECT st.SHOWTIME_ID
       FROM SHOWTIME st
       JOIN SCREEN sc ON sc.SCREEN_ID = st.SCREEN_ID
       WHERE st.SHOWTIME_ID = :id AND sc.CINEMA_ID = :cinemaId`,
      { id: req.params.id, cinemaId: req.user.cinemaId }
    );
    if (ownershipCheck.rows.length === 0) {
      return res.status(403).json({ error: 'You can only view seats for your own cinema' });
    }

    const result = await db.execute(
      `SELECT s.SEAT_ID, s.ROW_NUMBER, s.SEAT_NUMBER, s.SEAT_TYPE,
              CASE WHEN bs.SEAT_ID IS NOT NULL THEN 1 ELSE 0 END AS IS_BOOKED
       FROM SEAT s
       JOIN SHOWTIME st ON st.SCREEN_ID = s.SCREEN_ID
       LEFT JOIN (
         SELECT bs.SEAT_ID FROM BOOKING_SEAT bs
         JOIN BOOKING b ON b.BOOKING_ID = bs.BOOKING_ID
         WHERE bs.SHOWTIME_ID = :id AND b.PAYMENT_STATUS != 'REFUNDED'
       ) bs ON bs.SEAT_ID = s.SEAT_ID
       WHERE st.SHOWTIME_ID = :id
       ORDER BY s.ROW_NUMBER, s.SEAT_NUMBER`,
      { id: req.params.id }
    );
    res.json(result.rows);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to fetch seat map' });
  }
});

// Add a showtime on one of the admin's own screens
// Expects: { movieId, screenId, showDate, startTime, ticketPrice }
// showDate: 'YYYY-MM-DD', startTime: 'YYYY-MM-DD HH24:MI'
app.post('/admin/showtimes', requireAuth, requireCinemaAdmin, async (req, res) => {
  const { movieId, screenId, showDate, startTime, ticketPrice } = req.body;

  if (!movieId || !screenId || !showDate || !startTime || !ticketPrice) {
    return res.status(400).json({ error: 'movieId, screenId, showDate, startTime, and ticketPrice are required' });
  }

  try {
    // Verify the screen actually belongs to this admin's cinema
    const screenCheck = await db.execute(
      `SELECT SCREEN_ID FROM SCREEN WHERE SCREEN_ID = :screenId AND CINEMA_ID = :cinemaId`,
      { screenId, cinemaId: req.user.cinemaId }
    );
    if (screenCheck.rows.length === 0) {
      return res.status(403).json({ error: 'That screen does not belong to your cinema' });
    }

    const movieResult = await db.execute(`SELECT DURATION FROM MOVIE WHERE MOVIE_ID = :movieId`, { movieId });
    if (movieResult.rows.length === 0) {
      return res.status(404).json({ error: 'Movie not found' });
    }
    const duration = movieResult.rows[0].DURATION;

    const result = await db.execute(
      `INSERT INTO SHOWTIME (MOVIE_ID, SCREEN_ID, SHOW_DATE, START_TIME, END_TIME, TICKET_PRICE)
       VALUES (
         :movieId, :screenId,
         TO_DATE(:showDate, 'YYYY-MM-DD'),
         TO_TIMESTAMP(:startTime, 'YYYY-MM-DD HH24:MI'),
         TO_TIMESTAMP(:startTime, 'YYYY-MM-DD HH24:MI') + :duration / 1440,
         :ticketPrice
       )
       RETURNING SHOWTIME_ID INTO :showtimeId`,
      {
        movieId, screenId, showDate, startTime, duration, ticketPrice,
        showtimeId: { dir: db.oracledb.BIND_OUT, type: db.oracledb.NUMBER }
      }
    );
    res.status(201).json({ message: 'Showtime added', showtimeId: result.outBinds.showtimeId[0] });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to add showtime' });
  }
});

// Update a showtime's price/date/time (admin can only touch their own cinema's showtimes)
app.put('/admin/showtimes/:id', requireAuth, requireCinemaAdmin, async (req, res) => {
  const { showDate, startTime, ticketPrice } = req.body;

  try {
    const ownershipCheck = await db.execute(
      `SELECT st.SHOWTIME_ID, m.DURATION
       FROM SHOWTIME st
       JOIN SCREEN sc ON sc.SCREEN_ID = st.SCREEN_ID
       JOIN MOVIE m ON m.MOVIE_ID = st.MOVIE_ID
       WHERE st.SHOWTIME_ID = :id AND sc.CINEMA_ID = :cinemaId`,
      { id: req.params.id, cinemaId: req.user.cinemaId }
    );
    if (ownershipCheck.rows.length === 0) {
      return res.status(403).json({ error: 'You can only edit showtimes at your own cinema' });
    }
    const duration = ownershipCheck.rows[0].DURATION;

    await db.execute(
      `UPDATE SHOWTIME SET
         SHOW_DATE = TO_DATE(:showDate, 'YYYY-MM-DD'),
         START_TIME = TO_TIMESTAMP(:startTime, 'YYYY-MM-DD HH24:MI'),
         END_TIME = TO_TIMESTAMP(:startTime, 'YYYY-MM-DD HH24:MI') + :duration / 1440,
         TICKET_PRICE = :ticketPrice
       WHERE SHOWTIME_ID = :id`,
      { showDate, startTime, duration, ticketPrice, id: req.params.id }
    );
    res.json({ message: 'Showtime updated' });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to update showtime' });
  }
});

// Delete a showtime (only if it belongs to the admin's cinema and has no bookings yet)
app.delete('/admin/showtimes/:id', requireAuth, requireCinemaAdmin, async (req, res) => {
  try {
    const ownershipCheck = await db.execute(
      `SELECT st.SHOWTIME_ID
       FROM SHOWTIME st
       JOIN SCREEN sc ON sc.SCREEN_ID = st.SCREEN_ID
       WHERE st.SHOWTIME_ID = :id AND sc.CINEMA_ID = :cinemaId`,
      { id: req.params.id, cinemaId: req.user.cinemaId }
    );
    if (ownershipCheck.rows.length === 0) {
      return res.status(403).json({ error: 'You can only delete showtimes at your own cinema' });
    }

    const bookingCheck = await db.execute(
      `SELECT COUNT(*) AS CNT FROM BOOKING WHERE SHOWTIME_ID = :id AND PAYMENT_STATUS != 'REFUNDED'`,
      { id: req.params.id }
    );
    if (bookingCheck.rows[0].CNT > 0) {
      return res.status(409).json({ error: 'Cannot delete a showtime with active bookings' });
    }

    await db.execute(`DELETE FROM SHOWTIME WHERE SHOWTIME_ID = :id`, { id: req.params.id });
    res.json({ message: 'Showtime deleted' });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to delete showtime' });
  }
});

// --- Profile (every logged-in user: customers, cinema admins, site admins) ---

// Get the logged-in user's own profile
app.get('/profile/me', requireAuth, async (req, res) => {
  try {
    const result = await db.execute(
      `SELECT u.USER_ID, u.USERNAME, u.NICKNAME, u.EMAIL, u.DATE_OF_BIRTH, u.DATE_JOINED, u.ROLE,
              u.CINEMA_ID, u.PROFILE_PIC, u.IS_APPROVED, c.CINEMA_NAME
       FROM APP_USER u
       LEFT JOIN CINEMA c ON c.CINEMA_ID = u.CINEMA_ID
       WHERE u.USER_ID = :userId`,
      { userId: req.user.userId }
    );
    if (result.rows.length === 0) {
      return res.status(404).json({ error: 'User not found' });
    }
    res.json(result.rows[0]);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to fetch profile' });
  }
});

// Update the logged-in user's own profile (not role, not cinema, not password)
app.put('/profile/me', requireAuth, async (req, res) => {
  const { username, email, dateOfBirth, profilePictureUrl, nickname } = req.body;

  if (!username || !email) {
    return res.status(400).json({ error: 'username and email are required' });
  }

  try {
    await db.execute(
      `UPDATE APP_USER
       SET USERNAME = :username,
           EMAIL = :email,
           DATE_OF_BIRTH = :dateOfBirth,
           PROFILE_PIC = :profilePictureUrl,
           NICKNAME = :nickname
       WHERE USER_ID = :userId`,
      {
        username,
        email,
        // Oracle DATE column — node-oracledb needs an actual Date object here,
        // not the raw "yyyy-mm-dd" string from <input type="date">, or the
        // implicit server-side conversion throws ORA-01861.
        dateOfBirth: dateOfBirth ? new Date(dateOfBirth) : null,
        profilePictureUrl: profilePictureUrl || null,
        // Optional — trim so a blank field clears it back to null instead of storing "".
        nickname: nickname && nickname.trim() ? nickname.trim() : null,
        userId: req.user.userId,
      }
    );
    res.json({ message: 'Profile updated' });
  } catch (err) {
    console.error(err);
    if (err.errorNum === 1) {
      return res.status(409).json({ error: 'Username or email already in use' });
    }
    res.status(500).json({ error: 'Failed to update profile' });
  }
});

// Change the logged-in user's own password
app.post('/profile/me/password', requireAuth, async (req, res) => {
  const { currentPassword, newPassword } = req.body;

  if (!currentPassword || !newPassword) {
    return res.status(400).json({ error: 'currentPassword and newPassword are required' });
  }
  if (newPassword.length < 8) {
    return res.status(400).json({ error: 'New password must be at least 8 characters' });
  }

  try {
    const result = await db.execute(
      `SELECT PASSWORD_HASH FROM APP_USER WHERE USER_ID = :userId`,
      { userId: req.user.userId }
    );
    if (result.rows.length === 0) {
      return res.status(404).json({ error: 'User not found' });
    }

    const match = await bcrypt.compare(currentPassword, result.rows[0].PASSWORD_HASH);
    if (!match) {
      return res.status(401).json({ error: 'Current password is incorrect' });
    }

    const newHash = await bcrypt.hash(newPassword, 10);
    await db.execute(
      `UPDATE APP_USER SET PASSWORD_HASH = :newHash WHERE USER_ID = :userId`,
      { newHash, userId: req.user.userId }
    );
    res.json({ message: 'Password changed' });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to change password' });
  }
});

// Get the logged-in user's own activity history (bookings, reviews, ratings).
// Only customers can book/review/rate, so this will just come back empty for admins.
app.get('/profile/me/activity', requireAuth, async (req, res) => {
  try {
    const bookings = await db.execute(
      `SELECT b.BOOKING_ID, m.MOVIE_ID, m.TITLE, m.POSTER_URL, st.SHOW_DATE, st.START_TIME,
              b.TOTAL_AMOUNT, b.PAYMENT_STATUS, b.BOOKING_DATE
       FROM BOOKING b
       JOIN SHOWTIME st ON st.SHOWTIME_ID = b.SHOWTIME_ID
       JOIN MOVIE m ON m.MOVIE_ID = st.MOVIE_ID
       WHERE b.USER_ID = :userId
       ORDER BY b.BOOKING_DATE DESC`,
      { userId: req.user.userId }
    );
    const reviews = await db.execute(
      `SELECT r.REVIEW_ID, m.MOVIE_ID, m.TITLE, m.POSTER_URL, r.REVIEW_TEXT, r.REVIEW_DATE
       FROM REVIEW r JOIN MOVIE m ON m.MOVIE_ID = r.MOVIE_ID
       WHERE r.USER_ID = :userId
       ORDER BY r.REVIEW_DATE DESC`,
      { userId: req.user.userId }
    );
    const ratings = await db.execute(
      `SELECT m.MOVIE_ID, m.TITLE, m.POSTER_URL, rt.RATING_VALUE, rt.RATING_DATE
       FROM RATING rt JOIN MOVIE m ON m.MOVIE_ID = rt.MOVIE_ID
       WHERE rt.USER_ID = :userId
       ORDER BY rt.RATING_DATE DESC`,
      { userId: req.user.userId }
    );
    res.json({ bookings: bookings.rows, reviews: reviews.rows, ratings: ratings.rows });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to fetch activity history' });
  }
});

// Upload a profile picture from the user's device (file/folder or phone gallery).
// Replaces any previous PROFILE_PIC value and deletes the old uploaded file, if any.
app.post('/profile/me/picture', requireAuth, uploadPicture.single('picture'), async (req, res) => {
  if (!req.file) {
    return res.status(400).json({ error: 'No image file was uploaded' });
  }

  const pictureUrl = `${req.protocol}://${req.get('host')}/uploads/profile-pictures/${req.file.filename}`;

  try {
    const existing = await db.execute(
      `SELECT PROFILE_PIC FROM APP_USER WHERE USER_ID = :userId`,
      { userId: req.user.userId }
    );

    await db.execute(
      `UPDATE APP_USER SET PROFILE_PIC = :pictureUrl WHERE USER_ID = :userId`,
      { pictureUrl, userId: req.user.userId }
    );

    // Best-effort cleanup of the previous uploaded file (only if it was one of ours).
    const oldUrl = existing.rows[0]?.PROFILE_PIC;
    if (oldUrl && oldUrl.includes('/uploads/profile-pictures/')) {
      const oldFilename = oldUrl.split('/uploads/profile-pictures/')[1];
      const oldPath = path.join(UPLOADS_DIR, oldFilename);
      fs.unlink(oldPath, () => {}); // ignore errors — file may already be gone
    }

    res.json({ message: 'Profile picture updated', profilePictureUrl: pictureUrl });
  } catch (err) {
    console.error(err);
    fs.unlink(req.file.path, () => {}); // clean up the just-uploaded file since the DB update failed
    res.status(500).json({ error: 'Failed to save profile picture' });
  }
});

// Handle multer errors (file too large, bad type, etc.) with a clean JSON response
// instead of Express's default HTML error page.
app.use('/profile/me/picture', (err, req, res, next) => {
  if (err instanceof multer.MulterError || err) {
    return res.status(400).json({ error: err.message || 'Upload failed' });
  }
  next();
});

// --- Site Feedback (suggestions about the website itself) ---
// Any logged-in user can submit one; only the site admin can read them.
// This is separate from movie REVIEWs, which are about a specific film.

// Submit a suggestion/feedback message
app.post('/feedback', requireAuth, async (req, res) => {
  const message = (req.body.message || '').trim();
  if (!message) {
    return res.status(400).json({ error: 'message is required' });
  }
  if (message.length > 2000) {
    return res.status(400).json({ error: 'message must be 2000 characters or fewer' });
  }

  try {
    await db.execute(
      `INSERT INTO SITE_FEEDBACK (USER_ID, MESSAGE) VALUES (:userId, :message)`,
      { userId: req.user.userId, message }
    );
    res.status(201).json({ message: 'Feedback submitted' });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to submit feedback' });
  }
});

// Site admin: list all submitted feedback, most recent first
app.get('/admin/feedback', requireAuth, requireSiteAdmin, async (req, res) => {
  try {
    const result = await db.execute(
      `SELECT f.FEEDBACK_ID, f.MESSAGE, f.CREATED_AT, u.USERNAME, u.NICKNAME, u.EMAIL
       FROM SITE_FEEDBACK f
       JOIN APP_USER u ON u.USER_ID = f.USER_ID
       ORDER BY f.CREATED_AT DESC`
    );
    res.json(result.rows);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to fetch feedback' });
  }
});

// Site admin: delete a feedback entry once it's been read/handled
app.delete('/admin/feedback/:id', requireAuth, requireSiteAdmin, async (req, res) => {
  try {
    await db.execute(
      `DELETE FROM SITE_FEEDBACK WHERE FEEDBACK_ID = :id`,
      { id: req.params.id }
    );
    res.json({ message: 'Feedback deleted' });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to delete feedback' });
  }
});

// --- Startup ---


const PORT = process.env.PORT || 3000;

async function start() {
  await db.initPool();
  app.listen(PORT, () => {
    console.log(`CineHive API listening on http://localhost:${PORT}`);
  });
}

start();

// Graceful shutdown
process.on('SIGINT', async () => {
  await db.closePool();
  process.exit(0);
});