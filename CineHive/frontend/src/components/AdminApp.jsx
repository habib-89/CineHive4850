import { useEffect, useState } from 'react';
import { api } from '../api';
import AdminAddMovie from './AdminAddMovie';
import AdminShowtimes from './AdminShowtimes';

const ADMIN_NAV_KEY = 'cinehive_admin_nav';

function loadSavedTab() {
  try {
    return sessionStorage.getItem(ADMIN_NAV_KEY);
  } catch {
    return null;
  }
}

export default function AdminApp({ onLogout }) {
  const [cinema, setCinema] = useState(null);
  const [tab, setTab] = useState(loadSavedTab() ?? 'showtimes'); // 'showtimes' | 'addmovie'
  const [error, setError] = useState('');

  useEffect(() => {
    api.getAdminInfo().then(setCinema).catch((err) => setError(err.message));
  }, []);

  // Persist the active tab so a refresh lands back on the same admin screen.
  useEffect(() => {
    try {
      sessionStorage.setItem(ADMIN_NAV_KEY, tab);
    } catch {
      // sessionStorage unavailable (private mode etc.) — safe to ignore, just won't persist
    }
  }, [tab]);

  function handleLogout() {
    try {
      sessionStorage.removeItem(ADMIN_NAV_KEY);
    } catch {
      // ignore
    }
    onLogout();
  }

  return (
    <div className="app-container">
      <header className="marquee">
        <div className="wordmark">
          <h1>CINE<span>HIVE</span></h1>
          <span className="admin-badge">ADMIN</span>
        </div>
        <div className="header-actions">
          {cinema && <span className="admin-cinema-name">{cinema.CINEMA_NAME}</span>}
          <button className="link-button" onClick={handleLogout}>Log out</button>
        </div>
      </header>

      {error && <p className="error">{error}</p>}

      <nav className="tab-nav">
        <button className={`tab ${tab === 'showtimes' ? 'active' : ''}`} onClick={() => setTab('showtimes')}>
          Manage Showtimes
        </button>
        <button className={`tab ${tab === 'addmovie' ? 'active' : ''}`} onClick={() => setTab('addmovie')}>
          Add Movie
        </button>
      </nav>

      {tab === 'showtimes' && <AdminShowtimes />}
      {tab === 'addmovie' && <AdminAddMovie />}
    </div>
  );
}