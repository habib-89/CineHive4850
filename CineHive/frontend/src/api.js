// api.js — talks to the CineHive Express backend
const BASE_URL = 'http://localhost:3000';

function getToken() {
  return localStorage.getItem('cinehive_token');
}

function saveSession(result) {
  localStorage.setItem('cinehive_token', result.token);
  localStorage.setItem('cinehive_role', result.role || 'CUSTOMER');
  localStorage.setItem('cinehive_cinema_id', result.cinemaId ?? '');
}

function clearSession() {
  localStorage.removeItem('cinehive_token');
  localStorage.removeItem('cinehive_role');
  localStorage.removeItem('cinehive_cinema_id');
}

async function request(path, options = {}) {
  const headers = { 'Content-Type': 'application/json', ...(options.headers || {}) };
  const token = getToken();
  if (token) headers.Authorization = `Bearer ${token}`;

  const res = await fetch(`${BASE_URL}${path}`, { ...options, headers });
  const data = await res.json().catch(() => ({}));

  if (!res.ok) {
    throw new Error(data.error || `Request failed (${res.status})`);
  }
  return data;
}

export const api = {
  // --- Auth ---
  register: (username, email, password, role, cinemaId) =>
    request('/auth/register', { method: 'POST', body: JSON.stringify({ username, email, password, role, cinemaId }) }),
  register: (username, email, password, role, cinemaId, secretCode) =>
    request('/auth/register', { method: 'POST', body: JSON.stringify({ username, email, password, role, cinemaId, secretCode }) }),

  login: (email, password) =>
    request('/auth/login', { method: 'POST', body: JSON.stringify({ email, password }) }),

  getCinemas: () => request('/cinemas'),

  isLoggedIn: () => !!getToken(),
  saveSession,
  logout: clearSession,
  getRole: () => localStorage.getItem('cinehive_role'),
  isSiteAdmin: () => localStorage.getItem('cinehive_role') === 'SITE_ADMIN',
  isCinemaAdmin: () => localStorage.getItem('cinehive_role') === 'CINEMA_ADMIN',
  getCinemaId: () => localStorage.getItem('cinehive_cinema_id'),

  // --- Movies ---
  getMovies: () => request('/movies'),
  getFeaturedMovies: () => request('/movies/featured'),
  searchMovies: (q) => request(`/movies/search?q=${encodeURIComponent(q)}`),
  getMovie: (id) => request(`/movies/${id}`),
  getCatalogByGenre: () => request('/catalog/by-genre'),

  // --- Cast & crew ---
  getCast: (movieId) => request(`/movies/${movieId}/cast`),
  getMovieDirectors: (movieId) => request(`/movies/${movieId}/directors`),
  getActor: (id) => request(`/actors/${id}`),
  getDirector: (id) => request(`/directors/${id}`),

  // --- Showtimes & seats ---
  getShowtimes: (movieId) => request(`/movies/${movieId}/showtimes`),
  getSeats: (showtimeId) => request(`/showtimes/${showtimeId}/seats`),

  // --- Bookings ---
  createBooking: (showtimeId, seatIds) =>
    request('/bookings', { method: 'POST', body: JSON.stringify({ showtimeId, seatIds }) }),
  getMyBookings: () => request('/bookings/me'),
  cancelBooking: (bookingId) => request(`/bookings/${bookingId}/cancel`, { method: 'POST' }),

  // --- Watchlist ---
  getWatchlist: () => request('/watchlist'),
  addToWatchlist: (movieId) => request('/watchlist', { method: 'POST', body: JSON.stringify({ movieId }) }),
  removeFromWatchlist: (movieId) => request(`/watchlist/${movieId}`, { method: 'DELETE' }),

  // --- Reviews & ratings ---
  getReviews: (movieId) => request(`/movies/${movieId}/reviews`),
  postReview: (movieId, reviewText) =>
    request(`/movies/${movieId}/reviews`, { method: 'POST', body: JSON.stringify({ reviewText }) }),
  getRating: (movieId) => request(`/movies/${movieId}/rating`),
  setRating: (movieId, ratingValue) =>
    request(`/movies/${movieId}/rating`, { method: 'POST', body: JSON.stringify({ ratingValue }) }),

  // --- Admin ---
  getAdminInfo: () => request('/admin/me'),
  getAdminScreens: () => request('/admin/screens'),
  getAdminGenres: () => request('/admin/genres'),
  addMovie: (movie) => request('/admin/movies', { method: 'POST', body: JSON.stringify(movie) }),
  getAdminShowtimes: () => request('/admin/showtimes'),
  getAdminShowtimeSeats: (id) => request(`/admin/showtimes/${id}/seats`),
  addAdminShowtime: (data) => request('/admin/showtimes', { method: 'POST', body: JSON.stringify(data) }),
  updateAdminShowtime: (id, data) => request(`/admin/showtimes/${id}`, { method: 'PUT', body: JSON.stringify(data) }),
  deleteAdminShowtime: (id) => request(`/admin/showtimes/${id}`, { method: 'DELETE' }),
};