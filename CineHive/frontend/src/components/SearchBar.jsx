import { forwardRef, useEffect, useImperativeHandle, useRef, useState } from 'react';
import { api } from '../api';

const DEBOUNCE_MS = 300;
const RECENT_KEY = 'cinehive_recent_searches';
const MAX_RECENT = 5;

function loadRecentSearches() {
  try {
    const raw = localStorage.getItem(RECENT_KEY);
    return raw ? JSON.parse(raw) : [];
  } catch {
    return [];
  }
}

function saveRecentSearches(list) {
  try {
    localStorage.setItem(RECENT_KEY, JSON.stringify(list));
  } catch {
    // localStorage unavailable (private mode etc.) — safe to ignore
  }
}

const SearchBar = forwardRef(function SearchBar({ onSelectMovie, onViewAll }, ref) {
  const [query, setQuery] = useState('');
  const [results, setResults] = useState([]);
  const [open, setOpen] = useState(false);
  const [loading, setLoading] = useState(false);
  const [recentSearches, setRecentSearches] = useState(loadRecentSearches);
  const [genres, setGenres] = useState([]);
  const [genreId, setGenreId] = useState('');
  const [inputFocused, setInputFocused] = useState(false);
  const debounceRef = useRef(null);
  const containerRef = useRef(null);

  const selectedGenreName = genres.find((g) => String(g.GENRE_ID) === String(genreId))?.GENRE_NAME || '';

  useEffect(() => {
    api.getGenres().then(setGenres).catch(() => setGenres([]));
  }, []);

  useEffect(() => {
    if (!query.trim()) {
      setResults([]);
      // Don't force-close here — an empty query still wants to show recent searches
      // (handled by the effect below / focus handler), just not live results.
      return;
    }
    setLoading(true);
    clearTimeout(debounceRef.current);
    debounceRef.current = setTimeout(() => {
      api.searchMovies(query.trim(), genreId || undefined)
        .then((data) => {
          setResults(data);
          // Only pop the live-suggestions dropdown open if the text field is
          // actually focused — e.g. switching genre while a "See all
          // results" page is showing shouldn't reopen this mini dropdown.
          if (inputFocused) setOpen(true);
        })
        .catch(() => setResults([]))
        .finally(() => setLoading(false));
    }, DEBOUNCE_MS);

    return () => clearTimeout(debounceRef.current);
  }, [query, genreId]);

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

  function addToRecent(term) {
    const trimmed = term.trim();
    if (!trimmed) return;
    setRecentSearches((prev) => {
      const deduped = prev.filter((t) => t.toLowerCase() !== trimmed.toLowerCase());
      const next = [trimmed, ...deduped].slice(0, MAX_RECENT);
      saveRecentSearches(next);
      return next;
    });
  }

  function removeRecent(term, e) {
    e.stopPropagation();
    setRecentSearches((prev) => {
      const next = prev.filter((t) => t !== term);
      saveRecentSearches(next);
      return next;
    });
  }

  function clearAllRecent() {
    setRecentSearches([]);
    saveRecentSearches([]);
  }

  function runRecentSearch(term) {
    setQuery(term);
    addToRecent(term);
    onViewAll(term, genreId || undefined, selectedGenreName);
    setOpen(false);
  }

  function pickMovie(movieId) {
    // Save the movie's actual title to Recent Searches, not whatever partial
    // text was typed (e.g. typing "tita" and picking Titanic should recall "Titanic").
    const picked = results.find((m) => m.MOVIE_ID === movieId);
    if (picked?.TITLE) {
      addToRecent(picked.TITLE);
    } else if (query.trim()) {
      addToRecent(query);
    }
    onSelectMovie(movieId);
    setQuery('');
    setResults([]);
    setOpen(false);
  }

  function handleSubmit(e) {
    e.preventDefault();
    if (query.trim()) {
      addToRecent(query);
      onViewAll(query.trim(), genreId || undefined, selectedGenreName);
      setOpen(false);
    }
  }

  function handleGenreChange(e) {
    const newGenreId = e.target.value;
    const newGenreName = genres.find((g) => String(g.GENRE_ID) === String(newGenreId))?.GENRE_NAME || '';
    setGenreId(newGenreId);
    setOpen(false);
    // Always jump straight to the results/browse page on genre change —
    // this also covers picking a genre with no typed query (pure browse),
    // and correctly resets back to the unfiltered view when "All" is picked.
    onViewAll(query.trim(), newGenreId || undefined, newGenreName);
  }

  function clear() {
    setQuery('');
    setResults([]);
    setOpen(false);
    setGenreId('');
  }

  // Let the parent (App) empty out this search box, e.g. when the user
  // hits "Back to Browsing" on the search results page.
  useImperativeHandle(ref, () => ({ clear }));

  function handleFocus() {
    setInputFocused(true);
    if (query.trim()) {
      if (results.length > 0) setOpen(true);
    } else if (recentSearches.length > 0) {
      setOpen(true);
    }
  }

  function handleBlur() {
    setInputFocused(false);
  }

  const showingRecent = !query.trim() && recentSearches.length > 0;

  return (
    <div className="search-bar" ref={containerRef}>
      <form onSubmit={handleSubmit}>
        <select
          className="search-genre-select"
          value={genreId}
          onChange={handleGenreChange}
          aria-label="Filter search by genre"
        >
          <option value="">All</option>
          {genres.map((g) => (
            <option key={g.GENRE_ID} value={g.GENRE_ID}>{g.GENRE_NAME}</option>
          ))}
        </select>
        <div className="search-input-wrap">
          <input
            type="text"
            placeholder="Search movies..."
            value={query}
            onChange={(e) => setQuery(e.target.value)}
            onFocus={handleFocus}
            onBlur={handleBlur}
          />
          {query && (
            <button type="button" className="search-clear" onClick={clear} aria-label="Clear search">
              &times;
            </button>
          )}
        </div>
      </form>

      {open && showingRecent && (
        <div className="search-dropdown">
          <div className="search-dropdown-header">
            <span>Recent Searches</span>
            <button type="button" className="search-dropdown-clear-all" onClick={clearAllRecent}>
              Clear all
            </button>
          </div>
          {recentSearches.map((term) => (
            <button
              key={term}
              className="search-dropdown-item search-dropdown-recent-item"
              onClick={() => runRecentSearch(term)}
            >
              <span className="search-dropdown-recent-icon">&#8634;</span>
              <span className="search-dropdown-info">
                <span className="search-dropdown-title">{term}</span>
              </span>
              <span
                className="search-dropdown-recent-remove"
                onClick={(e) => removeRecent(term, e)}
                role="button"
                aria-label={`Remove "${term}" from recent searches`}
              >
                &times;
              </span>
            </button>
          ))}
        </div>
      )}

      {open && !showingRecent && (
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
});

export default SearchBar;