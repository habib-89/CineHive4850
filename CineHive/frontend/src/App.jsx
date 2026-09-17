import { useEffect, useRef, useState } from 'react';
import { api } from './api';
import Auth from './components/Auth';
import AdminApp from './components/AdminApp';
import MovieList from './components/MovieList';
import MovieDetail from './components/MovieDetail';
import SeatPicker from './components/SeatPicker';
import Watchlist from './components/Watchlist';
import BookingHistory from './components/BookingHistory';
import PersonDetail from './components/PersonDetail';
import SearchResults from './components/SearchResults';
import SearchBar from './components/SearchBar';
import Profile from './components/Profile';
import Help from './components/Help';
import cinehiveLogo from './assets/cinehive-logo.png';
import './App.css';

const NAV_KEY = 'cinehive_nav';

// Read whatever was last saved before the page unloaded, if anything.
function loadSavedNav() {
  try {
    const raw = sessionStorage.getItem(NAV_KEY);
    return raw ? JSON.parse(raw) : null;
  } catch {
    return null;
  }
}

const savedNav = loadSavedNav();

export default function App() {
  const [loggedIn, setLoggedIn] = useState(api.isLoggedIn());
  const [mode, setMode] = useState(savedNav?.mode ?? 'customer'); // 'customer' | 'admin'
  const [adminTab, setAdminTab] = useState(savedNav?.adminTab ?? 'addmovie');
  const [tab, setTab] = useState(savedNav?.tab ?? 'movies');
  const [view, setView] = useState(savedNav?.view ?? 'list');
  const [selectedMovieId, setSelectedMovieId] = useState(savedNav?.selectedMovieId ?? null);
  const [selectedShowtimeId, setSelectedShowtimeId] = useState(savedNav?.selectedShowtimeId ?? null);
  const [selectedPerson, setSelectedPerson] = useState(savedNav?.selectedPerson ?? null);
  const [activeSearch, setActiveSearch] = useState(savedNav?.activeSearch ?? '');
  const [activeGenreId, setActiveGenreId] = useState(savedNav?.activeGenreId ?? '');
  const [activeGenreName, setActiveGenreName] = useState(savedNav?.activeGenreName ?? '');
  const [profilePic, setProfilePic] = useState(null);
  const [nickname, setNickname] = useState(null);
  const searchBarRef = useRef(null);

  const isAdmin = api.isSiteAdmin() || api.isCinemaAdmin();
  const isSiteAdmin = api.isSiteAdmin();

  // Load the user's profile picture for the header avatar once logged in.
  useEffect(() => {
    if (!loggedIn) {
      setProfilePic(null);
      setNickname(null);
      return;
    }
    api.getMyProfile()
      .then((data) => {
        setProfilePic(data.PROFILE_PIC || null);
        setNickname(data.NICKNAME || null);
      })
      .catch(() => {
        // Non-fatal — header just falls back to the letter placeholder.
      });
  }, [loggedIn]);

  // Persist navigation state on every change so a refresh lands back where you were.
  useEffect(() => {
    const nav = { mode, adminTab, tab, view, selectedMovieId, selectedShowtimeId, selectedPerson, activeSearch, activeGenreId, activeGenreName };
    try {
      sessionStorage.setItem(NAV_KEY, JSON.stringify(nav));
    } catch {
      // sessionStorage unavailable (private mode etc.) — safe to ignore, just won't persist
    }
  }, [mode, adminTab, tab, view, selectedMovieId, selectedShowtimeId, selectedPerson, activeSearch, activeGenreId, activeGenreName]);

  function handleLogout() {
    api.logout();
    setLoggedIn(false);
    try {
      sessionStorage.removeItem(NAV_KEY);
    } catch {
      // ignore
    }
    setMode('customer');
    setTab('movies');
    setView('list');
    setSelectedMovieId(null);
    setSelectedShowtimeId(null);
    setSelectedPerson(null);
    setActiveSearch('');
    setActiveGenreId('');
    setActiveGenreName('');
  }

  function goToMovie(id) {
    setSelectedMovieId(id);
    setActiveSearch('');
    setActiveGenreId('');
    setActiveGenreName('');
    setView('movie');
    searchBarRef.current?.clear();
  }

  function switchTab(newTab) {
    setTab(newTab);
    setView('list');
    setActiveSearch('');
    setActiveGenreId('');
    setActiveGenreName('');
  }

  // query and/or genreId may be present; when both are empty this just
  // drops back to normal browsing (e.g. picking "All" with nothing typed).
  function handleViewAll(query, genreId, genreName) {
    const trimmedQuery = (query || '').trim();
    if (!trimmedQuery && !genreId) {
      backToBrowsing();
      return;
    }
    setActiveSearch(trimmedQuery);
    setActiveGenreId(genreId || '');
    setActiveGenreName(genreId ? (genreName || '') : '');
    setView('list');
  }

  function backToBrowsing() {
    setActiveSearch('');
    setActiveGenreId('');
    setActiveGenreName('');
    setView('list');
    searchBarRef.current?.clear();
  }

  function goToAdmin(tabName) {
    setAdminTab(tabName);
    setMode('admin');
  }

  if (!loggedIn) {
    return <Auth onLoggedIn={() => setLoggedIn(true)} />;
  }

  if (mode === 'admin' && isAdmin) {
    return <AdminApp onLogout={handleLogout} onBackToCustomer={() => setMode('customer')} initialTab={adminTab} />;
  }

  return (
    <div className="app-container">
      <header className="marquee">
        <button
          type="button"
          className="wordmark wordmark-button"
          onClick={() => switchTab('movies')}
          aria-label="CineHive home"
        >
          <img src={cinehiveLogo} alt="CineHive" className="logo-img" />
        </button>

        <SearchBar ref={searchBarRef} onSelectMovie={goToMovie} onViewAll={handleViewAll} />

        <div className="header-actions">
          {!isAdmin && (
            <button className="link-button" onClick={() => setView('help')}>Help</button>
          )}
          <button className="link-button profile-button" onClick={() => setView('profile')}>
            {profilePic
              ? <img src={profilePic} alt="" className="profile-button-avatar" />
              : ((nickname || api.getUsername())?.[0]
                ? <span className="profile-button-avatar-placeholder">{(nickname || api.getUsername())[0].toUpperCase()}</span>
                : null)}
            {nickname || 'Profile'}
          </button>
          <button className="link-button" onClick={handleLogout}>Log out</button>
        </div>
      </header>

      {view !== 'profile' && view !== 'help' && (
      <nav className="tab-nav">
        <button className={`tab ${tab === 'movies' ? 'active' : ''}`} onClick={() => switchTab('movies')}>Home</button>
        {!isAdmin && (
          <>
            <button className={`tab ${tab === 'watchlist' ? 'active' : ''}`} onClick={() => switchTab('watchlist')}>Watchlist</button>
            <button className={`tab ${tab === 'bookings' ? 'active' : ''}`} onClick={() => switchTab('bookings')}>My Bookings</button>
          </>
        )}
        {isAdmin && isSiteAdmin && (
          <>
            <button className="tab tab-manage" onClick={() => goToAdmin('addmovie')}>&#9881; Add Movie</button>
            <button className="tab tab-manage" onClick={() => goToAdmin('editmovie')}>Edit Movies</button>
            <button className="tab tab-manage" onClick={() => goToAdmin('featured')}>Featured Movies</button>
            <button className="tab tab-manage" onClick={() => goToAdmin('cinemaadmins')}>Cinema Admins</button>
            <button className="tab tab-manage" onClick={() => goToAdmin('customers')}>Customers</button>
            <button className="tab tab-manage" onClick={() => goToAdmin('suggestions')}>Suggestions</button>
          </>
        )}
        {isAdmin && !isSiteAdmin && (
          <button className="tab tab-manage" onClick={() => goToAdmin('addmovie')}>
            &#9881; Manage Cinema
          </button>
        )}
      </nav>
      )}

      {view === 'list' && (activeSearch || activeGenreId) && (
        <SearchResults
          query={activeSearch}
          genreId={activeGenreId}
          genreName={activeGenreName}
          onSelectMovie={goToMovie}
          onBack={backToBrowsing}
        />
      )}
      {view === 'list' && !activeSearch && !activeGenreId && tab === 'movies' && <MovieList onSelectMovie={goToMovie} />}
      {view === 'list' && !activeSearch && !activeGenreId && !isAdmin && tab === 'watchlist' && <Watchlist onSelectMovie={goToMovie} />}
      {view === 'list' && !activeSearch && !activeGenreId && !isAdmin && tab === 'bookings' && <BookingHistory />}

      {view === 'profile' && (
        <Profile onBack={() => setView('list')} onProfilePicChange={setProfilePic} onNicknameChange={setNickname} />
      )}

      {view === 'help' && <Help onBack={() => setView('list')} />}

      {view === 'movie' && (
        <MovieDetail
          movieId={selectedMovieId}
          onSelectShowtime={(id) => { setSelectedShowtimeId(id); setView('seats'); }}
          onSelectPerson={(id, type) => { setSelectedPerson({ id, type }); setView('person'); }}
          onBack={() => setView('list')}
          readOnly={isAdmin}
        />
      )}

      {view === 'seats' && !isAdmin && (
        <SeatPicker
          showtimeId={selectedShowtimeId}
          onBack={() => setView('movie')}
        />
      )}

      {view === 'person' && selectedPerson && (
        <PersonDetail
          personId={selectedPerson.id}
          type={selectedPerson.type}
          onSelectMovie={goToMovie}
          onBack={() => setView('movie')}
        />
      )}
    </div>
  );
}