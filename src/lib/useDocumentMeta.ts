import { useEffect } from 'react';

const SITE_NAME = 'QuizSecours';

function setMetaTag(attr: 'name' | 'property', key: string, content: string) {
  let el = document.querySelector(`meta[${attr}="${key}"]`);
  if (!el) {
    el = document.createElement('meta');
    el.setAttribute(attr, key);
    document.head.appendChild(el);
  }
  el.setAttribute('content', content);
}

function setCanonical(href: string) {
  let el = document.querySelector('link[rel="canonical"]');
  if (!el) {
    el = document.createElement('link');
    el.setAttribute('rel', 'canonical');
    document.head.appendChild(el);
  }
  el.setAttribute('href', href);
}

// SPA sans SSR : ces balises ne profitent qu'aux crawlers qui exécutent le JS
// (Google le fait), mais c'est la meilleure amélioration possible sans passer
// à un framework SSR. Chaque page appelle ce hook avec un titre/description
// spécifiques au lieu de garder le <title> statique d'index.html partout.
export function useDocumentMeta(title: string, description: string) {
  useEffect(() => {
    const fullTitle = `${title} | ${SITE_NAME}`;
    document.title = fullTitle;
    setMetaTag('name', 'description', description);
    setMetaTag('property', 'og:title', fullTitle);
    setMetaTag('property', 'og:description', description);
    setMetaTag('property', 'og:url', window.location.href);
    setMetaTag('name', 'twitter:title', fullTitle);
    setMetaTag('name', 'twitter:description', description);
    setCanonical(window.location.origin + window.location.pathname);
  }, [title, description]);
}
