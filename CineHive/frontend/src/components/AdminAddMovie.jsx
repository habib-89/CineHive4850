import { useEffect, useState } from 'react';
import { api } from '../api';

const FORM_KEY = 'cinehive_admin_addmovie_form';

const emptyForm = {
  title: '', releaseDate: '', duration: '', language: 'English',
  description: '', trailerUrl: '', posterUrl: '', directorName: '', castNames: '',
};

function loadSavedForm() {
  try {
    const raw = sessionStorage.getItem(FORM_KEY);
    return raw ? JSON.parse(raw) : null;
  } catch {
    return null;
  }
}

const saved = loadSavedForm();

export default function AdminAddMovie() {
  const [genres, setGenres] = useState([]);
  const [form, setForm] = useState(saved?.form ?? emptyForm);
  const [selectedGenreIds, setSelectedGenreIds] = useState(saved?.selectedGenreIds ?? []);
  const [submitting, setSubmitting] = useState(false);
  const [error, setError] = useState('');
  const [success, setSuccess] = useState('');

  useEffect(() => {
    api.getAdminGenres().then(setGenres).catch(() => {});
  }, []);

  // Persist the in-progress form so a refresh doesn't lose what was typed.
  useEffect(() => {
    try {
      sessionStorage.setItem(FORM_KEY, JSON.stringify({ form, selectedGenreIds }));
    } catch {
      // sessionStorage unavailable (private mode etc.) — safe to ignore, just won't persist
    }
  }, [form, selectedGenreIds]);

  function clearSavedForm() {
    try {
      sessionStorage.removeItem(FORM_KEY);
    } catch {
      // ignore
    }
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
      await api.addMovie({
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
      setSuccess(`"${form.title}" was added to the catalog.`);
      setForm(emptyForm);
      setSelectedGenreIds([]);
      clearSavedForm();
    } catch (err) {
      setError(err.message);
    } finally {
      setSubmitting(false);
    }
  }

  return (
    <div>
      <div className="section-heading"><h2>Add a Movie</h2></div>

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
          {submitting ? 'Adding...' : 'Add Movie'}
        </button>
      </form>
    </div>
  );
}