import { useEffect, useState } from 'react';
import { api } from '../api';

export default function AdminCinemaAdmins() {
  const [admins, setAdmins] = useState([]);
  const [error, setError] = useState('');
  const [loading, setLoading] = useState(true);
  const [actingId, setActingId] = useState(null);

  useEffect(() => {
    load();
  }, []);

  function load() {
    setLoading(true);
    api.getCinemaAdmins()
      .then(setAdmins)
      .catch((err) => setError(err.message))
      .finally(() => setLoading(false));
  }

  async function handleApprove(userId) {
    setActingId(userId);
    try {
      await api.approveCinemaAdmin(userId);
      load();
    } catch (err) {
      setError(err.message);
    } finally {
      setActingId(null);
    }
  }

  async function handleRevoke(userId) {
    setActingId(userId);
    try {
      await api.revokeCinemaAdmin(userId);
      load();
    } catch (err) {
      setError(err.message);
    } finally {
      setActingId(null);
    }
  }

  async function handleDelete(userId) {
    setActingId(userId);
    try {
      await api.deleteCinemaAdmin(userId);
      setAdmins((prev) => prev.filter((a) => a.USER_ID !== userId));
    } catch (err) {
      setError(err.message);
    } finally {
      setActingId(null);
    }
  }

  return (
    <div>
      <div className="section-heading">
        <h2>Cinema Admins</h2>
        {!loading && !error && <span className="count">{admins.length} total</span>}
      </div>

      {loading && <p>Loading...</p>}
      {error && <p className="error">{error}</p>}
      {!loading && admins.length === 0 && !error && (
        <p className="movie-meta">No cinema admin accounts yet.</p>
      )}

      <table className="admin-table">
        <thead>
          <tr>
            <th>Username</th><th>Email</th><th>Cinema</th><th>Joined</th><th>Status</th><th></th>
          </tr>
        </thead>
        <tbody>
          {admins.map((a) => (
            <tr key={a.USER_ID}>
              <td>{a.USERNAME}</td>
              <td>{a.EMAIL}</td>
              <td>{a.CINEMA_NAME} — {a.CITY}</td>
              <td>{new Date(a.DATE_JOINED).toLocaleDateString()}</td>
              <td>
                <span className={`status-badge status-${a.IS_APPROVED ? 'paid' : 'pending'}`}>
                  {a.IS_APPROVED ? 'Active' : 'Pending'}
                </span>
              </td>
              <td>
                {!a.IS_APPROVED && (
                  <button className="link-button small" disabled={actingId === a.USER_ID} onClick={() => handleApprove(a.USER_ID)}>
                    Approve
                  </button>
                )}
                {a.IS_APPROVED === 1 && (
                  <button className="link-button small" disabled={actingId === a.USER_ID} onClick={() => handleRevoke(a.USER_ID)}>
                    Revoke Access
                  </button>
                )}
                {' '}
                <button className="link-button small cancel-link" disabled={actingId === a.USER_ID} onClick={() => handleDelete(a.USER_ID)}>
                  Delete
                </button>
              </td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}