import { useEffect, useRef, useState } from 'react';
import { api } from '../api';

const ROTATE_INTERVAL_MS = 6000;

export default function MovieList({ onSelectMovie }) {
  const [trending, setTrending] = useState([]);
  const [heroIndex, setHeroIndex] = useState(0);
  const [heroCast, setHeroCast] = useState([]);
  const [genreRows, setGenreRows] = useState([]);
  const [error, setError] = useState('');
  const [loading, setLoading] = useState(true);
  const timerRef = useRef(null);

  useEffect(() => {
    Promise.all([api.getFeaturedMovies(), api.getCatalogByGenre()])
      .then(([featuredMovies, byGenre]) => {
        setTrending(featuredMovies);
        setGenreRows(byGenre);
      })
      .catch((err) => setError(err.message))
      .finally(() => setLoading(false));
  }, []);

  // Auto-rotate the hero
  useEffect(() => {
    if (trending.length <= 1) return;
    timerRef.current = setInterval(() => {
      setHeroIndex((i) => (i + 1) % trending.length);
    }, ROTATE_INTERVAL_MS);
    return () => clearInterval(timerRef.current);
  }, [trending.length]);

  // Fetch cast for whichever hero is currently showing
  useEffect(() => {
    const current = trending[heroIndex];
    if (!current) return;
    api.getCast(current.MOVIE_ID).then(setHeroCast).catch(() => setHeroCast([]));
  }, [trending, heroIndex]);

  function goToHero(i) {
    setHeroIndex(i);
    clearInterval(timerRef.current);
    if (trending.length > 1) {
      timerRef.current = setInterval(() => {
        setHeroIndex((prev) => (prev + 1) % trending.length);
      }, ROTATE_INTERVAL_MS);
    }
  }

  if (loading) return <p>Loading movies...</p>;
  if (error) return <p className="error">{error}</p>;

  const featured = trending[heroIndex];

  return (
    <div>
      {featured && (
        <div
          className="spotlight-hero"
          style={(featured.BACKDROP_URL || featured.POSTER_URL) ? { backgroundImage: `url(${featured.BACKDROP_URL || featured.POSTER_URL})` } : undefined}
        >
          <div className="spotlight-scrim" />
          <div className="spotlight-content spotlight-fade">
            <span className="spotlight-badge">
              {new Date(featured.RELEASE_DATE).getFullYear()} &middot; {featured.DURATION}m &middot; {featured.LANGUAGE}
            </span>
            <h1 className="spotlight-title">{featured.TITLE}</h1>
            <p className="spotlight-description">{featured.DESCRIPTION}</p>
            {heroCast.length > 0 && (
              <p className="spotlight-cast">
                Starring {heroCast.slice(0, 3).map((c) => c.ACTOR_NAME).join(', ')}
              </p>
            )}
            <button className="btn-watch" onClick={() => onSelectMovie(featured.MOVIE_ID)}>
              <span className="play-icon">&#9654;</span> View Movie
            </button>
          </div>

          {trending.length > 1 && (
            <div className="hero-dots">
              {trending.map((m, i) => (
                <button
                  key={m.MOVIE_ID}
                  className={`hero-dot ${i === heroIndex ? 'active' : ''}`}
                  onClick={() => goToHero(i)}
                  aria-label={`Show ${m.TITLE}`}
                />
              ))}
            </div>
          )}
        </div>
      )}

      {genreRows.map((row) => (
        <div key={row.genreId} className="genre-row">
          <div className="section-heading">
            <h2>{row.genreName}</h2>
            <span className="count">{row.movies.length} titles</span>
          </div>
          <div className="carousel-row">
            {row.movies.map((movie) => (
              <div key={movie.MOVIE_ID} className="carousel-card" onClick={() => onSelectMovie(movie.MOVIE_ID)}>
                {movie.POSTER_URL && <img src={movie.POSTER_URL} alt={movie.TITLE} className="carousel-poster" />}
                <span className="carousel-title">{movie.TITLE}</span>
              </div>
            ))}
          </div>
        </div>
      ))}
    </div>
  );
}