// create_admins.js — creates one ADMIN account per row in CINEMA.
// Run once. Safe to re-run: skips cinemas that already have an admin.
//
// Usage: node create_admins.js
// Prints each admin's email/password so you can log in and test.

require('dotenv').config();
const oracledb = require('oracledb');
const bcrypt = require('bcryptjs');

oracledb.outFormat = oracledb.OUT_FORMAT_OBJECT;

async function main() {
  const pool = await oracledb.createPool({
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    connectString: process.env.DB_CONNECT_STRING,
  });
  const conn = await pool.getConnection();

  const cinemasResult = await conn.execute(`SELECT CINEMA_ID, CINEMA_NAME FROM CINEMA ORDER BY CINEMA_ID`);

  for (const cinema of cinemasResult.rows) {
    const existing = await conn.execute(
      `SELECT USER_ID FROM APP_USER WHERE ROLE = 'ADMIN' AND CINEMA_ID = :cinemaId`,
      { cinemaId: cinema.CINEMA_ID }
    );
    if (existing.rows.length > 0) {
      console.log(`Skipping ${cinema.CINEMA_NAME} — already has an admin.`);
      continue;
    }

    const slug = cinema.CINEMA_NAME.toLowerCase().replace(/[^a-z0-9]+/g, '');
    const email = `admin.${slug}@cinehive.com`;
    const username = `admin_${slug}`;
    const password = 'ChangeMe123!'; // change after first login
    const passwordHash = await bcrypt.hash(password, 10);

    await conn.execute(
      `INSERT INTO APP_USER (USERNAME, EMAIL, PASSWORD_HASH, DATE_JOINED, ROLE, CINEMA_ID)
       VALUES (:username, :email, :passwordHash, SYSDATE, 'ADMIN', :cinemaId)`,
      { username, email, passwordHash, cinemaId: cinema.CINEMA_ID },
      { autoCommit: true }
    );

    console.log(`Created admin for ${cinema.CINEMA_NAME}:`);
    console.log(`  email:    ${email}`);
    console.log(`  password: ${password}\n`);
  }

  await conn.close();
  await pool.close();
  console.log('Done.');
}

main().catch(console.error);