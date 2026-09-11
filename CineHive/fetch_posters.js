// fetch_posters.js — looks up each CineHive movie title on TMDB and writes
// SQL UPDATE statements with the real poster image URL.
//
// Usage:
//   1. npm install (if node-fetch isn't available — Node 18+ has fetch built in, so likely no install needed)
//   2. Set your TMDB API key below or via env var TMDB_API_KEY
//   3. node fetch_posters.js
//   4. Run the generated poster_updates.sql in Navicat (CINEHIVE schema)

const fs = require('fs');

const API_KEY = process.env.TMDB_API_KEY || '56e6353783e77b6132e4862f438b0340';
const titles = JSON.parse(fs.readFileSync('./movie_titles.json', 'utf8'));

function esc(s) {
  return s.replace(/'/g, "''");
}

async function lookupPoster(title, year) {
  const url = `https://api.themoviedb.org/3/search/movie?api_key=${API_KEY}&query=${encodeURIComponent(title)}${year ? `&year=${year}` : ''}&include_adult=false&language=en-US`;
  const res = await fetch(url);

  if (!res.ok) {
    console.log(`  ⚠ HTTP ${res.status} for "${title}"`);
    return null;
  }

  const data = await res.json();
  if (!data.results || data.results.length === 0) {
    return null;
  }
  // Log the top match so you can visually confirm it's the right movie
  console.log(`  → matched "${data.results[0].title}" (${data.results[0].release_date})`);
  if (!data.results[0].poster_path) return null;
  return `https://image.tmdb.org/t/p/w500${data.results[0].poster_path}`;
}

async function main() {
  const updates = [];
  const notFound = [];

  for (const title of titles) {
    try {
      const posterUrl = await lookupPoster(title);
      if (posterUrl) {
        updates.push(`UPDATE MOVIE SET POSTER_URL = '${esc(posterUrl)}' WHERE TITLE = '${esc(title)}';`);
        console.log(`✓ ${title}`);
      } else {
        notFound.push(title);
        console.log(`✗ ${title} — no poster found on TMDB`);
      }
    } catch (err) {
      notFound.push(title);
      console.log(`✗ ${title} — error: ${err.message}`);
    }
    // Small delay to be polite to the API
    await new Promise((r) => setTimeout(r, 300));
  }

  updates.push('COMMIT;');
  fs.writeFileSync('./poster_updates.sql', updates.join('\n'));

  console.log(`\nDone. ${updates.length - 1} posters found, ${notFound.length} not found.`);
  if (notFound.length > 0) {
    console.log('Not found (left as placeholder, update manually if needed):', notFound.join(', '));
  }
  console.log('Wrote poster_updates.sql — run it in Navicat against CINEHIVE.');
}

main();