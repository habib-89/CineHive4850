import { useEffect, useState } from 'react';
import { api } from '../api';

export default function BookingHistory() {
  const [bookings, setBookings] = useState([]);
  const [error, setError] = useState('');
  const [loading, setLoading] = useState(true);
  const [cancellingId, setCancellingId] = useState(null);

  useEffect(() => {
    load();
  }, []);

  function load() {
    setLoading(true);
    api.getMyBookings()
      .then(setBookings)
      .catch((err) => setError(err.message))
      .finally(() => setLoading(false));
  }

  async function handleCancel(bookingId) {
    setCancellingId(bookingId);
    setError('');
    try {
      await api.cancelBooking(bookingId);
      setBookings((prev) =>
        prev.map((b) => (b.BOOKING_ID === bookingId ? { ...b, PAYMENT_STATUS: 'CANCELLED' } : b))
      );
    } catch (err) {
      setError(err.message);
    } finally {
      setCancellingId(null);
    }
  }

  function isUpcoming(booking) {
    return new Date(booking.START_TIME) > new Date();
  }

  return (
    <div>
      <div className="section-heading">
        <h2>My Bookings</h2>
        {!loading && !error && <span className="count">{bookings.length} bookings</span>}
      </div>

      {loading && <p>Loading...</p>}
      {error && <p className="error">{error}</p>}
      {!loading && bookings.length === 0 && !error && (
        <p className="movie-meta">No bookings yet — grab a showtime from Homepage.</p>
      )}

      <div className="booking-history-list">
        {bookings.map((b) => {
          const canCancel = b.PAYMENT_STATUS !== 'REFUNDED' && isUpcoming(b);
          return (
            <div key={b.BOOKING_ID} className="booking-history-item">
              {b.POSTER_URL && <img src={b.POSTER_URL} alt={b.TITLE} className="booking-thumb" />}
              <div className="booking-history-details">
                <h3>{b.TITLE}</h3>
                <p className="movie-meta">
                  {new Date(b.SHOW_DATE).toLocaleDateString()} &middot; {new Date(b.START_TIME).toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })}
                </p>
                <p className="movie-meta">{b.SEAT_COUNT} seat(s) &middot; Booked {new Date(b.BOOKING_DATE).toLocaleDateString()}</p>
              </div>
              <div className="booking-history-right">
                <span className={`status-badge status-${b.PAYMENT_STATUS?.toLowerCase()}`}>{b.PAYMENT_STATUS}</span>
                <span className="ticket-price">৳{b.TOTAL_AMOUNT}</span>
                {canCancel && (
                  <button
                    className="link-button small cancel-link"
                    onClick={() => handleCancel(b.BOOKING_ID)}
                    disabled={cancellingId === b.BOOKING_ID}
                  >
                    {cancellingId === b.BOOKING_ID ? 'Cancelling...' : 'Cancel booking'}
                  </button>
                )}
              </div>
            </div>
          );
        })}
      </div>
    </div>
  );
}