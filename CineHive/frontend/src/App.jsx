import { useEffect, useState } from 'react';
import { api } from './api';
import Auth from './components/Auth';
import MovieList from './components/MovieList';
import MovieDetail from './components/MovieDetail';
import SeatPicker from './components/SeatPicker';
import Watchlist from './components/Watchlist';
import BookingHistory from './components/BookingHistory';
import PersonDetail from './components/PersonDetail';
import SearchResults from './components/SearchResults';
import SearchBar from './components/SearchBar';
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
  const [tab, setTab] = useState(savedNav?.tab ?? 'movies'); // 'movies' | 'watchlist' | 'bookings'
  const [view, setView] = useState(savedNav?.view ?? 'list'); // 'list' | 'movie' | 'seats' | 'person'
  const [selectedMovieId, setSelectedMovieId] = useState(savedNav?.selectedMovieId ?? null);
  const [selectedShowtimeId, setSelectedShowtimeId] = useState(savedNav?.selectedShowtimeId ?? null);
  const [selectedPerson, setSelectedPerson] = useState(savedNav?.selectedPerson ?? null);
  const [activeSearch, setActiveSearch] = useState(savedNav?.activeSearch ?? '');

  // Persist navigation state on every change so a refresh lands back where you were.
  useEffect(() => {
    const nav = { tab, view, selectedMovieId, selectedShowtimeId, selectedPerson, activeSearch };
    try {
      sessionStorage.setItem(NAV_KEY, JSON.stringify(nav));
    } catch {
      // sessionStorage unavailable (private mode etc.) — safe to ignore, just won't persist
    }
  }, [tab, view, selectedMovieId, selectedShowtimeId, selectedPerson, activeSearch]);

  function handleLogout() {
    api.logout();
    setLoggedIn(false);
    try {
      sessionStorage.removeItem(NAV_KEY);
    } catch {
      // ignore
    }
    setTab('movies');
    setView('list');
    setSelectedMovieId(null);
    setSelectedShowtimeId(null);
    setSelectedPerson(null);
    setActiveSearch('');
  }

  function goToMovie(id) {
    setSelectedMovieId(id);
    setActiveSearch('');
    setView('movie');
  }

  function switchTab(newTab) {
    setTab(newTab);
    setView('list');
    setActiveSearch('');
  }

  function handleViewAll(query) {
    setActiveSearch(query);
    setView('list');
  }

  if (!loggedIn) {
    return <Auth onLoggedIn={() => setLoggedIn(true)} />;
  }

  return (
    <div className="app-container">
      <header className="marquee">
        <div className="wordmark">
          <h1>CINE<span>HIVE</span></h1>
        </div>

        <SearchBar onSelectMovie={goToMovie} onViewAll={handleViewAll} />

        <div className="header-actions">
          <button className="link-button" onClick={handleLogout}>Log out</button>
        </div>
      </header>

      <nav className="tab-nav">
        <button className={`tab ${tab === 'movies' ? 'active' : ''}`} onClick={() => switchTab('movies')}>Now Showing</button>
        <button className={`tab ${tab === 'watchlist' ? 'active' : ''}`} onClick={() => switchTab('watchlist')}>Watchlist</button>
        <button className={`tab ${tab === 'bookings' ? 'active' : ''}`} onClick={() => switchTab('bookings')}>My Bookings</button>
      </nav>

      {view === 'list' && activeSearch && (
        <SearchResults query={activeSearch} onSelectMovie={goToMovie} />
      )}
      {view === 'list' && !activeSearch && tab === 'movies' && <MovieList onSelectMovie={goToMovie} />}
      {view === 'list' && !activeSearch && tab === 'watchlist' && <Watchlist onSelectMovie={goToMovie} />}
      {view === 'list' && !activeSearch && tab === 'bookings' && <BookingHistory />}

      {view === 'movie' && (
        <MovieDetail
          movieId={selectedMovieId}
          onSelectShowtime={(id) => { setSelectedShowtimeId(id); setView('seats'); }}
          onSelectPerson={(id, type) => { setSelectedPerson({ id, type }); setView('person'); }}
          onBack={() => setView('list')}
        />
      )}

      {view === 'seats' && (
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