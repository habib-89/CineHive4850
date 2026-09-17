import { useEffect, useState } from 'react';
import { api } from '../api';

// Same shape as AdminAddMovie's form, plus the movie's genre selections.
function toFormState(movie) {
  return {
    title: movie.TITLE || '',
    releaseDate: movie.RELEASE_DATE ? String(movie.RELEASE_DATE).slice(0, 10) : '',
    duration: movie.DURATION ?? '',
    language: movie.LANGUAGE || '',
    description: movie.DESCRIPTION || '',
    trailerUrl: movie.TRAILER_URL || '',
    posterUrl: movie.POSTER_URL || '',
    directorName: movie.DIRECTOR_NAME || '',
    castNames: (movie.CAST_NAMES || []).join(', '),
  };
}

export default function AdminEditMovies() {
  const [genres, setGenres] = useState([]);
  const [query, setQuery] = useState('');
  const [movies, setMovies] = useState([]);
  const [listLoading, setListLoading] = useState(true);
  const [listError, setListError] = useState('');

  const [selectedId, setSelectedId] = useState(null);
  const [form, setForm] = useState(null);
  const [selectedGenreIds, setSelectedGenreIds] = useState([]);
  const [detailLoading, setDetailLoading] = useState(false);
  const [detailError, setDetailError] = useState('');

  const [submitting, setSubmitting] = useState(false);
  const [error, setError] = useState('');
  const [success, setSuccess] = useState('');

  useEffect(() => {
    api.getAdminGenres().then(setGenres).catch(() => {});
  }, []);

  function loadMovies(q) {
    setListLoading(true);
    setListError('');
    api.getAdminMovies(q)
      .then(setMovies)
      .catch((err) => setListError(err.message))
      .finally(() => setListLoading(false));
  }

  useEffect(() => {
    const t = setTimeout(() => loadMovies(query.trim()), 300);
    return () => clearTimeout(t);
  }, [query]);

  function selectMovie(id) {
    setSelectedId(id);
    setForm(null);
    setDetailError('');
    setError('');
    setSuccess('');
    setDetailLoading(true);
    api.getAdminMovie(id)
      .then((movie) => {
        setForm(toFormState(movie));
        setSelectedGenreIds(movie.GENRE_IDS || []);
      })
      .catch((err) => setDetailError(err.message))
      .finally(() => setDetailLoading(false));
  }

  function updateField(field, value) {
    setForm((prev) => ({ ...prev, [field]: value }));
  }

  function toggleGenre(genreId) {
    setSelectedGenreIds((prev) =>
      prev.includes(genreId) ? prev.filter((id) => id !== genreId) : [...prev, genreId]
    );
  }

  async function handleSubmit(e) {
    e.preventDefault();
    setError('');
    setSuccess('');
    setSubmitting(true);
    try {
      await api.updateMovie(selectedId, {
        title: form.title,
        releaseDate: form.releaseDate,
        duration: Number(form.duration),
        language: form.language,
        description: form.description,
        trailerUrl: form.trailerUrl,
        posterUrl: form.posterUrl,
        genreIds: selectedGenreIds,
        directorName: form.directorName,
        castNames: form.castNames.split(',').map((s) => s.trim()).filter(Boolean),
      });
      setSuccess(`"${form.title}" was updated.`);
      loadMovies(query.trim()); // refresh title/poster in the list in case they changed
    } catch (err) {
      setError(err.message);
    } finally {
      setSubmitting(false);
    }
  }

  return (
    <div className="admin-edit-movies">
      <div className="section-heading"><h2>Edit Movies</h2></div>

      <div className="admin-edit-movies-layout">
        <div className="admin-edit-movies-list">
          <input
            type="text"
            placeholder="Search movies to edit..."
            value={query}
            onChange={(e) => setQuery(e.target.value)}
          />

          {listLoading && <p>Loading...</p>}
          {listError && <p className="error">{listError}</p>}
          {!listLoading && !listError && movies.length === 0 && (
            <p className="movie-meta">No movies match.</p>
          )}

          <ul className="admin-edit-movies-items">
            {movies.map((m) => (
              <li key={m.MOVIE_ID}>
                <button
                  type="button"
                  className={`admin-edit-movies-item ${selectedId === m.MOVIE_ID ? 'active' : ''}`}
                  onClick={() => selectMovie(m.MOVIE_ID)}
                >
                  {m.POSTER_URL
                    ? <img src={m.POSTER_URL} alt="" className="admin-edit-movies-thumb" />
                    : <span className="admin-edit-movies-thumb-placeholder" />}
                  <span>
                    <span className="admin-edit-movies-title">{m.TITLE}</span>
                    <span className="movie-meta">
                      {m.RELEASE_DATE ? new Date(m.RELEASE_DATE).getFullYear() : ''}
                    </span>
                  </span>
                </button>
              </li>
            ))}
          </ul>
        </div>

        <div className="admin-edit-movies-form">
          {!selectedId && <p className="movie-meta">Pick a movie on the left to edit its details.</p>}
          {detailLoading && <p>Loading movie...</p>}
          {detailError && <p className="error">{detailError}</p>}

          {selectedId && form && !detailLoading && (
            <form onSubmit={handleSubmit} className="admin-form">
              <div className="field">
                <label>Title *</label>
                <input type="text" value={form.title} onChange={(e) => updateField('title', e.target.value)} required />
              </div>

              <div className="admin-form-row">
                <div className="field">
                  <label>Release Date *</label>
                  <input type="date" value={form.releaseDate} onChange={(e) => updateField('releaseDate', e.target.value)} required />
                </div>
                <div className="field">
                  <label>Duration (min) *</label>
                  <input type="number" min="1" value={form.duration} onChange={(e) => updateField('duration', e.target.value)} required />
                </div>
                <div className="field">
                  <label>Language *</label>
                  <input type="text" value={form.language} onChange={(e) => updateField('language', e.target.value)} required />
                </div>
              </div>

              <div className="field">
                <label>Description</label>
                <textarea rows={3} value={form.description} onChange={(e) => updateField('description', e.target.value)} />
              </div>

              <div className="admin-form-row">
                <div className="field">
                  <label>Trailer URL</label>
                  <input type="url" placeholder="https://youtube.com/..." value={form.trailerUrl} onChange={(e) => updateField('trailerUrl', e.target.value)} />
                </div>
                <div className="field">
                  <label>Poster URL</label>
                  <input type="url" placeholder="https://..." value={form.posterUrl} onChange={(e) => updateField('posterUrl', e.target.value)} />
                </div>
              </div>

              <div className="field">
                <label>Genres</label>
                <div className="genre-checkbox-list">
                  {genres.map((g) => (
                    <label key={g.GENRE_ID} className="genre-checkbox">
                      <input
                        type="checkbox"
                        checked={selectedGenreIds.includes(g.GENRE_ID)}
                        onChange={() => toggleGenre(g.GENRE_ID)}
                      />
                      {g.GENRE_NAME}
                    </label>
                  ))}
                </div>
              </div>

              <div className="field">
                <label>Director</label>
                <input type="text" placeholder="e.g. Christopher Nolan" value={form.directorName} onChange={(e) => updateField('directorName', e.target.value)} />
              </div>

              <div className="field">
                <label>Cast (comma-separated)</label>
                <input type="text" placeholder="e.g. Actor One, Actor Two" value={form.castNames} onChange={(e) => updateField('castNames', e.target.value)} />
              </div>

              {error && <p className="error">{error}</p>}
              {success && <p className="success-msg">{success}</p>}

              <button type="submit" className="btn-primary" disabled={submitting}>
                {submitting ? 'Saving...' : 'Save Changes'}
              </button>
            </form>
          )}
        </div>
      </div>
    </div>
  );
}