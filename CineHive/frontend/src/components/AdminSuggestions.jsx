import { useEffect, useState } from 'react';
import { api } from '../api';

function formatDate(value) {
  if (!value) return '';
  return new Date(value).toLocaleString(undefined, {
    year: 'numeric', month: 'short', day: 'numeric', hour: '2-digit', minute: '2-digit',
  });
}

export default function AdminSuggestions() {
  const [feedback, setFeedback] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');
  const [deletingId, setDeletingId] = useState(null);

  function load() {
    setLoading(true);
    setError('');
    api.getAdminFeedback()
      .then(setFeedback)
      .catch((err) => setError(err.message))
      .finally(() => setLoading(false));
  }

  useEffect(load, []);

  async function handleDismiss(id) {
    setDeletingId(id);
    try {
      await api.deleteAdminFeedback(id);
      setFeedback((prev) => prev.filter((f) => f.FEEDBACK_ID !== id));
    } catch (err) {
      setError(err.message);
    } finally {
      setDeletingId(null);
    }
  }

  return (
    <div>
      <div className="section-heading">
        <h2>Suggestions</h2>
        {!loading && !error && <span className="count">{feedback.length} total</span>}
      </div>

      {loading && <p>Loading...</p>}
      {error && <p className="error">{error}</p>}

      {!loading && !error && feedback.length === 0 && (
        <p className="movie-meta">No suggestions yet.</p>
      )}

      <div className="admin-suggestions-list">
        {feedback.map((f) => (
          <div key={f.FEEDBACK_ID} className="admin-suggestion-item">
            <div className="admin-suggestion-header">
              <span className="admin-suggestion-author">{f.NICKNAME || f.USERNAME}</span>
              <span className="movie-meta">{f.EMAIL}</span>
              <span className="movie-meta">{formatDate(f.CREATED_AT)}</span>
            </div>
            <p className="admin-suggestion-message">{f.MESSAGE}</p>
            <button
              type="button"
              className="link-button"
              onClick={() => handleDismiss(f.FEEDBACK_ID)}
              disabled={deletingId === f.FEEDBACK_ID}
            >
              {deletingId === f.FEEDBACK_ID ? 'Dismissing...' : 'Dismiss'}
            </button>
          </div>
        ))}
      </div>
    </div>
  );
}