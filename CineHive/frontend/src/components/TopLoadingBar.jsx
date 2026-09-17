import { useEffect, useState } from 'react';
import { subscribeToLoading } from '../api';

export default function TopLoadingBar() {
  const [loading, setLoading] = useState(false);

  useEffect(() => {
    // subscribeToLoading calls back immediately with the current state,
    // then again every time it changes.
    return subscribeToLoading(setLoading);
  }, []);

  return (
    <div className={`top-loading-bar ${loading ? 'active' : ''}`} aria-hidden="true">
      <div className="top-loading-bar-fill" />
    </div>
  );
}