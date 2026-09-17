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

  const [cinemas, setCinemas] = useState([]);
  const [selectedCinemaId, setSelectedCinemaId] = useState('');
  const [nowShowing, setNowShowing] = useState([]);
  const [nowShowingLoading, setNowShowingLoading] = useState(true);
  const [nowShowingError, setNowShowingError] = useState('');

  useEffect(() => {
    Promise.all([api.getFeaturedMovies(), api.getCatalogByGenre(), api.getCinemas()])
      .then(([featuredMovies, byGenre, cinemaList]) => {
        setTrending(featuredMovies);
        setGenreRows(byGenre);
        setCinemas(cinemaList);
      })
      .catch((err) => setError(err.message))
      .finally(() => setLoading(false));
  }, []);

  // Load (or reload) the "Now Showing in Cinemas" rail whenever the cinema filter changes
  useEffect(() => {
    setNowShowingLoading(true);
    setNowShowingError('');
    api.getNowShowing(selectedCinemaId || undefined)
      .then(setNowShowing)
      .catch((err) => setNowShowingError(err.message))
      .finally(() => setNowShowingLoading(false));
  }, [selectedCinemaId]);

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

  function goToPrevHero() {
    goToHero((heroIndex - 1 + trending.length) % trending.length);
  }

  function goToNextHero() {
    goToHero((heroIndex + 1) % trending.length);
  }

  function cinemaLabel(cinemasForMovie) {
    if (cinemasForMovie.length === 1) return cinemasForMovie[0].CINEMA_NAME;
    const [first, ...rest] = cinemasForMovie;
    return `${first.CINEMA_NAME} +${rest.length} more`;
  }

  function formatShowtime(dateStr) {
    if (!dateStr) return null;
    const d = new Date(dateStr);
    if (Number.isNaN(d.getTime())) return null;

    const now = new Date();
    const tomorrow = new Date(now);
    tomorrow.setDate(now.getDate() + 1);

    const time = d.toLocaleTimeString([], { hour: 'numeric', minute: '2-digit' });

    if (d.toDateString() === now.toDateString()) return `Today, ${time}`;
    if (d.toDateString() === tomorrow.toDateString()) return `Tomorrow, ${time}`;
    return `${d.toLocaleDateString([], { weekday: 'short', month: 'short', day: 'numeric' })}, ${time}`;
  }

  if (loading) return <p>Loading movies...</p>;
  if (error) return <p className="error">{error}</p>;

  const featured = trending[heroIndex];

  return (
    <div className="home-layout">
      <main className="home-main-content">
        <div className="home-top-row">
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
              <>
                <button
                  className="hero-arrow hero-arrow-left"
                  onClick={goToPrevHero}
                  aria-label="Previous featured movie"
                >
                  &#10094;
                </button>
                <button
                  className="hero-arrow hero-arrow-right"
                  onClick={goToNextHero}
                  aria-label="Next featured movie"
                >
                  &#10095;
                </button>
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
              </>
            )}
          </div>
        )}

        </div>
      </main>

      <aside className="now-showing-panel" aria-label="Now Showing in Cinemas">
          <div className="now-showing-heading">
            <div>
              <h2>Now Showing in Cinemas</h2>
              <span className="count">{nowShowing.length} movies playing now</span>
            </div>
            {cinemas.length > 0 && (
              <select
                className="now-showing-cinema-select"
                value={selectedCinemaId}
                onChange={(e) => setSelectedCinemaId(e.target.value)}
              >
                <option value="">All Cinemas</option>
                {cinemas.map((c) => (
                  <option key={c.CINEMA_ID} value={c.CINEMA_ID}>{c.CINEMA_NAME} &middot; {c.CITY}</option>
                ))}
              </select>
            )}
          </div>

          {nowShowingError && <p className="error">{nowShowingError}</p>}
          {nowShowingLoading && <p className="movie-meta">Loading showtimes...</p>}

          {!nowShowingLoading && !nowShowingError && nowShowing.length === 0 && (
            <p className="movie-meta">
              {selectedCinemaId ? 'No movies currently scheduled at this cinema.' : 'No movies currently scheduled.'}
            </p>
          )}

          {!nowShowingLoading && nowShowing.length > 0 && (
            <div className="now-showing-list">
              {nowShowing.map((movie) => (
                <div
                  key={movie.MOVIE_ID}
                  className="now-showing-row-item"
                  onClick={() => onSelectMovie(movie.MOVIE_ID)}
                >
                  {movie.POSTER_URL
                    ? <img src={movie.POSTER_URL} alt={movie.TITLE} className="now-showing-row-poster" />
                    : <span className="now-showing-row-poster-placeholder" />}
                  <div className="now-showing-row-info">
                    <span className="now-showing-row-title">{movie.TITLE}</span>
                    <span className="now-showing-row-cinema" title={movie.CINEMAS.map((c) => c.CINEMA_NAME).join(', ')}>
                      &#127916; {cinemaLabel(movie.CINEMAS)}
                    </span>
                    {formatShowtime(movie.NEXT_SHOWTIME) && (
                      <span className="now-showing-row-showtime">
                        &#128337; {formatShowtime(movie.NEXT_SHOWTIME)}
                      </span>
                    )}
                  </div>
                  <span className="now-showing-row-cta">Book</span>
                </div>
              ))}
            </div>
          )}
      </aside>

      <div className="home-genre-rows">
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
    </div>
  );
}