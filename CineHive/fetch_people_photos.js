// fetch_people_photos.js — looks up each CineHive actor/director on TMDB and
// writes SQL UPDATE statements with their real profile photo URL.
//
// Usage:
//   1. Reuse the same TMDB_API_KEY as fetch_posters.js
//   2. node fetch_people_photos.js
//   3. Run the generated people_photo_updates.sql in Navicat (CINEHIVE schema)

const fs = require('fs');

const API_KEY = process.env.TMDB_API_KEY || '56e6353783e77b6132e4862f438b0340';
const { actors, directors } = JSON.parse(fs.readFileSync('./people_names.json', 'utf8'));

function esc(s) {
  return s.replace(/'/g, "''");
}

async function lookupPhoto(name) {
  const url = `https://api.themoviedb.org/3/search/person?api_key=${API_KEY}&query=${encodeURIComponent(name)}`;
  const res = await fetch(url);
  const data = await res.json();
  if (!data.results || data.results.length === 0 || !data.results[0].profile_path) {
    return null;
  }
  return `https://image.tmdb.org/t/p/w500${data.results[0].profile_path}`;
}

async function processGroup(names, tableName, nameColumn) {
  const updates = [];
  const notFound = [];

  for (const name of names) {
    try {
      const photoUrl = await lookupPhoto(name);
      if (photoUrl) {
        updates.push(`UPDATE ${tableName} SET PHOTO_URL = '${esc(photoUrl)}' WHERE ${nameColumn} = '${esc(name)}';`);
        console.log(`✓ [${tableName}] ${name}`);
      } else {
        notFound.push(name);
        console.log(`✗ [${tableName}] ${name} — no photo found`);
      }
    } catch (err) {
      notFound.push(name);
      console.log(`✗ [${tableName}] ${name} — error: ${err.message}`);
    }
    await new Promise((r) => setTimeout(r, 250));
  }

  return { updates, notFound };
}

async function main() {
  const actorResult = await processGroup(actors, 'ACTOR', 'ACTOR_NAME');
  const directorResult = await processGroup(directors, 'DIRECTOR', 'DIRECTOR_NAME');

  const allUpdates = [...actorResult.updates, ...directorResult.updates, 'COMMIT;'];
  fs.writeFileSync('./people_photo_updates.sql', allUpdates.join('\n'));

  const allNotFound = [...actorResult.notFound, ...directorResult.notFound];
  console.log(`\nDone. ${allUpdates.length - 1} photos found, ${allNotFound.length} not found.`);
  if (allNotFound.length > 0) {
    console.log('Not found:', allNotFound.join(', '));
  }
  console.log('Wrote people_photo_updates.sql — run it in Navicat against CINEHIVE.');
}

main();