import { useEffect, useRef, useState } from 'react';
import { api } from '../api';

const DEBOUNCE_MS = 300;

export default function SearchBar({ onSelectMovie, onViewAll }) {
  const [query, setQuery] = useState('');
  const [results, setResults] = useState([]);
  const [open, setOpen] = useState(false);
  const [loading, setLoading] = useState(false);
  const debounceRef = useRef(null);
  const containerRef = useRef(null);

  useEffect(() => {
    if (!query.trim()) {
      setResults([]);
      setOpen(false);
      return;
    }
    setLoading(true);
    clearTimeout(debounceRef.current);
    debounceRef.current = setTimeout(() => {
      api.searchMovies(query.trim())
        .then((data) => {
          setResults(data);
          setOpen(true);
        })
        .catch(() => setResults([]))
        .finally(() => setLoading(false));
    }, DEBOUNCE_MS);

    return () => clearTimeout(debounceRef.current);
  }, [query]);

  // Close dropdown when clicking outside
  useEffect(() => {
    function handleClickOutside(e) {
      if (containerRef.current && !containerRef.current.contains(e.target)) {
        setOpen(false);
      }
    }
    document.addEventListener('mousedown', handleClickOutside);
    return () => document.removeEventListener('mousedown', handleClickOutside);
  }, []);

  function pickMovie(movieId) {
    onSelectMovie(movieId);
    setQuery('');
    setResults([]);
    setOpen(false);
  }

  function handleSubmit(e) {
    e.preventDefault();
    if (query.trim()) {
      onViewAll(query.trim());
      setOpen(false);
    }
  }

  function clear() {
    setQuery('');
    setResults([]);
    setOpen(false);
  }

  return (
    <div className="search-bar" ref={containerRef}>
      <form onSubmit={handleSubmit}>
        <input
          type="text"
          placeholder="Search movies..."
          value={query}
          onChange={(e) => setQuery(e.target.value)}
          onFocus={() => { if (results.length > 0) setOpen(true); }}
        />
        {query && (
          <button type="button" className="search-clear" onClick={clear} aria-label="Clear search">
            &times;
          </button>
        )}
      </form>

      {open && (
        <div className="search-dropdown">
          {loading && <div className="search-dropdown-empty">Searching...</div>}

          {!loading && results.length === 0 && (
            <div className="search-dropdown-empty">No movies match "{query}"</div>
          )}

          {!loading && results.map((movie) => (
            <button key={movie.MOVIE_ID} className="search-dropdown-item" onClick={() => pickMovie(movie.MOVIE_ID)}>
              {movie.POSTER_URL
                ? <img src={movie.POSTER_URL} alt="" className="search-dropdown-thumb" />
                : <span className="search-dropdown-thumb-placeholder" />}
              <span className="search-dropdown-info">
                <span className="search-dropdown-title">{movie.TITLE}</span>
                <span className="search-dropdown-meta">
                  {new Date(movie.RELEASE_DATE).getFullYear()} &middot; {movie.LANGUAGE}
                </span>
              </span>
            </button>
          ))}

          {!loading && results.length > 0 && (
            <button className="search-dropdown-viewall" onClick={handleSubmit}>
              See all results for "{query}"
            </button>
          )}
        </div>
      )}
    </div>
  );
}