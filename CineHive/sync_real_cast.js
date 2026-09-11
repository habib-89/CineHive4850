// sync_real_cast.js — for every movie in the database, look up its real
// director(s) and top cast on TMDB and populate DIRECTS / ACTS_IN.
// Reuses existing ACTOR/DIRECTOR rows when the name matches; adds new
// people as needed.
//
// Usage:
//   1. Run this SQL first (keeps ACTOR/DIRECTOR, clears only the links):
//        DELETE FROM ACTS_IN;
//        DELETE FROM DIRECTS;
//        COMMIT;
//   2. Put this file in your backend folder (where .env and db.js live)
//   3. node sync_real_cast.js
//   4. Takes a few minutes for ~258 movies (rate-limited to be polite to TMDB)

require('dotenv').config();
const oracledb = require('oracledb');

const TMDB_KEY = process.env.TMDB_API_KEY || 'PASTE_YOUR_TMDB_API_KEY_HERE';
oracledb.outFormat = oracledb.OUT_FORMAT_OBJECT;

async function main() {
  const pool = await oracledb.createPool({
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    connectString: process.env.DB_CONNECT_STRING,
  });
  const conn = await pool.getConnection();

  const moviesResult = await conn.execute(`SELECT MOVIE_ID, TITLE, RELEASE_DATE FROM MOVIE ORDER BY MOVIE_ID`);
  const movies = moviesResult.rows;
  console.log(`Found ${movies.length} movies to process.\n`);

  // Preload existing people so we reuse rows instead of creating duplicates
  const actorCache = new Map();
  const directorCache = new Map();
  const existingActors = await conn.execute(`SELECT ACTOR_ID, ACTOR_NAME FROM ACTOR`);
  for (const row of existingActors.rows) actorCache.set(row.ACTOR_NAME.toLowerCase(), row.ACTOR_ID);
  const existingDirectors = await conn.execute(`SELECT DIRECTOR_ID, DIRECTOR_NAME FROM DIRECTOR`);
  for (const row of existingDirectors.rows) directorCache.set(row.DIRECTOR_NAME.toLowerCase(), row.DIRECTOR_ID);

  let okCount = 0;
  let missCount = 0;

  for (const movie of movies) {
    try {
      const year = movie.RELEASE_DATE ? new Date(movie.RELEASE_DATE).getFullYear() : '';
      const searchUrl = `https://api.themoviedb.org/3/search/movie?api_key=${TMDB_KEY}&query=${encodeURIComponent(movie.TITLE)}${year ? `&year=${year}` : ''}`;
      const searchRes = await fetch(searchUrl);
      const searchData = await searchRes.json();
      const tmdbMovie = searchData.results?.[0];

      if (!tmdbMovie) {
        console.log(`✗ ${movie.TITLE} — not found on TMDB`);
        missCount++;
        continue;
      }

      const creditsRes = await fetch(`https://api.themoviedb.org/3/movie/${tmdbMovie.id}/credits?api_key=${TMDB_KEY}`);
      const credits = await creditsRes.json();

      const directors = (credits.crew || []).filter((c) => c.job === 'Director').slice(0, 2);
      const cast = (credits.cast || []).slice(0, 5);

      for (const d of directors) {
        const key = d.name.toLowerCase();
        let directorId = directorCache.get(key);
        if (!directorId) {
          const photo = d.profile_path ? `https://image.tmdb.org/t/p/w500${d.profile_path}` : null;
          const insertRes = await conn.execute(
            `INSERT INTO DIRECTOR (DIRECTOR_NAME, PHOTO_URL) VALUES (:name, :photo) RETURNING DIRECTOR_ID INTO :id`,
            { name: d.name, photo, id: { dir: oracledb.BIND_OUT, type: oracledb.NUMBER } },
            { autoCommit: false }
          );
          directorId = insertRes.outBinds.id[0];
          directorCache.set(key, directorId);
        }
        try {
          await conn.execute(
            `INSERT INTO DIRECTS (DIRECTOR_ID, MOVIE_ID) VALUES (:d, :m)`,
            { d: directorId, m: movie.MOVIE_ID },
            { autoCommit: false }
          );
        } catch (e) { /* already linked, ignore */ }
      }

      for (const c of cast) {
        const key = c.name.toLowerCase();
        let actorId = actorCache.get(key);
        if (!actorId) {
          const photo = c.profile_path ? `https://image.tmdb.org/t/p/w500${c.profile_path}` : null;
          const insertRes = await conn.execute(
            `INSERT INTO ACTOR (ACTOR_NAME, PHOTO_URL) VALUES (:name, :photo) RETURNING ACTOR_ID INTO :id`,
            { name: c.name, photo, id: { dir: oracledb.BIND_OUT, type: oracledb.NUMBER } },
            { autoCommit: false }
          );
          actorId = insertRes.outBinds.id[0];
          actorCache.set(key, actorId);
        }
        try {
          await conn.execute(
            `INSERT INTO ACTS_IN (ACTOR_ID, MOVIE_ID, ROLE) VALUES (:a, :m, :r)`,
            { a: actorId, m: movie.MOVIE_ID, r: (c.character || '').slice(0, 149) || null },
            { autoCommit: false }
          );
        } catch (e) { /* already linked, ignore */ }
      }

      await conn.commit();
      console.log(`✓ ${movie.TITLE} — ${directors.length} director(s), ${cast.length} cast`);
      okCount++;
    } catch (err) {
      console.log(`✗ ${movie.TITLE} — error: ${err.message}`);
      missCount++;
    }
    await new Promise((r) => setTimeout(r, 300)); // stay well under TMDB rate limits
  }

  await conn.close();
  await pool.close();
  console.log(`\nDone. ${okCount} succeeded, ${missCount} missed.`);
}

main().catch(console.error);