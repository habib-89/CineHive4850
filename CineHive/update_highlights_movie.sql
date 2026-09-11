UPDATE MOVIE SET IS_FEATURED = 1 WHERE TITLE IN (
  'Avengers: Endgame',
  'Inception',
  'King Kong',
  'Interstellar',
  'Dune: Part Two'
);
COMMIT;