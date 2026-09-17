import { useEffect, useRef, useState } from 'react';
import { api } from '../api';

const ROLE_LABELS = {
  CUSTOMER: 'Customer',
  CINEMA_ADMIN: 'Cinema Admin',
  SITE_ADMIN: 'Site Admin',
};

function formatDate(value, opts) {
  if (!value) return '';
  return new Date(value).toLocaleDateString(undefined, opts);
}

// Turns a DATE_OF_BIRTH / DATE_JOINED value from the API into yyyy-mm-dd
// for an <input type="date">, without shifting a day due to timezone math.
function toDateInputValue(value) {
  if (!value) return '';
  return String(value).slice(0, 10);
}

export default function Profile({ onBack, onProfilePicChange }) {
  const role = api.getRole();
  const isCustomer = role === 'CUSTOMER';

  const [profile, setProfile] = useState(null);
  const [loading, setLoading] = useState(true);
  const [loadError, setLoadError] = useState('');

  const [editing, setEditing] = useState(false);
  const [form, setForm] = useState(null);
  const [saving, setSaving] = useState(false);
  const [saveError, setSaveError] = useState('');
  const [saveMsg, setSaveMsg] = useState('');

  const [showPasswordForm, setShowPasswordForm] = useState(false);
  const [pwForm, setPwForm] = useState({ currentPassword: '', newPassword: '', confirmPassword: '' });
  const [pwError, setPwError] = useState('');
  const [pwSaving, setPwSaving] = useState(false);
  const [pwSuccess, setPwSuccess] = useState('');

  const [historyTab, setHistoryTab] = useState('bookings');
  const [activity, setActivity] = useState(null);
  const [activityLoading, setActivityLoading] = useState(false);
  const [activityError, setActivityError] = useState('');

  const [uploading, setUploading] = useState(false);
  const [uploadError, setUploadError] = useState('');
  const fileInputRef = useRef(null);

  useEffect(() => {
    load();
  }, []);

  useEffect(() => {
    if (!isCustomer) return;
    setActivityLoading(true);
    api.getMyActivity()
      .then(setActivity)
      .catch((err) => setActivityError(err.message))
      .finally(() => setActivityLoading(false));
  }, [isCustomer]);

  function load() {
    setLoading(true);
    setLoadError('');
    api.getMyProfile()
      .then((data) => {
        setProfile(data);
        setForm({
          username: data.USERNAME || '',
          email: data.EMAIL || '',
          dateOfBirth: toDateInputValue(data.DATE_OF_BIRTH),
          profilePictureUrl: data.PROFILE_PIC || '',
        });
        onProfilePicChange?.(data.PROFILE_PIC || null);
      })
      .catch((err) => setLoadError(err.message))
      .finally(() => setLoading(false));
  }

  function startEditing() {
    setSaveError('');
    setSaveMsg('');
    setEditing(true);
  }

  function cancelEditing() {
    setForm({
      username: profile.USERNAME || '',
      email: profile.EMAIL || '',
      dateOfBirth: toDateInputValue(profile.DATE_OF_BIRTH),
      profilePictureUrl: profile.PROFILE_PIC || '',
    });
    setSaveError('');
    setEditing(false);
  }

  async function handleSave(e) {
    e.preventDefault();
    setSaving(true);
    setSaveError('');
    setSaveMsg('');
    try {
      await api.updateMyProfile(form);
      localStorage.setItem('cinehive_username', form.username);
      setEditing(false);
      setSaveMsg('Profile updated.');
      await load();
    } catch (err) {
      setSaveError(err.message);
    } finally {
      setSaving(false);
    }
  }

  // Opens the OS file/photo picker (folder browser on desktop, camera-roll/gallery on mobile).
  function pickPictureFile() {
    fileInputRef.current?.click();
  }

  async function handlePictureFile(e) {
    const file = e.target.files?.[0];
    e.target.value = ''; // let picking the same file again re-trigger onChange
    if (!file) return;

    setUploadError('');
    setUploading(true);
    try {
      const result = await api.uploadMyProfilePicture(file);
      setProfile((prev) => ({ ...prev, PROFILE_PIC: result.profilePictureUrl }));
      setForm((prev) => (prev ? { ...prev, profilePictureUrl: result.profilePictureUrl } : prev));
      onProfilePicChange?.(result.profilePictureUrl);
    } catch (err) {
      setUploadError(err.message);
    } finally {
      setUploading(false);
    }
  }

  async function handlePasswordChange(e) {
    e.preventDefault();
    setPwError('');
    setPwSuccess('');

    if (pwForm.newPassword.length < 8) {
      setPwError('New password must be at least 8 characters.');
      return;
    }
    if (pwForm.newPassword !== pwForm.confirmPassword) {
      setPwError("New passwords don't match.");
      return;
    }

    setPwSaving(true);
    try {
      await api.changeMyPassword(pwForm.currentPassword, pwForm.newPassword);
      setPwSuccess('Password changed.');
      setPwForm({ currentPassword: '', newPassword: '', confirmPassword: '' });
      setTimeout(() => {
        setShowPasswordForm(false);
        setPwSuccess('');
      }, 1500);
    } catch (err) {
      setPwError(err.message);
    } finally {
      setPwSaving(false);
    }
  }

  if (loading) {
    return (
      <div className="profile-page">
        <button className="back-button" onClick={onBack}>&larr; Back</button>
        <p>Loading profile...</p>
      </div>
    );
  }

  if (loadError && !profile) {
    return (
      <div className="profile-page">
        <button className="back-button" onClick={onBack}>&larr; Back</button>
        <p className="error">{loadError}</p>
      </div>
    );
  }

  const bookings = activity?.bookings ?? [];
  const reviews = activity?.reviews ?? [];
  const ratings = activity?.ratings ?? [];

  return (
    <div className="profile-page">
      <button className="back-button" onClick={onBack}>&larr; Back</button>

      <div className="profile-header-card">
        <div className="profile-avatar-wrap">
          <button
            type="button"
            className="profile-avatar-button"
            onClick={pickPictureFile}
            disabled={uploading}
            title="Change profile picture"
          >
            {profile.PROFILE_PIC
              ? <img src={profile.PROFILE_PIC} alt="" className="profile-avatar" />
              : (
                <div className="profile-avatar profile-avatar-placeholder">
                  {profile.USERNAME?.[0]?.toUpperCase() || '?'}
                </div>
              )}
            <span className="profile-avatar-overlay">{uploading ? '...' : '\u270E'}</span>
          </button>
          <input
            ref={fileInputRef}
            type="file"
            accept="image/*"
            className="profile-avatar-file-input"
            onChange={handlePictureFile}
          />
        </div>

        <div className="profile-header-info">
          <h2>{profile.USERNAME}</h2>
          <span className="admin-badge profile-role-badge">{ROLE_LABELS[profile.ROLE] || profile.ROLE}</span>
          {profile.CINEMA_NAME && <p className="movie-meta">{profile.CINEMA_NAME}</p>}
          <p className="movie-meta">
            Member since {formatDate(profile.DATE_JOINED, { year: 'numeric', month: 'long' })}
          </p>
          {uploadError && <p className="error profile-upload-error">{uploadError}</p>}
        </div>

        {!editing && (
          <button className="btn-secondary profile-edit-btn" onClick={startEditing}>Edit Profile</button>
        )}
      </div>

      {saveMsg && !editing && <p className="success-msg">{saveMsg}</p>}

      {editing && (
        <form className="admin-form profile-edit-form" onSubmit={handleSave}>
          {saveError && <p className="error">{saveError}</p>}

          <div className="admin-form-row">
            <div className="field">
              <label>Username</label>
              <input
                value={form.username}
                onChange={(e) => setForm({ ...form, username: e.target.value })}
                required
              />
            </div>
            <div className="field">
              <label>Email</label>
              <input
                type="email"
                value={form.email}
                onChange={(e) => setForm({ ...form, email: e.target.value })}
                required
              />
            </div>
          </div>

          <div className="admin-form-row">
            <div className="field">
              <label>Date of Birth</label>
              <input
                type="date"
                value={form.dateOfBirth}
                onChange={(e) => setForm({ ...form, dateOfBirth: e.target.value })}
              />
            </div>
            <div className="field">
              <label>Profile Picture URL</label>
              <input
                placeholder="https://..."
                value={form.profilePictureUrl}
                onChange={(e) => setForm({ ...form, profilePictureUrl: e.target.value })}
              />
              <span className="field-hint">Paste a link from a website, or click your avatar above to upload a photo instead.</span>
            </div>
          </div>

          {form.profilePictureUrl && (
            <div className="profile-picture-preview-row">
              <span className="movie-meta">Preview:</span>
              <img src={form.profilePictureUrl} alt="" className="profile-avatar profile-avatar-small" />
            </div>
          )}

          <div className="profile-edit-actions">
            <button type="submit" className="btn-gold" disabled={saving}>
              {saving ? 'Saving...' : 'Save Changes'}
            </button>
            <button type="button" className="link-button" onClick={cancelEditing}>Cancel</button>
          </div>
        </form>
      )}

      <div className="profile-section">
        <div className="section-heading">
          <h2>Password</h2>
        </div>

        {!showPasswordForm ? (
          <button className="btn-secondary" onClick={() => setShowPasswordForm(true)}>Change Password</button>
        ) : (
          <form className="admin-form profile-password-form" onSubmit={handlePasswordChange}>
            {pwError && <p className="error">{pwError}</p>}
            {pwSuccess && <p className="success-msg">{pwSuccess}</p>}

            <div className="field">
              <label>Current Password</label>
              <input
                type="password"
                value={pwForm.currentPassword}
                onChange={(e) => setPwForm({ ...pwForm, currentPassword: e.target.value })}
                required
              />
            </div>
            <div className="admin-form-row">
              <div className="field">
                <label>New Password</label>
                <input
                  type="password"
                  value={pwForm.newPassword}
                  onChange={(e) => setPwForm({ ...pwForm, newPassword: e.target.value })}
                  required
                  minLength={8}
                />
              </div>
              <div className="field">
                <label>Confirm New Password</label>
                <input
                  type="password"
                  value={pwForm.confirmPassword}
                  onChange={(e) => setPwForm({ ...pwForm, confirmPassword: e.target.value })}
                  required
                  minLength={8}
                />
              </div>
            </div>

            <div className="profile-edit-actions">
              <button type="submit" className="btn-gold" disabled={pwSaving}>
                {pwSaving ? 'Saving...' : 'Update Password'}
              </button>
              <button
                type="button"
                className="link-button"
                onClick={() => { setShowPasswordForm(false); setPwError(''); setPwForm({ currentPassword: '', newPassword: '', confirmPassword: '' }); }}
              >
                Cancel
              </button>
            </div>
          </form>
        )}
      </div>

      {isCustomer && (
        <div className="profile-section">
          <div className="section-heading">
            <h2>Activity History</h2>
          </div>

          <nav className="tab-nav">
            <button className={`tab ${historyTab === 'bookings' ? 'active' : ''}`} onClick={() => setHistoryTab('bookings')}>
              Bookings {activity && `(${bookings.length})`}
            </button>
            <button className={`tab ${historyTab === 'reviews' ? 'active' : ''}`} onClick={() => setHistoryTab('reviews')}>
              Reviews {activity && `(${reviews.length})`}
            </button>
            <button className={`tab ${historyTab === 'ratings' ? 'active' : ''}`} onClick={() => setHistoryTab('ratings')}>
              Ratings {activity && `(${ratings.length})`}
            </button>
          </nav>

          {activityLoading && <p>Loading history...</p>}
          {activityError && <p className="error">{activityError}</p>}

          {!activityLoading && !activityError && (
            <div className="profile-history-list">
              {historyTab === 'bookings' && (
                bookings.length === 0
                  ? <p className="movie-meta">No bookings yet.</p>
                  : bookings.map((b) => (
                    <div key={b.BOOKING_ID} className="profile-history-item">
                      {b.POSTER_URL
                        ? <img src={b.POSTER_URL} alt="" className="profile-history-thumb" />
                        : <span className="profile-history-thumb-placeholder" />}
                      <div className="profile-history-info">
                        <h4>{b.TITLE}</h4>
                        <p className="movie-meta">
                          {formatDate(b.SHOW_DATE)} &middot; {formatDate(b.START_TIME, { hour: '2-digit', minute: '2-digit' })}
                        </p>
                      </div>
                      <span className={`status-badge status-${b.PAYMENT_STATUS?.toLowerCase()}`}>{b.PAYMENT_STATUS}</span>
                    </div>
                  ))
              )}

              {historyTab === 'reviews' && (
                reviews.length === 0
                  ? <p className="movie-meta">No reviews yet.</p>
                  : reviews.map((r) => (
                    <div key={r.REVIEW_ID} className="profile-history-item profile-history-item-review">
                      {r.POSTER_URL
                        ? <img src={r.POSTER_URL} alt="" className="profile-history-thumb" />
                        : <span className="profile-history-thumb-placeholder" />}
                      <div className="profile-history-info">
                        <h4>{r.TITLE}</h4>
                        <p className="profile-review-text">{r.REVIEW_TEXT}</p>
                        <p className="movie-meta">{formatDate(r.REVIEW_DATE)}</p>
                      </div>
                    </div>
                  ))
              )}

              {historyTab === 'ratings' && (
                ratings.length === 0
                  ? <p className="movie-meta">No ratings yet.</p>
                  : ratings.map((rt) => (
                    <div key={rt.MOVIE_ID} className="profile-history-item">
                      {rt.POSTER_URL
                        ? <img src={rt.POSTER_URL} alt="" className="profile-history-thumb" />
                        : <span className="profile-history-thumb-placeholder" />}
                      <div className="profile-history-info">
                        <h4>{rt.TITLE}</h4>
                        <p className="movie-meta">{formatDate(rt.RATING_DATE)}</p>
                      </div>
                      <span className="profile-rating-value">&#9733; {rt.RATING_VALUE}/10</span>
                    </div>
                  ))
              )}
            </div>
          )}
        </div>
      )}
    </div>
  );
}