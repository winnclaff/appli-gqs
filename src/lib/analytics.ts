// GA4 chargé uniquement après consentement explicite (bannière) et
// uniquement si VITE_GA_MEASUREMENT_ID est renseigné. Rien n'est chargé
// par défaut : pas de script, pas de cookie, pas d'appel réseau tant que
// l'utilisateur n'a pas cliqué "Accepter".
const GA_ID = import.meta.env.VITE_GA_MEASUREMENT_ID as string | undefined;

declare global {
  interface Window {
    dataLayer?: unknown[];
    gtag?: (...args: unknown[]) => void;
  }
}

let loaded = false;

export function isAnalyticsConfigured(): boolean {
  return Boolean(GA_ID);
}

export function loadGoogleAnalytics(): void {
  if (loaded || !GA_ID) return;
  loaded = true;

  const script = document.createElement('script');
  script.async = true;
  script.src = `https://www.googletagmanager.com/gtag/js?id=${GA_ID}`;
  document.head.appendChild(script);

  window.dataLayer = window.dataLayer || [];
  window.gtag = function gtag(...args: unknown[]) {
    window.dataLayer!.push(args);
  };
  window.gtag('js', new Date());
  // send_page_view désactivé : on envoie les pageviews nous-mêmes à chaque
  // changement de route (voir trackPageView), le chargement initial du
  // script ne correspond pas forcément à la première vraie navigation.
  window.gtag('config', GA_ID, { send_page_view: false });
}

export function trackPageView(path: string, title?: string): void {
  if (!loaded || !window.gtag) return;
  window.gtag('event', 'page_view', {
    page_path: path,
    page_title: title,
    page_location: window.location.href,
  });
}
