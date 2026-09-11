import { useEffect, useState } from 'react';
import { api } from '../api';

export default function SearchResults({ query, onSelectMovie }) {
  const [results, setResults] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');

  useEffect(() => {
    setLoading(true);
    setError('');
    api.searchMovies(query)
      .then(setResults)
      .catch((err) => setError(err.message))
      .finally(() => setLoading(false));
  }, [query]);

  return (
    <div>
      <div className="section-heading">
        <h2>Results for "{query}"</h2>
        {!loading && !error && <span className="count">{results.length} found</span>}
      </div>

      {loading && <p>Searching...</p>}
      {error && <p className="error">{error}</p>}
      {!loading && !error && results.length === 0 && (
        <p className="movie-meta">No movies match "{query}".</p>
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