import { useEffect, useState } from 'react';
import { getConsent, setConsent } from '../lib/consent';
import { isAnalyticsConfigured, loadGoogleAnalytics, trackPageView } from '../lib/analytics';

export function ConsentBanner() {
  const [visible, setVisible] = useState(false);

  // Ce composant est rendu en enfant de Layout, donc cet effet s'exécute
  // avant celui de Layout au montage (React déclenche les effets des
  // enfants avant ceux des parents) : loadGoogleAnalytics() a déjà mis
  // `loaded` à true quand Layout envoie le premier page_view via son
  // propre effet sur location.pathname. Pas besoin d'appeler
  // trackPageView ici pour ce cas.
  useEffect(() => {
    if (!isAnalyticsConfigured()) return;
    const consent = getConsent();
    if (consent === 'accepted') {
      loadGoogleAnalytics();
    } else if (consent === null) {
      setVisible(true);
    }
  }, []);

  if (!visible) return null;

  function handleAccept() {
    setConsent('accepted');
    loadGoogleAnalytics();
    trackPageView(window.location.pathname);
    setVisible(false);
  }

  function handleDecline() {
    setConsent('declined');
    setVisible(false);
  }

  return (
    <div className="fixed bottom-0 inset-x-0 z-40 bg-white border-t border-slate-200 shadow-lg">
      <div className="max-w-3xl mx-auto px-4 py-3 flex flex-col sm:flex-row sm:items-center gap-3">
        <p className="text-sm text-slate-700 flex-1">
          Ce site utilise Google Analytics pour mesurer l'audience de façon anonyme. Aucune
          donnée n'est utilisée à des fins publicitaires.
        </p>
        <div className="flex gap-2 shrink-0">
          <button type="button" onClick={handleDecline} className="btn-secondary flex-1 sm:flex-none">
            Refuser
          </button>
          <button type="button" onClick={handleAccept} className="btn-primary flex-1 sm:flex-none">
            Accepter
          </button>
        </div>
      </div>
    </div>
  );
}
