import { Fragment, useEffect, useState } from 'react';
import { api } from '../api';

const STATE_KEY = 'cinehive_admin_showtimes_state';

const emptyNewForm = { movieId: '', screenId: '', showDate: '', startTime: '', ticketPrice: '' };
const emptyEditForm = { showDate: '', startTime: '', ticketPrice: '' };

function loadSavedState() {
  try {
    const raw = sessionStorage.getItem(STATE_KEY);
    return raw ? JSON.parse(raw) : null;
  } catch {
    return null;
  }
}

const saved = loadSavedState();

export default function AdminShowtimes() {
  const [showtimes, setShowtimes] = useState([]);
  const [screens, setScreens] = useState([]);
  const [movies, setMovies] = useState([]);
  const [error, setError] = useState('');
  const [loading, setLoading] = useState(true);
  const [editingId, setEditingId] = useState(saved?.editingId ?? null);
  const [editForm, setEditForm] = useState(saved?.editForm ?? emptyEditForm);

  const [newForm, setNewForm] = useState(saved?.newForm ?? emptyNewForm);
  const [adding, setAdding] = useState(false);

  const [viewingSeatsId, setViewingSeatsId] = useState(null);
  const [seatMap, setSeatMap] = useState([]);
  const [seatMapLoading, setSeatMapLoading] = useState(false);
  const [seatMapError, setSeatMapError] = useState('');

  useEffect(() => {
    load();
    api.getAdminScreens().then(setScreens).catch(() => {});
    api.getMovies().then(setMovies).catch(() => {});
  }, []);

  // Persist the add-form and any in-progress edit so a refresh doesn't lose either.
  useEffect(() => {
    try {
      sessionStorage.setItem(STATE_KEY, JSON.stringify({ newForm, editingId, editForm }));
    } catch {
      // sessionStorage unavailable (private mode etc.) — safe to ignore, just won't persist
    }
  }, [newForm, editingId, editForm]);

  function load() {
    setLoading(true);
    api.getAdminShowtimes()
      .then(setShowtimes)
      .catch((err) => setError(err.message))
      .finally(() => setLoading(false));
  }

  function toDateTimeInputValue(isoString) {
    const d = new Date(isoString);
    const pad = (n) => String(n).padStart(2, '0');
    return `${d.getFullYear()}-${pad(d.getMonth() + 1)}-${pad(d.getDate())}T${pad(d.getHours())}:${pad(d.getMinutes())}`;
  }

  function startEdit(st) {
    setEditingId(st.SHOWTIME_ID);
    const dt = toDateTimeInputValue(st.START_TIME);
    setEditForm({
      showDate: dt.slice(0, 10),
      startTime: dt.replace('T', ' '),
      ticketPrice: st.TICKET_PRICE,
    });
  }

  function cancelEdit() {
    setEditingId(null);
    setEditForm(emptyEditForm);
  }

  async function saveEdit(id) {
    try {
      await api.updateAdminShowtime(id, editForm);
      setEditingId(null);
      setEditForm(emptyEditForm);
      load();
    } catch (err) {
      setError(err.message);
    }
  }

  async function handleDelete(id) {
    try {
      await api.deleteAdminShowtime(id);
      // If the row being deleted was mid-edit, clear that edit state too.
      if (editingId === id) {
        setEditingId(null);
        setEditForm(emptyEditForm);
      }
      load();
    } catch (err) {
      setError(err.message);
    }
  }

  async function handleAdd(e) {
    e.preventDefault();
    setAdding(true);
    setError('');
    try {
      await api.addAdminShowtime({
        movieId: newForm.movieId,
        screenId: newForm.screenId,
        showDate: newForm.showDate,
        startTime: `${newForm.showDate} ${newForm.startTime}`,
        ticketPrice: newForm.ticketPrice,
      });
      setNewForm(emptyNewForm);
      load();
    } catch (err) {
      setError(err.message);
    } finally {
      setAdding(false);
    }
  }

  async function toggleSeatView(showtimeId) {
    if (viewingSeatsId === showtimeId) {
      setViewingSeatsId(null);
      return;
    }
    setViewingSeatsId(showtimeId);
    setSeatMapLoading(true);
    setSeatMapError('');
    try {
      const data = await api.getAdminShowtimeSeats(showtimeId);
      setSeatMap(data);
    } catch (err) {
      setSeatMapError(err.message);
    } finally {
      setSeatMapLoading(false);
    }
  }

  const totalRevenue = showtimes.reduce((sum, st) => sum + (st.AMOUNT_SOLD || 0), 0);

  return (
    <div>
      <div className="section-heading"><h2>Add a Showtime</h2></div>
      <form onSubmit={handleAdd} className="admin-form admin-showtime-form">
        <div className="admin-form-row">
          <div className="field">
            <label>Movie</label>
            <select value={newForm.movieId} onChange={(e) => setNewForm({ ...newForm, movieId: e.target.value })} required>
              <option value="">Select a movie</option>
              {movies.map((m) => <option key={m.MOVIE_ID} value={m.MOVIE_ID}>{m.TITLE}</option>)}
            </select>
          </div>
          <div className="field">
            <label>Screen</label>
            <select value={newForm.screenId} onChange={(e) => setNewForm({ ...newForm, screenId: e.target.value })} required>
              <option value="">Select a screen</option>
              {screens.map((s) => <option key={s.SCREEN_ID} value={s.SCREEN_ID}>{s.SCREEN_NAME} ({s.CAPACITY} seats)</option>)}
            </select>
          </div>
        </div>
        <div className="admin-form-row">
          <div className="field">
            <label>Date</label>
            <input type="date" value={newForm.showDate} onChange={(e) => setNewForm({ ...newForm, showDate: e.target.value })} required />
          </div>
          <div className="field">
            <label>Start Time</label>
            <input type="time" value={newForm.startTime} onChange={(e) => setNewForm({ ...newForm, startTime: e.target.value })} required />
          </div>
          <div className="field">
            <label>Ticket Price</label>
            <input type="number" min="1" value={newForm.ticketPrice} onChange={(e) => setNewForm({ ...newForm, ticketPrice: e.target.value })} required />
          </div>
        </div>
        {error && <p className="error">{error}</p>}
        <button type="submit" className="btn-primary" disabled={adding}>{adding ? 'Adding...' : 'Add Showtime'}</button>
      </form>

      <div className="section-heading">
        <h2>Your Showtimes</h2>
        <span className="count">Total revenue: ${totalRevenue.toLocaleString()}</span>
      </div>
      {loading && <p>Loading...</p>}
      {!loading && showtimes.length === 0 && <p className="movie-meta">No showtimes yet.</p>}

      <table className="admin-table">
        <thead>
          <tr>
            <th>Movie</th><th>Screen</th><th>Date</th><th>Time</th><th>Price</th><th>Sold</th><th>Revenue</th><th></th>
          </tr>
        </thead>
        <tbody>
          {showtimes.map((st) => (
            <Fragment key={st.SHOWTIME_ID}>
              <tr>
                {editingId === st.SHOWTIME_ID ? (
                  <>
                    <td>{st.TITLE}</td>
                    <td>{st.SCREEN_NAME}</td>
                    <td>
                      <input type="date" value={editForm.showDate}
                        onChange={(e) => setEditForm({ ...editForm, showDate: e.target.value, startTime: `${e.target.value} ${editForm.startTime.split(' ')[1] || ''}` })} />
                    </td>
                    <td>
                      <input type="time" value={editForm.startTime.split(' ')[1]?.slice(0, 5) || ''}
                        onChange={(e) => setEditForm({ ...editForm, startTime: `${editForm.showDate} ${e.target.value}` })} />
                    </td>
                    <td>
                      <input type="number" value={editForm.ticketPrice} style={{ width: '70px' }}
                        onChange={(e) => setEditForm({ ...editForm, ticketPrice: e.target.value })} />
                    </td>
                    <td>{st.SEATS_SOLD}/{st.CAPACITY}</td>
                    <td>${st.AMOUNT_SOLD}</td>
                    <td>
                      <button className="link-button small" onClick={() => saveEdit(st.SHOWTIME_ID)}>Save</button>
                      {' '}
                      <button className="link-button small" onClick={cancelEdit}>Cancel</button>
                    </td>
                  </>
                ) : (
                  <>
                    <td>{st.TITLE}</td>
                    <td>{st.SCREEN_NAME}</td>
                    <td>{new Date(st.SHOW_DATE).toLocaleDateString()}</td>
                    <td>{new Date(st.START_TIME).toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })}</td>
                    <td>${st.TICKET_PRICE}</td>
                    <td>{st.SEATS_SOLD}/{st.CAPACITY}</td>
                    <td>${st.AMOUNT_SOLD}</td>
                    <td>
                      <button className="link-button small" onClick={() => toggleSeatView(st.SHOWTIME_ID)}>
                        {viewingSeatsId === st.SHOWTIME_ID ? 'Hide Seats' : 'View Seats'}
                      </button>
                      {' '}
                      <button className="link-button small" onClick={() => startEdit(st)}>Edit</button>
                      {' '}
                      <button className="link-button small cancel-link" onClick={() => handleDelete(st.SHOWTIME_ID)}>Delete</button>
                    </td>
                  </>
                )}
              </tr>
              {viewingSeatsId === st.SHOWTIME_ID && (
                <tr>
                  <td colSpan={8}>
                    <div className="admin-seat-map-panel">
                      {seatMapLoading && <p>Loading seat map...</p>}
                      {seatMapError && <p className="error">{seatMapError}</p>}
                      {!seatMapLoading && !seatMapError && (
                        <>
                          <div className="seat-legend">
                            <span className="legend-item"><span className="legend-swatch" /> Available</span>
                            <span className="legend-item"><span className="legend-swatch selected" /> Booked</span>
                          </div>
                          <div className="seat-map admin-seat-map">
                            {Object.entries(
                              seatMap.reduce((acc, seat) => {
                                (acc[seat.ROW_NUMBER] ||= []).push(seat);
                                return acc;
                              }, {})
                            ).map(([row, rowSeats]) => (
                              <div key={row} className="seat-row">
                                <span className="row-label">{row}</span>
                                {rowSeats.map((seat) => (
                                  <span
                                    key={seat.SEAT_ID}
                                    className={`seat seat-${seat.SEAT_TYPE?.toLowerCase()} ${seat.IS_BOOKED ? 'selected' : ''}`}
                                    title={`${seat.SEAT_TYPE} - Seat ${seat.SEAT_NUMBER} - ${seat.IS_BOOKED ? 'Booked' : 'Available'}`}
                                  >
                                    {seat.SEAT_NUMBER}
                                  </span>
                                ))}
                              </div>
                            ))}
                          </div>
                        </>
                      )}
                    </div>
                  </td>
                </tr>
              )}
            </Fragment>
          ))}
        </tbody>
      </table>
    </div>
  );
}