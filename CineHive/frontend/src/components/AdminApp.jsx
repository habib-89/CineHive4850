import { useEffect, useState } from 'react';
import { api } from '../api';
import AdminAddMovie from './AdminAddMovie';
import AdminShowtimes from './AdminShowtimes';
import AdminCinemaAdmins from './AdminCinemaAdmins';
import AdminCustomers from './AdminCustomers';

export default function AdminApp({ onLogout, onBackToCustomer }) {
  const isCinemaAdmin = api.isCinemaAdmin();
  const isSiteAdmin = api.isSiteAdmin();
  const [cinema, setCinema] = useState(null);
  const [tab, setTab] = useState('addmovie'); // only relevant for site admin
  const [error, setError] = useState('');

  useEffect(() => {
    if (isCinemaAdmin) {
      api.getAdminInfo().then(setCinema).catch((err) => setError(err.message));
    }
  }, [isCinemaAdmin]);

  return (
    <div className="app-container">
      <header className="marquee">
        <div className="wordmark">
          <h1>CINE<span>HIVE</span></h1>
          <span className="admin-badge">{isCinemaAdmin ? 'CINEMA ADMIN' : 'SITE ADMIN'}</span>
        </div>
        <div className="header-actions">
          {isCinemaAdmin && cinema && <span className="admin-cinema-name">{cinema.CINEMA_NAME}</span>}
          <button className="link-button" onClick={onBackToCustomer}>&larr; Back to Browsing</button>
          <button className="link-button" onClick={onLogout}>Log out</button>
        </div>
      </header>

      {error && <p className="error">{error}</p>}

      {isSiteAdmin && (
        <nav className="tab-nav">
          <button className={`tab ${tab === 'addmovie' ? 'active' : ''}`} onClick={() => setTab('addmovie')}>
            Add Movie
          </button>
          <button className={`tab ${tab === 'cinemaadmins' ? 'active' : ''}`} onClick={() => setTab('cinemaadmins')}>
            Cinema Admins
          </button>
          <button className={`tab ${tab === 'customers' ? 'active' : ''}`} onClick={() => setTab('customers')}>
            Customers
          </button>
        </nav>
      )}

      {isCinemaAdmin && <AdminShowtimes />}
      {isSiteAdmin && tab === 'addmovie' && <AdminAddMovie />}
      {isSiteAdmin && tab === 'cinemaadmins' && <AdminCinemaAdmins />}
      {isSiteAdmin && tab === 'customers' && <AdminCustomers />}
    </div>
  );
}