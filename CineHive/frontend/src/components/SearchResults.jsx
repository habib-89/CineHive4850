import { useEffect, useState } from 'react';
import { api } from '../api';

export default function SearchResults({ query, genreId, genreName, onSelectMovie, onBack }) {
  const [results, setResults] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');

  const trimmedQuery = (query || '').trim();

  useEffect(() => {
    setLoading(true);
    setError('');
    api.searchMovies(trimmedQuery, genreId || undefined)
      .then(setResults)
      .catch((err) => setError(err.message))
      .finally(() => setLoading(false));
  }, [trimmedQuery, genreId]);

  // Three cases: title search within a genre, plain title search,
  // or browsing a genre with no typed query at all.
  const heading = trimmedQuery
    ? (genreName ? `Results for "${trimmedQuery}" in ${genreName}` : `Results for "${trimmedQuery}"`)
    : `${genreName || 'Filtered'} Movies`;

  const emptyMessage = trimmedQuery
    ? `No movies match "${trimmedQuery}"${genreName ? ` in ${genreName}` : ''}.`
    : `No ${genreName || 'matching'} movies found.`;

  return (
    <div>
      <button className="back-button" onClick={onBack}>&larr; Back to Browsing</button>

      <div className="section-heading">
        <h2>{heading}</h2>
        {!loading && !error && <span className="count">{results.length} found</span>}
      </div>

      {loading && <p>Searching...</p>}
      {error && <p className="error">{error}</p>}
      {!loading && !error && results.length === 0 && (
        <p className="movie-meta">{emptyMessage}</p>
      )}

      <div className="movie-grid">
        {results.map((movie) => (
          <div key={movie.MOVIE_ID} className="movie-card" onClick={() => onSelectMovie(movie.MOVIE_ID)}>
            <div className="poster-wrap">
              {movie.POSTER_URL && <img src={movie.POSTER_URL} alt={movie.TITLE} className="movie-poster" />}
            </div>
            <h3>{movie.TITLE}</h3>
            <p className="movie-meta">{movie.LANGUAGE} &middot; {new Date(movie.RELEASE_DATE).getFullYear()}</p>
          </div>
        ))}
      </div>
    </div>
  );
}