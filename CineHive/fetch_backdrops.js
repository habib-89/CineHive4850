// fetch_backdrops.js — looks up each CineHive movie title on TMDB and writes
// SQL UPDATE statements with a real widescreen backdrop image URL.
//
// Usage:
//   1. Reuse the same TMDB_API_KEY as fetch_posters.js
//   2. Make sure movie_titles.json is in this same folder (from before)
//   3. node fetch_backdrops.js
//   4. Run the generated backdrop_updates.sql in Navicat (CINEHIVE schema)
//      -- but first run: ALTER TABLE MOVIE ADD BACKDROP_URL VARCHAR2(500);

const fs = require('fs');

const API_KEY = process.env.TMDB_API_KEY || '56e6353783e77b6132e4862f438b0340';

// Reuse the same title list as fetch_posters.js — if you deleted "The Revenant Returns"
// from your database, it's fine to leave it in this list; it'll just be skipped.
let titles;
try {
  titles = JSON.parse(fs.readFileSync('./movie_titles.json', 'utf8'));
} catch {
  console.error('movie_titles.json not found — copy it from your earlier fetch_posters.js setup, or list titles manually here.');
  process.exit(1);
}

function esc(s) {
  return s.replace(/'/g, "''");
}

async function lookupBackdrop(title) {
  const url = `https://api.themoviedb.org/3/search/movie?api_key=${API_KEY}&query=${encodeURIComponent(title)}`;
  const res = await fetch(url);
  const data = await res.json();
  if (!data.results || data.results.length === 0 || !data.results[0].backdrop_path) {
    return null;
  }
  // w1280 is a high-res landscape size, good for a full-width hero banner
  return `https://image.tmdb.org/t/p/w1280${data.results[0].backdrop_path}`;
}

async function main() {
  const updates = [];
  const notFound = [];

  for (const title of titles) {
    try {
      const backdropUrl = await lookupBackdrop(title);
      if (backdropUrl) {
        updates.push(`UPDATE MOVIE SET BACKDROP_URL = '${esc(backdropUrl)}' WHERE TITLE = '${esc(title)}';`);
        console.log(`✓ ${title}`);
      } else {
        notFound.push(title);
        console.log(`✗ ${title} — no backdrop found on TMDB`);
      }
    } catch (err) {
      notFound.push(title);
      console.log(`✗ ${title} — error: ${err.message}`);
    }
    await new Promise((r) => setTimeout(r, 250));
  }

  updates.push('COMMIT;');
  fs.writeFileSync('./backdrop_updates.sql', updates.join('\n'));

  console.log(`\nDone. ${updates.length - 1} backdrops found, ${notFound.length} not found.`);
  if (notFound.length > 0) {
    console.log('Not found:', notFound.join(', '));
  }
  console.log('Wrote backdrop_updates.sql — run it in Navicat against CINEHIVE.');
}

main();