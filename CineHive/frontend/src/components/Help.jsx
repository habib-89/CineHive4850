import { useState } from 'react';
import { api } from '../api';

const SECTIONS = [
  {
    title: 'Browsing Movies',
    body: [
      'The Home tab shows what\u2019s featured up top, followed by rows of movies grouped by genre \u2014 scroll each row sideways to see more.',
      'Click any poster (or "View Movie" on the featured banner) to open its full details: synopsis, cast, director, trailer, showtimes, and reviews.',
    ],
  },
  {
    title: 'Searching for a Movie',
    body: [
      'Use the search box at the top of the page and start typing a title \u2014 matching movies appear in a dropdown as you type.',
      'Use the genre dropdown next to the search box to browse an entire genre, with or without typing a title. Picking a genre with the box empty shows every movie in that genre; typing a title alongside it narrows to just that genre.',
      'Click "See all results" (or press Enter) to see the full results page instead of the quick dropdown.',
    ],
  },
  {
    title: '"Now Showing in Cinemas"',
    body: [
      'The panel on the Home page lists movies with upcoming showtimes across all cinemas.',
      'Use the "All Cinemas" dropdown there to narrow the list down to a single cinema.',
    ],
  },
  {
    title: 'Buying a Ticket',
    body: [
      'Open a movie\u2019s page and pick a showtime from the list \u2014 each one shows the cinema, screen, time, and how many seats are left.',
      'On the seat map, click the seats you want (they\u2019ll highlight), then confirm your booking. Sold and already-selected seats can\u2019t be picked.',
      'Your ticket then shows up under "My Bookings" in the top navigation, where you can review or cancel it.',
    ],
  },
  {
    title: 'Watchlist',
    body: [
      'On any movie\u2019s page, use the watchlist button to save it for later.',
      'Everything you\u2019ve saved appears under the Watchlist tab.',
    ],
  },
  {
    title: 'Ratings & Reviews',
    body: [
      'On a movie\u2019s page you can leave a star rating and, separately, write a text review \u2014 both are visible to other users browsing that movie.',
    ],
  },
  {
    title: 'Your Profile',
    body: [
      'Click your avatar/name in the top-right corner to open your profile, where you can update your username, nickname, email, date of birth, and profile picture, change your password, and review your booking, review, and rating history.',
    ],
  },
];

export default function Help({ onBack }) {
  const [message, setMessage] = useState('');
  const [submitting, setSubmitting] = useState(false);
  const [error, setError] = useState('');
  const [success, setSuccess] = useState('');

  async function handleSubmit(e) {
    e.preventDefault();
    const trimmed = message.trim();
    if (!trimmed) return;

    setError('');
    setSuccess('');
    setSubmitting(true);
    try {
      await api.submitFeedback(trimmed);
      setMessage('');
      setSuccess('Thanks! Your suggestion has been sent to the CineHive team.');
    } catch (err) {
      setError(err.message);
    } finally {
      setSubmitting(false);
    }
  }

  return (
    <div className="help-page">
      {onBack && <button className="back-button" onClick={onBack}>&larr; Back</button>}

      <div className="section-heading">
        <h2>Help &amp; How CineHive Works</h2>
      </div>

      <div className="help-sections">
        {SECTIONS.map((section) => (
          <div key={section.title} className="help-section">
            <h3>{section.title}</h3>
            {section.body.map((p, i) => (
              <p key={i} className="help-section-text">{p}</p>
            ))}
          </div>
        ))}
      </div>

      <div className="help-section help-feedback-section">
        <h3>Have a suggestion?</h3>
        <p className="help-section-text">
          Tell us what would make CineHive better . your message goes straight to the site admin team and isn't visible to other users.
        </p>

        <form onSubmit={handleSubmit} className="admin-form help-feedback-form">
          <div className="field">
            <textarea
              rows={4}
              maxLength={2000}
              placeholder="What should we add, fix, or improve?"
              value={message}
              onChange={(e) => setMessage(e.target.value)}
              required
            />
          </div>

          {error && <p className="error">{error}</p>}
          {success && <p className="success-msg">{success}</p>}

          <button type="submit" className="btn-primary" disabled={submitting || !message.trim()}>
            {submitting ? 'Sending...' : 'Send Suggestion'}
          </button>
        </form>
      </div>
    </div>
  );
}