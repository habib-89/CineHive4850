import { Fragment, useEffect, useState } from 'react';
import { api } from '../api';

export default function AdminCustomers() {
  const [customers, setCustomers] = useState([]);
  const [error, setError] = useState('');
  const [loading, setLoading] = useState(true);
  const [expandedId, setExpandedId] = useState(null);
  const [activity, setActivity] = useState(null);
  const [activityLoading, setActivityLoading] = useState(false);
  const [activityError, setActivityError] = useState('');

  useEffect(() => {
    api.getCustomers()
      .then(setCustomers)
      .catch((err) => setError(err.message))
      .finally(() => setLoading(false));
  }, []);

  async function toggleExpand(userId) {
    if (expandedId === userId) {
      setExpandedId(null);
      return;
    }
    setExpandedId(userId);
    setActivity(null);
    setActivityError('');
    setActivityLoading(true);
    try {
      const data = await api.getCustomerActivity(userId);
      setActivity(data);
    } catch (err) {
      setActivityError(err.message);
    } finally {
      setActivityLoading(false);
    }
  }

  return (
    <div>
      <div className="section-heading">
        <h2>Customers</h2>
        {!loading && !error && <span className="count">{customers.length} total</span>}
      </div>

      {loading && <p>Loading...</p>}
      {error && <p className="error">{error}</p>}

      <table className="admin-table">
        <thead>
          <tr>
            <th>Username</th><th>Email</th><th>Joined</th><th>Bookings</th><th>Spent</th><th>Reviews</th><th>Ratings</th><th></th>
          </tr>
        </thead>
        <tbody>
          {customers.map((c) => (
            <Fragment key={c.USER_ID}>
              <tr>
                <td>{c.USERNAME}</td>
                <td>{c.EMAIL}</td>
                <td>{new Date(c.DATE_JOINED).toLocaleDateString()}</td>
                <td>{c.BOOKING_COUNT}</td>
                <td>${c.TOTAL_SPENT}</td>
                <td>{c.REVIEW_COUNT}</td>
                <td>{c.RATING_COUNT}</td>
                <td>
                  <button className="link-button small" onClick={() => toggleExpand(c.USER_ID)}>
                    {expandedId === c.USER_ID ? 'Hide Activity' : 'View Activity'}
                  </button>
                </td>
              </tr>
              {expandedId === c.USER_ID && (
                <tr>
                  <td colSpan={8}>
                    <div className="admin-activity-panel">
                      {activityLoading && <p>Loading activity...</p>}
                      {activityError && <p className="error">{activityError}</p>}
                      {activity && (
                        <>
                          <h4>Bookings</h4>
                          {activity.bookings.length === 0 && <p className="movie-meta">No bookings.</p>}
                          {activity.bookings.map((b) => (
                            <div key={b.BOOKING_ID} className="activity-row">
                              <span>{b.TITLE}</span>
                              <span className="movie-meta">
                                {new Date(b.SHOW_DATE).toLocaleDateString()} · ${b.TOTAL_AMOUNT} · {b.PAYMENT_STATUS}
                              </span>
                            </div>
                          ))}

                          <h4>Reviews</h4>
                          {activity.reviews.length === 0 && <p className="movie-meta">No reviews.</p>}
                          {activity.reviews.map((r) => (
                            <div key={r.REVIEW_ID} className="activity-row">
                              <span>{r.TITLE}</span>
                              <span className="movie-meta">{r.REVIEW_TEXT}</span>
                            </div>
                          ))}

                          <h4>Ratings</h4>
                          {activity.ratings.length === 0 && <p className="movie-meta">No ratings.</p>}
                          {activity.ratings.map((rt, i) => (
                            <div key={i} className="activity-row">
                              <span>{rt.TITLE}</span>
                              <span className="movie-meta">{rt.RATING_VALUE}/10</span>
                            </div>
                          ))}
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