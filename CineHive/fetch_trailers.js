// fetch_trailers.js — looks up each CineHive movie title on TMDB and writes
// SQL UPDATE statements with the real YouTube trailer URL.
//
// Usage:
//   1. Uses the same TMDB_API_KEY env var / hardcoded key as fetch_posters.js
//   2. node fetch_trailers.js
//   3. Run the generated trailer_updates.sql in Navicat (CINEHIVE schema)

const fs = require('fs');

const API_KEY = process.env.TMDB_API_KEY || '56e6353783e77b6132e4862f438b0340';
const titles = JSON.parse(fs.readFileSync('./movie_titles.json', 'utf8'));

function esc(s) {
  return s.replace(/'/g, "''");
}

// Alternate titles for movies TMDB indexes under a different English title
const alternateTitles = {
  "The Grand Illusion": "Grand Illusion",
  "Sonar Kella": "The Golden Fortress",
  "Titas Ekti Nadir Naam": "A River Called Titas",
};

async function findMovieId(title) {
  const url = `https://api.themoviedb.org/3/search/movie?api_key=${API_KEY}&query=${encodeURIComponent(title)}&include_adult=false&language=en-US`;
  const res = await fetch(url);
  if (!res.ok) return null;
  const data = await res.json();
  if (!data.results || data.results.length === 0) return null;
  return data.results[0].id;
}

async function lookupTrailer(title) {
  let movieId = await findMovieId(title);
  if (!movieId && alternateTitles[title]) {
    movieId = await findMovieId(alternateTitles[title]);
  }
  if (!movieId) return null;

  const url = `https://api.themoviedb.org/3/movie/${movieId}/videos?api_key=${API_KEY}&language=en-US`;
  const res = await fetch(url);
  if (!res.ok) return null;
  const data = await res.json();
  if (!data.results || data.results.length === 0) return null;

  // Prefer an official YouTube "Trailer", fall back to any YouTube video
  const trailer =
    data.results.find((v) => v.site === 'YouTube' && v.type === 'Trailer' && v.official) ||
    data.results.find((v) => v.site === 'YouTube' && v.type === 'Trailer') ||
    data.results.find((v) => v.site === 'YouTube');

  if (!trailer) return null;
  return `https://www.youtube.com/watch?v=${trailer.key}`;
}

async function main() {
  const updates = [];
  const notFound = [];

  for (const title of titles) {
    try {
      const trailerUrl = await lookupTrailer(title);
      if (trailerUrl) {
        updates.push(`UPDATE MOVIE SET TRAILER_URL = '${esc(trailerUrl)}' WHERE TITLE = '${esc(title)}';`);
        console.log(`✓ ${title} -> ${trailerUrl}`);
      } else {
        notFound.push(title);
        console.log(`✗ ${title} — no trailer found on TMDB`);
      }
    } catch (err) {
      notFound.push(title);
      console.log(`✗ ${title} — error: ${err.message}`);
    }
    // Two calls per title (search + videos), so a slightly longer delay
    await new Promise((r) => setTimeout(r, 350));
  }

  updates.push('COMMIT;');
  fs.writeFileSync('./trailer_updates.sql', updates.join('\n'));

  console.log(`\nDone. ${updates.length - 1} trailers found, ${notFound.length} not found.`);
  if (notFound.length > 0) {
    console.log('Not found (left as placeholder, update manually if needed):', notFound.join(', '));
  }
  console.log('Wrote trailer_updates.sql — run it in Navicat against CINEHIVE.');
}

main();