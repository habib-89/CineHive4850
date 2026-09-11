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

export default function MovieDetail({ movieId, onSelectShowtime, onSelectPerson, onBack }) {
  const [movie, setMovie] = useState(null);
  const [showtimes, setShowtimes] = useState([]);
  const [cast, setCast] = useState([]);
  const [directors, setDirectors] = useState([]);
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
      api.getRating(movieId),
      api.getReviews(movieId),
    ])
      .then(([movieData, showtimeData, castData, directorData, ratingData, reviewData]) => {
        setMovie(movieData);
        setShowtimes(showtimeData);
        setCast(castData);
        setDirectors(directorData);
        setRating(ratingData);
        setReviews(reviewData);
      })
      .catch((err) => setError(err.message));

    if (api.isLoggedIn()) {
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
              <button className="btn-watch" onClick={scrollToShowtimes}>
                <span className="play-icon">&#9654;</span> Book Tickets
              </button>
              {api.isLoggedIn() && (
                <button className={`btn-add-list ${inWatchlist ? 'active' : ''}`} onClick={toggleWatchlist}>
                  <span>{inWatchlist ? '✓' : '+'}</span> {inWatchlist ? 'In Watchlist' : 'Add to Watchlist'}
                </button>
              )}
            </div>
          </div>

          {upcomingPreview.length > 0 && (
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

      {/* ===== Showtimes ===== */}
      <div id="showtimes-section" className="section-heading"><h2>Showtimes</h2></div>
      {showtimes.length === 0 && <p className="movie-meta">No showtimes scheduled.</p>}
      <div className="showtime-list">
        {showtimes.map((st) => (
          <button key={st.SHOWTIME_ID} className="ticket-stub" onClick={() => onSelectShowtime(st.SHOWTIME_ID)}>
            <div className="ticket-main">
              <span className="ticket-date">
                {new Date(st.SHOW_DATE).toLocaleDateString(undefined, { month: 'short', day: 'numeric' })}
              </span>
              <span className="ticket-time">
                {new Date(st.START_TIME).toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })}
              </span>
            </div>
            <div className="ticket-perforation" />
            <div className="ticket-price">${st.TICKET_PRICE}</div>
          </button>
        ))}
      </div>

      {/* ===== Reviews ===== */}
      <div className="section-heading"><h2>Reviews</h2></div>
      {api.isLoggedIn() && (
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