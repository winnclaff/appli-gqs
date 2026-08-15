const CONSENT_KEY = 'gqs.analytics_consent.v1';

export type ConsentValue = 'accepted' | 'declined';

export function getConsent(): ConsentValue | null {
  try {
    const raw = localStorage.getItem(CONSENT_KEY);
    if (raw === 'accepted' || raw === 'declined') return raw;
  } catch {
    // localStorage indisponible — on considère le consentement non donné.
  }
  return null;
}

export function setConsent(value: ConsentValue): void {
  try {
    localStorage.setItem(CONSENT_KEY, value);
  } catch {
    // silencieux
  }
}
