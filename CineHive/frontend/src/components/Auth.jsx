import { useState } from 'react';
import { api } from '../api';

export default function Auth({ onLoggedIn }) {
  const [mode, setMode] = useState('login');
  const [lightsOn, setLightsOn] = useState(true);
  const [username, setUsername] = useState('');
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [error, setError] = useState('');
  const [loading, setLoading] = useState(false);

  async function handleSubmit(e) {
    e.preventDefault();
    setError('');
    setLoading(true);
    try {
      const result = mode === 'login'
        ? await api.login(email, password)
        : await api.register(username, email, password);

      api.saveToken(result.token);
      onLoggedIn();
    } catch (err) {
      setError(err.message);
    } finally {
      setLoading(false);
    }
  }

  return (
    <div className={`stage ${lightsOn ? 'lights-on' : 'lights-off'}`}>
      <div className="curtain curtain-left" />
      <div className="curtain curtain-right" />

      <div className="spotlight-rig">
        <div className="spotlight-cone" />
        <button
          className="pull-cord"
          onClick={() => setLightsOn((v) => !v)}
          aria-label="Toggle house lights"
          title={lightsOn ? 'Pull to dim the lights' : 'Pull to bring up the lights'}
        >
          <span className="cord-string" />
          <span className="cord-knob" />
        </button>
        <span className="cord-hint">{lightsOn ? 'Pull to begin' : "Let's go"}</span>
      </div>

      <div className="login-card">
        <div className="login-card-header">
          <span className="login-wordmark">CINE<span>HIVE</span></span>
          <p className="login-subtitle">{mode === 'login' ? 'Your seat is waiting' : 'Reserve your seat'}</p>
        </div>

        <form onSubmit={handleSubmit} className="auth-form">
          {mode === 'register' && (
            <div className="field">
              <label>Username</label>
              <input
                type="text"
                placeholder="e.g. cinefan1"
                value={username}
                onChange={(e) => setUsername(e.target.value)}
                required
              />
            </div>
          )}
          <div className="field">
            <label>Email</label>
            <input
              type="email"
              placeholder="you@example.com"
              value={email}
              onChange={(e) => setEmail(e.target.value)}
              required
            />
          </div>
          <div className="field">
            <label>Password</label>
            <input
              type="password"
              placeholder="••••••••"
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              required
            />
          </div>

          {error && <p className="error">{error}</p>}

          <button type="submit" className="btn-gold" disabled={loading}>
            {loading ? 'Please wait...' : mode === 'login' ? 'Sign In' : 'Create Account'}
          </button>
        </form>

        <p className="switch-mode">
          {mode === 'login' ? "New here? " : 'Already have an account? '}
          <button
            type="button"
            className="link-button"
            onClick={() => { setMode(mode === 'login' ? 'register' : 'login'); setError(''); }}
          >
            {mode === 'login' ? 'Create an account' : 'Log in'}
          </button>
        </p>
      </div>
    </div>
  );
}