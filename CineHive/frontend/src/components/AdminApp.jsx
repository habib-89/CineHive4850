import { useEffect, useState } from 'react';
import { api } from '../api';
import AdminAddMovie from './AdminAddMovie';
import AdminEditMovies from './AdminEditMovies';
import AdminSuggestions from './AdminSuggestions';
import AdminShowtimes from './AdminShowtimes';
import AdminCinemaAdmins from './AdminCinemaAdmins';
import AdminCustomers from './AdminCustomers';
import AdminFeaturedMovies from './AdminFeaturedMovies';
import Profile from './Profile';
import cinehiveLogo from '../assets/cinehive-logo.png';

export default function AdminApp({ onLogout, onBackToCustomer, initialTab }) {
  const isCinemaAdmin = api.isCinemaAdmin();
  const isSiteAdmin = api.isSiteAdmin();
  const [cinema, setCinema] = useState(null);
  const [tab, setTab] = useState(initialTab || 'addmovie'); // only relevant for site admin
  const [error, setError] = useState('');
  const [showProfile, setShowProfile] = useState(false);

  useEffect(() => {
    if (isCinemaAdmin) {
      api.getAdminInfo().then(setCinema).catch((err) => setError(err.message));
    }
  }, [isCinemaAdmin]);

  if (showProfile) {
    return (
      <div className="app-container">
        <header className="marquee">
          <button
            type="button"
            className="wordmark wordmark-button"
            onClick={() => { setShowProfile(false); setTab('addmovie'); }}
            aria-label="CineHive home"
          >
            <img src={cinehiveLogo} alt="CineHive" className="logo-img" />
            <span className="admin-badge">{isCinemaAdmin ? 'CINEMA ADMIN' : 'SITE ADMIN'}</span>
          </button>
          <div className="header-actions">
            <button className="link-button" onClick={onBackToCustomer}>&larr; Back to Browsing</button>
            <button className="link-button" onClick={onLogout}>Log out</button>
          </div>
        </header>
        <Profile onBack={() => setShowProfile(false)} />
      </div>
    );
  }

  return (
    <div className="app-container">
      <header className="marquee">
        <button
          type="button"
          className="wordmark wordmark-button"
          onClick={() => setTab('addmovie')}
          aria-label="CineHive home"
        >
          <img src={cinehiveLogo} alt="CineHive" className="logo-img" />
          <span className="admin-badge">{isCinemaAdmin ? 'CINEMA ADMIN' : 'SITE ADMIN'}</span>
        </button>
        <div className="header-actions">
          {isCinemaAdmin && cinema && <span className="admin-cinema-name">{cinema.CINEMA_NAME}</span>}
          <button className="link-button profile-button" onClick={() => setShowProfile(true)}>Profile</button>
          <button className="link-button" onClick={onBackToCustomer}>&larr; Back to Browsing</button>
          <button className="link-button" onClick={onLogout}>Log out</button>
        </div>
      </header>

      {error && <p className="error">{error}</p>}

      {isCinemaAdmin && <AdminShowtimes />}
      {isSiteAdmin && tab === 'addmovie' && <AdminAddMovie />}
      {isSiteAdmin && tab === 'editmovie' && <AdminEditMovies />}
      {isSiteAdmin && tab === 'suggestions' && <AdminSuggestions />}
      {isSiteAdmin && tab === 'featured' && <AdminFeaturedMovies />}
      {isSiteAdmin && tab === 'cinemaadmins' && <AdminCinemaAdmins />}
      {isSiteAdmin && tab === 'customers' && <AdminCustomers />}
    </div>
  );
}