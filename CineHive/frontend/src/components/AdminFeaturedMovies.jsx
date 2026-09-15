import { useEffect, useState } from 'react';
import { api } from '../api';

export default function AdminFeaturedMovies() {
  const [movies, setMovies] = useState([]);
  const [query, setQuery] = useState('');
  const [error, setError] = useState('');
  const [loading, setLoading] = useState(true);
  const [actingId, setActingId] = useState(null);

  useEffect(() => {
    load();
  }, []);

  function load() {
    setLoading(true);
    api.getAdminFeaturedMovies()
      .then(setMovies)
      .catch((err) => setError(err.message))
      .finally(() => setLoading(false));
  }

  async function toggleFeatured(movie) {
    setActingId(movie.MOVIE_ID);
    try {
      if (movie.IS_FEATURED) {
        await api.unfeatureMovie(movie.MOVIE_ID);
      } else {
        await api.featureMovie(movie.MOVIE_ID);
      }
      setMovies((prev) =>
        prev.map((m) => (m.MOVIE_ID === movie.MOVIE_ID ? { ...m, IS_FEATURED: movie.IS_FEATURED ? 0 : 1 } : m))
      );
    } catch (err) {
      setError(err.message);
    } finally {
      setActingId(null);
    }
  }

  const featuredMovies = movies.filter((m) => m.IS_FEATURED);
  const filteredMovies = query.trim()
    ? movies.filter((m) => m.TITLE.toUpperCase().includes(query.trim().toUpperCase()))
    : movies;

  return (
    <div>
      <div className="section-heading">
        <h2>Featured Movies</h2>
        <span className="count">{featuredMovies.length} in rotation</span>
      </div>
      <p className="movie-meta" style={{ marginBottom: 20 }}>
        Featured movies rotate automatically in the homepage hero banner, changing every few seconds.
      </p>

      {featuredMovies.length > 0 && (
        <>
          <h4 className="admin-subheading">Currently Featured</h4>
          <div className="featured-strip">
            {featuredMovies.map((m) => (
              <div key={m.MOVIE_ID} className="featured-chip">
                {m.POSTER_URL && <img src={m.POSTER_URL} alt={m.TITLE} />}
                <span className="featured-chip-title">{m.TITLE}</span>
                <button
                  className="link-button small cancel-link"
                  disabled={actingId === m.MOVIE_ID}
                  onClick={() => toggleFeatured(m)}
                >
                  Remove
                </button>
              </div>
            ))}
          </div>
        </>
      )}

      <h4 className="admin-subheading">All Movies</h4>
      <input
        type="text"
        placeholder="Search movies by title..."
        value={query}
        onChange={(e) => setQuery(e.target.value)}
        className="admin-search-input"
      />

      {loading && <p>Loading...</p>}
      {error && <p className="error">{error}</p>}

      <table className="admin-table">
        <thead>
          <tr>
            <th>Movie</th><th>Release Date</th><th></th>
          </tr>
        </thead>
        <tbody>
          {filteredMovies.map((m) => (
            <tr key={m.MOVIE_ID}>
              <td>{m.TITLE}</td>
              <td>{m.RELEASE_DATE ? new Date(m.RELEASE_DATE).toLocaleDateString() : '—'}</td>
              <td>
                <button
                  className="link-button small"
                  disabled={actingId === m.MOVIE_ID}
                  onClick={() => toggleFeatured(m)}
                >
                  {m.IS_FEATURED ? 'Remove from Hero' : 'Add to Hero'}
                </button>
              </td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}