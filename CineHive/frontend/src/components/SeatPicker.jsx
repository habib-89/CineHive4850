import { useEffect, useState } from 'react';
import { api } from '../api';

const PREMIUM_MULTIPLIER = 1.5;

export default function SeatPicker({ showtimeId, onBooked, onBack }) {
  const [seats, setSeats] = useState([]);
  const [cinemaName, setCinemaName] = useState('');
  const [screenName, setScreenName] = useState('');
  const [basePrice, setBasePrice] = useState(null);
  const [selected, setSelected] = useState([]);
  const [error, setError] = useState('');
  const [booking, setBooking] = useState(false);
  const [result, setResult] = useState(null);

  useEffect(() => {
    api.getSeats(showtimeId)
      .then((data) => {
        setSeats(data.seats);
        setCinemaName(data.cinemaName);
        setScreenName(data.screenName);
        setBasePrice(data.basePrice ?? null);
      })
      .catch((err) => setError(err.message));
  }, [showtimeId]);

  function toggleSeat(seat) {
    if (seat.IS_BOOKED) return;
    setSelected((prev) =>
      prev.includes(seat.SEAT_ID) ? prev.filter((id) => id !== seat.SEAT_ID) : [...prev, seat.SEAT_ID]
    );
  }

  function seatPrice(seat) {
    if (basePrice == null) return null;
    return seat.SEAT_TYPE === 'PREMIUM' ? Math.round(basePrice * PREMIUM_MULTIPLIER) : basePrice;
  }

  const runningTotal = selected.reduce((sum, seatId) => {
    const seat = seats.find((s) => s.SEAT_ID === seatId);
    return sum + (seat ? seatPrice(seat) : 0);
  }, 0);

  async function handleBook() {
    if (selected.length === 0) return;
    setBooking(true);
    setError('');
    try {
      const res = await api.createBooking(showtimeId, selected);
      setResult(res);
      onBooked?.(res);
    } catch (err) {
      setError(err.message);
    } finally {
      setBooking(false);
    }
  }

  if (result) {
    return (
      <div className="booking-confirmation">
        <div className="ticket-receipt">
          <div className="ticket-receipt-main">
            <div className="eyebrow"><span className="dot" />Confirmed</div>
            <h2>You're In</h2>
            <div className="ticket-row">
              <span className="label">Booking ID</span>
              <span className="value">#{String(result.bookingId).padStart(5, '0')}</span>
            </div>
            <div className="ticket-row">
              <span className="label">Seats</span>
              <span className="value">{result.seatCount}</span>
            </div>
            <div className="ticket-row">
              <span className="label">Total paid</span>
              <span className="value">${result.totalAmount}</span>
            </div>
            <button className="btn-primary" onClick={onBack}>Back to Now Showing</button>
          </div>
          <div className="ticket-receipt-stub">ADMIT {result.seatCount}</div>
        </div>
      </div>
    );
  }

  const seatsByRow = seats.reduce((acc, seat) => {
    (acc[seat.ROW_NUMBER] ||= []).push(seat);
    return acc;
  }, {});

  return (
    <div className="seat-picker">
      <button className="back-button" onClick={onBack}>&larr; Back</button>
      <h2>Choose Your Seats</h2>
      {(cinemaName || screenName) && (
        <p className="seat-hall-label">
          {cinemaName}{cinemaName && screenName ? ' — ' : ''}{screenName}
        </p>
      )}

      <div className="screen-arc-wrap">
        <svg width="280" height="50" viewBox="0 0 280 50">
          <path d="M 10 10 Q 140 50 270 10" stroke="#e8b86d" strokeWidth="2" fill="none" opacity="0.5" />
        </svg>
      </div>
      <p className="screen-label">S C R E E N</p>

      {error && <p className="error">{error}</p>}
      {seats.length === 0 && !error && <p className="movie-meta">No seats available for this showtime.</p>}

      <div className="seat-map">
        {Object.entries(seatsByRow).map(([row, rowSeats]) => (
          <div key={row} className="seat-row">
            <span className="row-label">{row}</span>
            {rowSeats.map((seat) => (
              <button
                key={seat.SEAT_ID}
                className={`seat seat-${seat.SEAT_TYPE?.toLowerCase()} ${selected.includes(seat.SEAT_ID) ? 'selected' : ''} ${seat.IS_BOOKED ? 'booked' : ''}`}
                onClick={() => toggleSeat(seat)}
                disabled={seat.IS_BOOKED}
                title={`${seat.SEAT_TYPE} - Seat ${seat.SEAT_NUMBER} - ${seat.IS_BOOKED ? 'Already booked' : basePrice != null ? `$${seatPrice(seat)}` : 'Available'}`}
              >
                {seat.SEAT_NUMBER}
              </button>
            ))}
          </div>
        ))}
      </div>

      {seats.length > 0 && (
        <div className="seat-legend">
          <span className="legend-item">
            <span className="legend-swatch" /> Regular{basePrice != null ? ` · $${basePrice}` : ''}
          </span>
          <span className="legend-item">
            <span className="legend-swatch premium" /> Premium{basePrice != null ? ` · $${Math.round(basePrice * PREMIUM_MULTIPLIER)}` : ''}
          </span>
          <span className="legend-item"><span className="legend-swatch selected" /> Selected</span>
          <span className="legend-item"><span className="legend-swatch booked" /> Booked</span>
        </div>
      )}

      <div className="booking-bar">
        <span className="seat-count">
          {selected.length} seat(s) selected
          {selected.length > 0 && basePrice != null && <> &middot; ${runningTotal}</>}
        </span>
        <button className="btn-primary" onClick={handleBook} disabled={selected.length === 0 || booking}>
          {booking ? 'Booking...' : 'Confirm Booking'}
        </button>
      </div>
    </div>
  );
}