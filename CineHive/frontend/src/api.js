// api.js — talks to the CineHive Express backend
const BASE_URL = 'http://localhost:3000';

function getToken() {
  return localStorage.getItem('cinehive_token');
}

function saveSession(result) {
  localStorage.setItem('cinehive_token', result.token);
  localStorage.setItem('cinehive_role', result.role || 'CUSTOMER');
  localStorage.setItem('cinehive_cinema_id', result.cinemaId ?? '');
  localStorage.setItem('cinehive_username', result.username || '');
}

function clearSession() {
  localStorage.removeItem('cinehive_token');
  localStorage.removeItem('cinehive_role');
  localStorage.removeItem('cinehive_cinema_id');
  localStorage.removeItem('cinehive_username');
}

// --- Global loading indicator ---
// Every API call goes through request() below, so this one hook tells the
// whole app whenever a fetch is in flight — used by <TopLoadingBar />.
let activeRequestCount = 0;
const loadingListeners = new Set();

function notifyLoadingListeners() {
  loadingListeners.forEach((fn) => fn(activeRequestCount > 0));
}

export function subscribeToLoading(fn) {
  loadingListeners.add(fn);
  fn(activeRequestCount > 0); // sync the new subscriber immediately
  return () => loadingListeners.delete(fn);
}

async function request(path, options = {}) {
  const headers = { 'Content-Type': 'application/json', ...(options.headers || {}) };
  const token = getToken();
  if (token) headers.Authorization = `Bearer ${token}`;

  activeRequestCount++;
  notifyLoadingListeners();
  try {
    const res = await fetch(`${BASE_URL}${path}`, { ...options, headers });
    const data = await res.json().catch(() => ({}));

    if (!res.ok) {
      throw new Error(data.error || `Request failed (${res.status})`);
    }
    return data;
  } finally {
    activeRequestCount--;
    notifyLoadingListeners();
  }
}

export const api = {
  // --- Auth ---
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
  getUsername: () => localStorage.getItem('cinehive_username'),

  // --- Movies ---
  getMovies: () => request('/movies'),
  getFeaturedMovies: () => request('/movies/featured'),
  getNowShowing: (cinemaId) => request(`/movies/now-showing${cinemaId ? `?cinemaId=${cinemaId}` : ''}`),
  getGenres: () => request('/genres'),
  searchMovies: (q, genreId) =>
    request(`/movies/search?q=${encodeURIComponent(q)}${genreId ? `&genreId=${genreId}` : ''}`),
  getMovie: (id) => request(`/movies/${id}`),
  getMovieGenres: (movieId) => request(`/movies/${movieId}/genres`),
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
  getAdminMovies: (q) => request(`/admin/movies${q ? `?q=${encodeURIComponent(q)}` : ''}`),
  getAdminMovie: (id) => request(`/admin/movies/${id}`),
  updateMovie: (id, movie) => request(`/admin/movies/${id}`, { method: 'PUT', body: JSON.stringify(movie) }),

  // --- Site feedback / suggestions (every logged-in user submits, only site admin reads) ---
  submitFeedback: (message) => request('/feedback', { method: 'POST', body: JSON.stringify({ message }) }),
  getAdminFeedback: () => request('/admin/feedback'),
  deleteAdminFeedback: (id) => request(`/admin/feedback/${id}`, { method: 'DELETE' }),
  getAdminFeaturedMovies: () => request('/admin/featured-movies'),
  featureMovie: (id) => request(`/admin/movies/${id}/feature`, { method: 'POST' }),
  unfeatureMovie: (id) => request(`/admin/movies/${id}/unfeature`, { method: 'POST' }),
  getPendingCinemaAdmins: () => request('/admin/pending-cinema-admins'),
  approvePendingCinemaAdmin: (userId) => request(`/admin/pending-cinema-admins/${userId}/approve`, { method: 'POST' }),
  rejectPendingCinemaAdmin: (userId) => request(`/admin/pending-cinema-admins/${userId}`, { method: 'DELETE' }),
  addMovie: (movie) => request('/admin/movies', { method: 'POST', body: JSON.stringify(movie) }),
  getAdminShowtimes: () => request('/admin/showtimes'),
  getAdminShowtimeSeats: (id) => request(`/admin/showtimes/${id}/seats`),
  addAdminShowtime: (data) => request('/admin/showtimes', { method: 'POST', body: JSON.stringify(data) }),
  updateAdminShowtime: (id, data) => request(`/admin/showtimes/${id}`, { method: 'PUT', body: JSON.stringify(data) }),
  deleteAdminShowtime: (id) => request(`/admin/showtimes/${id}`, { method: 'DELETE' }),

  // --- Site admin: customer oversight ---
  getCustomers: () => request('/admin/customers'),
  getCustomerActivity: (id) => request(`/admin/customers/${id}/activity`),

  // --- Site admin: full cinema admin management ---
  getCinemaAdmins: () => request('/admin/cinema-admins'),
  approveCinemaAdmin: (userId) => request(`/admin/cinema-admins/${userId}/approve`, { method: 'POST' }),
  revokeCinemaAdmin: (userId) => request(`/admin/cinema-admins/${userId}/revoke`, { method: 'POST' }),
  deleteCinemaAdmin: (userId) => request(`/admin/cinema-admins/${userId}`, { method: 'DELETE' }),

  // --- Profile (every logged-in user) ---
  getMyProfile: () => request('/profile/me'),
  updateMyProfile: (data) => request('/profile/me', { method: 'PUT', body: JSON.stringify(data) }),
  changeMyPassword: (currentPassword, newPassword) =>
    request('/profile/me/password', { method: 'POST', body: JSON.stringify({ currentPassword, newPassword }) }),
  getMyActivity: () => request('/profile/me/activity'),

  // Upload a profile picture file (from local folder or a phone/gallery picker).
  // Bypasses `request()` since this needs multipart/form-data, not JSON —
  // the browser sets the correct Content-Type (with boundary) automatically
  // as long as we don't set one ourselves.
  uploadMyProfilePicture: async (file) => {
    const formData = new FormData();
    formData.append('picture', file);
    const token = getToken();
    const res = await fetch(`${BASE_URL}/profile/me/picture`, {
      method: 'POST',
      headers: token ? { Authorization: `Bearer ${token}` } : {},
      body: formData,
    });
    const data = await res.json().catch(() => ({}));
    if (!res.ok) {
      throw new Error(data.error || `Upload failed (${res.status})`);
    }
    return data;
  },
};