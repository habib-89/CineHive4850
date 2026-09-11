// server.js — CineHive backend
require('dotenv').config();
const express = require('express');
const cors = require('cors');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const db = require('./db');

const app = express();
app.use(cors());
app.use(express.json());

const JWT_SECRET = process.env.JWT_SECRET;

// --- Auth routes ---

// Register a new user
// Expects JSON body: { username, email, password, dateOfBirth }
// --- Auth (updated) ---

// Register a new user — always as CUSTOMER, regardless of any role field sent
app.post('/auth/register', async (req, res) => {
  const { username, email, password, dateOfBirth } = req.body;

  if (!username || !email || !password) {
    return res.status(400).json({ error: 'username, email, and password are required' });
  }

  try {
    const passwordHash = await bcrypt.hash(password, 10);

    const result = await db.execute(
      `INSERT INTO APP_USER (USERNAME, EMAIL, PASSWORD_HASH, DATE_OF_BIRTH, DATE_JOINED, ROLE)
       VALUES (:username, :email, :passwordHash, :dateOfBirth, SYSDATE, 'CUSTOMER')
       RETURNING USER_ID INTO :userId`,
      {
        username,
        email,
        passwordHash,
        dateOfBirth: dateOfBirth || null,
        userId: { dir: db.oracledb.BIND_OUT, type: db.oracledb.NUMBER }
      }
    );
    const userId = result.outBinds.userId[0];

    const token = jwt.sign({ userId, username, role: 'CUSTOMER', cinemaId: null }, JWT_SECRET, { expiresIn: '7d' });
    res.status(201).json({ message: 'User registered', userId, role: 'CUSTOMER', cinemaId: null, token });
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
      `SELECT USER_ID, USERNAME, PASSWORD_HASH, ROLE, CINEMA_ID FROM APP_USER WHERE EMAIL = :email`,
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

// Middleware: only allow ADMIN role through
function requireAdmin(req, res, next) {
  if (req.user.role !== 'ADMIN') {
    return res.status(403).json({ error: 'Admin access required' });
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
app.get('/movies/search', async (req, res) => {
  const q = (req.query.q || '').trim();
  if (!q) {
    return res.json([]);
  }
  try {
    const result = await db.execute(
      `SELECT MOVIE_ID, TITLE, RELEASE_DATE, DURATION, LANGUAGE, POSTER_URL, BACKDROP_URL
       FROM MOVIE
       WHERE UPPER(TITLE) LIKE UPPER('%' || :q || '%')
       ORDER BY RELEASE_DATE DESC
       FETCH FIRST 20 ROWS ONLY`,
      { q }
    );
    res.json(result.rows);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to search movies' });
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
      `SELECT s.SEAT_ID, s.ROW_NUMBER, s.SEAT_NUMBER, s.SEAT_TYPE
       FROM SEAT s
       JOIN SHOWTIME st ON st.SCREEN_ID = s.SCREEN_ID
       WHERE st.SHOWTIME_ID = :id
         AND s.SEAT_ID NOT IN (
           SELECT bs.SEAT_ID FROM BOOKING_SEAT bs
           JOIN BOOKING b ON b.BOOKING_ID = bs.BOOKING_ID
           WHERE bs.SHOWTIME_ID = :id AND b.PAYMENT_STATUS != 'REFUNDED'
         )
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
app.post('/bookings', requireAuth, async (req, res) => {
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
app.get('/watchlist', requireAuth, async (req, res) => {
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
app.post('/watchlist', requireAuth, async (req, res) => {
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
app.delete('/watchlist/:movieId', requireAuth, async (req, res) => {
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
app.post('/movies/:id/reviews', requireAuth, async (req, res) => {
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
app.get('/bookings/me', requireAuth, async (req, res) => {
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
app.post('/bookings/:id/cancel', requireAuth, async (req, res) => {
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
app.get('/admin/me', requireAuth, requireAdmin, async (req, res) => {
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
app.get('/admin/screens', requireAuth, requireAdmin, async (req, res) => {
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
app.get('/admin/genres', requireAuth, requireAdmin, async (req, res) => {
  try {
    const result = await db.execute(`SELECT GENRE_ID, GENRE_NAME FROM GENRE ORDER BY GENRE_NAME`);
    res.json(result.rows);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to fetch genres' });
  }
});

// Add a new movie to the shared catalog (any admin can add — movies aren't cinema-owned)
// Expects: { title, releaseDate, duration, language, description, trailerUrl, posterUrl,
//            genreIds: [1,2], directorName, castNames: ["Name One", "Name Two"] }
app.post('/admin/movies', requireAuth, requireAdmin, async (req, res) => {
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

// Get showtimes for the admin's own cinema
app.get('/admin/showtimes', requireAuth, requireAdmin, async (req, res) => {
  try {
    const result = await db.execute(
      `SELECT st.SHOWTIME_ID, st.MOVIE_ID, m.TITLE, st.SCREEN_ID, sc.SCREEN_NAME,
              st.SHOW_DATE, st.START_TIME, st.END_TIME, st.TICKET_PRICE
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

// Add a showtime on one of the admin's own screens
// Expects: { movieId, screenId, showDate, startTime, ticketPrice }
// showDate: 'YYYY-MM-DD', startTime: 'YYYY-MM-DD HH24:MI'
app.post('/admin/showtimes', requireAuth, requireAdmin, async (req, res) => {
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
app.put('/admin/showtimes/:id', requireAuth, requireAdmin, async (req, res) => {
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
app.delete('/admin/showtimes/:id', requireAuth, requireAdmin, async (req, res) => {
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