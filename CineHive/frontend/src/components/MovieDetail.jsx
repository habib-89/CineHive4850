import { useEffect, useState } from 'react';
import { api } from '../api';

// Pulls the YouTube video ID out of a full watch URL,
// e.g. "https://www.youtube.com/watch?v=abc123" -> "abc123"
// Returns null for missing/placeholder trailer URLs so the button can hide itself.
function getYouTubeId(url) {
  if (!url) return null;
  try {
    const id = new URL(url).searchParams.get('v');
    if (!id || id === 'placeholder') return null;
    return id;
  } catch {
    return null;
  }
}

function formatMoney(value) {
  if (value == null) return null;
  const n = Number(value);
  if (Number.isNaN(n)) return null;
  if (n >= 1_000_000_000) return `\u09f3${(n / 1_000_000_000).toFixed(1)}B`;
  if (n >= 1_000_000) return `\u09f3${(n / 1_000_000).toFixed(1)}M`;
  return `\u09f3${n.toLocaleString()}`;
}

function seatsLeftLabel(st) {
  if (st.TOTAL_SEATS == null) return null;
  const left = Math.max(0, st.TOTAL_SEATS - (st.SEATS_BOOKED ?? 0));
  const lowThreshold = Math.max(5, Math.round(st.TOTAL_SEATS * 0.1));
  if (left === 0) return { text: 'Sold out', cls: 'seats-remaining-full' };
  if (left <= lowThreshold) return { text: `Almost full \u00b7 ${left} left`, cls: 'seats-remaining-low' };
  return { text: `${left} seats left`, cls: 'seats-remaining-ok' };
}

export default function MovieDetail({ movieId, onSelectShowtime, onSelectPerson, onBack, readOnly }) {
  const [movie, setMovie] = useState(null);
  const [showtimes, setShowtimes] = useState([]);
  const [cast, setCast] = useState([]);
  const [directors, setDirectors] = useState([]);
  const [genres, setGenres] = useState([]);
  const [rating, setRating] = useState(null);
  const [reviews, setReviews] = useState([]);
  const [inWatchlist, setInWatchlist] = useState(false);
  const [reviewText, setReviewText] = useState('');
  const [error, setError] = useState('');
  const [submittingReview, setSubmittingReview] = useState(false);
  const [showTrailer, setShowTrailer] = useState(false);

  useEffect(() => {
    setError('');
    Promise.all([
      api.getMovie(movieId),
      api.getShowtimes(movieId),
      api.getCast(movieId),
      api.getMovieDirectors(movieId),
      api.getMovieGenres(movieId),
      api.getRating(movieId),
      api.getReviews(movieId),
    ])
      .then(([movieData, showtimeData, castData, directorData, genreData, ratingData, reviewData]) => {
        setMovie(movieData);
        setShowtimes(showtimeData);
        setCast(castData);
        setDirectors(directorData);
        setGenres(genreData);
        setRating(ratingData);
        setReviews(reviewData);
      })
      .catch((err) => setError(err.message));

    if (!readOnly && api.isLoggedIn()) {
      api.getWatchlist()
        .then((list) => setInWatchlist(list.some((m) => m.MOVIE_ID === Number(movieId))))
        .catch(() => {});
    }

    setShowTrailer(false);
  }, [movieId]);

  // Close the trailer modal on Escape
  useEffect(() => {
    if (!showTrailer) return;
    function handleKey(e) {
      if (e.key === 'Escape') setShowTrailer(false);
    }
    window.addEventListener('keydown', handleKey);
    return () => window.removeEventListener('keydown', handleKey);
  }, [showTrailer]);

  async function toggleWatchlist() {
    try {
      if (inWatchlist) {
        await api.removeFromWatchlist(movieId);
        setInWatchlist(false);
      } else {
        await api.addToWatchlist(movieId);
        setInWatchlist(true);
      }
    } catch (err) {
      setError(err.message);
    }
  }

  async function handleRate(value) {
    try {
      await api.setRating(movieId, value);
      const updated = await api.getRating(movieId);
      setRating(updated);
    } catch (err) {
      setError(err.message);
    }
  }

  async function handleReviewSubmit(e) {
    e.preventDefault();
    if (!reviewText.trim()) return;
    setSubmittingReview(true);
    try {
      await api.postReview(movieId, reviewText);
      const updated = await api.getReviews(movieId);
      setReviews(updated);
      setReviewText('');
    } catch (err) {
      setError(err.message);
    } finally {
      setSubmittingReview(false);
    }
  }

  function scrollToShowtimes() {
    document.getElementById('showtimes-section')?.scrollIntoView({ behavior: 'smooth' });
  }

  if (error && !movie) return <p className="error">{error}</p>;
  if (!movie) return <p>Loading...</p>;

  const upcomingPreview = showtimes.slice(0, 3);
  const trailerId = getYouTubeId(movie.TRAILER_URL);

  // Group showtimes by cinema so each venue shows once with its screens/times underneath.
  const showtimesByCinema = showtimes.reduce((acc, st) => {
    const key = st.CINEMA_NAME || 'Unknown Cinema';
    (acc[key] ||= { cinemaName: st.CINEMA_NAME, city: st.CITY, shows: [] }).shows.push(st);
    return acc;
  }, {});

  const budgetLabel = formatMoney(movie.BUDGET);
  const boxOfficeLabel = formatMoney(movie.BOX_OFFICE);

  return (
    <div className="movie-detail">
      <button className="back-button" onClick={onBack}>&larr; All movies</button>

      {/* ===== Hero banner ===== */}
      <div
        className="hero-banner"
       style={(movie.BACKDROP_URL || movie.POSTER_URL) ? { backgroundImage: `url(${movie.BACKDROP_URL || movie.POSTER_URL})` } : undefined}
      >
        <div className="hero-scrim" />
        <div className="hero-content">
          <div className="hero-main">
            <span className="hero-badge">{movie.LANGUAGE} &middot; {movie.DURATION} min</span>
            <h1 className="hero-title">{movie.TITLE}</h1>

            {directors.length > 0 && (
              <p className="hero-directed-by">
                Directed by{' '}
                {directors.map((d, i) => (
                  <span key={d.DIRECTOR_ID}>
                    <button className="link-button inline" onClick={() => onSelectPerson(d.DIRECTOR_ID, 'director')}>
                      {d.DIRECTOR_NAME}
                    </button>
                    {i < directors.length - 1 ? ', ' : ''}
                  </span>
                ))}
              </p>
            )}

            <p className="hero-description">{movie.DESCRIPTION}</p>

            {rating && (
              <div className="hero-rating">
                <span className="hero-star">&#9733;</span>
                <div className="hero-rating-text">
                  <span className="hero-rating-label">Rating</span>
                  <span className="hero-rating-value">{rating.AVG_RATING ?? '—'}<span className="out-of">/10</span></span>
                </div>
                <span className="hero-rating-count">({rating.RATING_COUNT ?? 0})</span>
              </div>
            )}

            {api.isLoggedIn() && rating && (
              <div className="rate-stars hero-rate-stars">
                {Array.from({ length: 10 }).map((_, i) => (
                  <button
                    key={i}
                    className={`star ${rating.myRating && i < rating.myRating ? 'filled' : ''}`}
                    onClick={() => handleRate(i + 1)}
                    title={`Rate ${i + 1}/10`}
                  >
                    &#9733;
                  </button>
                ))}
              </div>
            )}

            <div className="hero-actions">
              {trailerId && (
                <button className="btn-trailer" onClick={() => setShowTrailer(true)}>
                  <span className="play-icon">&#9654;</span> Watch Trailer
                </button>
              )}
              {!readOnly && (
                <button className="btn-watch" onClick={scrollToShowtimes}>
                  <span className="play-icon">&#9654;</span> Book Tickets
                </button>
              )}
              {!readOnly && api.isLoggedIn() && (
                <button className={`btn-add-list ${inWatchlist ? 'active' : ''}`} onClick={toggleWatchlist}>
                  <span>{inWatchlist ? '✓' : '+'}</span> {inWatchlist ? 'In Watchlist' : 'Add to Watchlist'}
                </button>
              )}
            </div>
          </div>

          {!readOnly && upcomingPreview.length > 0 && (
            <div className="hero-side-rail">
              {upcomingPreview.map((st) => (
                <button key={st.SHOWTIME_ID} className="hero-thumb" onClick={() => onSelectShowtime(st.SHOWTIME_ID)}>
                  {movie.POSTER_URL && <img src={movie.POSTER_URL} alt="" />}
                  <span className="hero-thumb-overlay">
                    <span className="ticket-icon">&#127903;</span>
                  </span>
                  <span className="hero-thumb-info">
                    <span>{new Date(st.SHOW_DATE).toLocaleDateString(undefined, { month: 'short', day: 'numeric' })}</span>
                    <span>{new Date(st.START_TIME).toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })}</span>
                  </span>
                </button>
              ))}
            </div>
          )}
        </div>
      </div>

      {/* ===== Trailer modal ===== */}
      {showTrailer && trailerId && (
        <div className="trailer-modal-backdrop" onClick={() => setShowTrailer(false)}>
          <div className="trailer-modal" onClick={(e) => e.stopPropagation()}>
            <button
              className="trailer-modal-close"
              onClick={() => setShowTrailer(false)}
              aria-label="Close trailer"
            >
              &times;
            </button>
            <div className="trailer-modal-frame">
              <iframe
                src={`https://www.youtube.com/embed/${trailerId}?autoplay=1`}
                title={`${movie.TITLE} trailer`}
                allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
                allowFullScreen
              />
            </div>
          </div>
        </div>
      )}

      {/* ===== Movie Info panel ===== */}
      <div className="movie-info-panel">
        <div className="movie-info-panel-header">Movie Info</div>
        <div className="movie-info-grid">
          <div className="movie-info-item">
            <span className="movie-info-label">Release Date</span>
            <span className="movie-info-value">
              {movie.RELEASE_DATE ? new Date(movie.RELEASE_DATE).toLocaleDateString(undefined, { day: '2-digit', month: 'short', year: 'numeric' }) : '—'}
            </span>
          </div>
          <div className="movie-info-item">
            <span className="movie-info-label">Duration</span>
            <span className="movie-info-value">{movie.DURATION ? `${movie.DURATION} min` : '—'}</span>
          </div>
          <div className="movie-info-item">
            <span className="movie-info-label">Language</span>
            <span className="movie-info-value">{movie.LANGUAGE || '—'}</span>
          </div>
          <div className="movie-info-item">
            <span className="movie-info-label">Budget</span>
            <span className="movie-info-value">{budgetLabel || '—'}</span>
          </div>
          <div className="movie-info-item">
            <span className="movie-info-label">Box Office</span>
            <span className="movie-info-value">{boxOfficeLabel || '—'}</span>
          </div>
          <div className="movie-info-item movie-info-item-genres">
            <span className="movie-info-label">Genres</span>
            <span className="movie-info-value">
              {genres.length > 0 ? genres.map((g) => g.GENRE_NAME).join(' \u00b7 ') : '—'}
            </span>
          </div>
        </div>
      </div>

      {/* ===== Cast ===== */}
      {cast.length > 0 && (
        <>
          <div className="section-heading"><h2>Cast</h2></div>
          <div className="person-strip">
            {cast.map((c) => (
              <div key={c.ACTOR_ID} className="person-chip" onClick={() => onSelectPerson(c.ACTOR_ID, 'actor')}>
                {c.PHOTO_URL && <img src={c.PHOTO_URL} alt={c.ACTOR_NAME} />}
                <span className="person-chip-name">{c.ACTOR_NAME}</span>
                <span className="person-chip-role">{c.ROLE}</span>
              </div>
            ))}
          </div>
        </>
      )}

      {/* ===== Showtimes, grouped by cinema ===== */}
      {!readOnly && (
        <>
          <div id="showtimes-section" className="section-heading"><h2>Showtimes</h2></div>
          {showtimes.length === 0 && <p className="movie-meta">No showtimes scheduled.</p>}

          {Object.values(showtimesByCinema).map((group) => (
            <div key={group.cinemaName} className="cinema-showtime-group">
              <div className="cinema-showtime-header">
                <span className="cinema-showtime-name">{group.cinemaName}</span>
                {group.city && <span className="cinema-showtime-city">{group.city}</span>}
              </div>
              <div className="showtime-list">
                {group.shows.map((st) => {
                  const left = seatsLeftLabel(st);
                  return (
                    <button key={st.SHOWTIME_ID} className="ticket-stub" onClick={() => onSelectShowtime(st.SHOWTIME_ID)}>
                      <div className="ticket-main">
                        <span className="ticket-screen">{st.SCREEN_NAME}</span>
                        <span className="ticket-date">
                          {new Date(st.SHOW_DATE).toLocaleDateString(undefined, { month: 'short', day: 'numeric' })}
                        </span>
                        <span className="ticket-time">
                          {new Date(st.START_TIME).toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })}
                        </span>
                        {left && <span className={`ticket-seats-left ${left.cls}`}>{left.text}</span>}
                      </div>
                      <div className="ticket-perforation" />
                      <div className="ticket-price">৳{st.TICKET_PRICE}</div>
                    </button>
                  );
                })}
              </div>
            </div>
          ))}
        </>
      )}

      {/* ===== Reviews ===== */}
      <div className="section-heading"><h2>Reviews</h2></div>
      {!readOnly && api.isLoggedIn() && (
        <form onSubmit={handleReviewSubmit} className="review-form">
          <textarea
            placeholder="Share your thoughts..."
            value={reviewText}
            onChange={(e) => setReviewText(e.target.value)}
            rows={3}
          />
          <button className="btn-primary" disabled={submittingReview || !reviewText.trim()}>
            {submittingReview ? 'Posting...' : 'Post Review'}
          </button>
        </form>
      )}
      {error && <p className="error">{error}</p>}
      <div className="review-list">
        {reviews.length === 0 && <p className="movie-meta">No reviews yet.</p>}
        {reviews.map((r) => (
          <div key={r.REVIEW_ID} className="review-item">
            <div className="review-item-header">
              <span className="review-username">{r.USERNAME}</span>
              <span className="review-date">{new Date(r.REVIEW_DATE).toLocaleDateString()}</span>
            </div>
            <p>{r.REVIEW_TEXT}</p>
          </div>
        ))}
      </div>
    </div>
  );
}