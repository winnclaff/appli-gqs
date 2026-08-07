import { ExternalLink } from 'lucide-react';

type Props = {
  sourceName: string;
  sourceRef?: string | null;
  sourceUrl?: string | null;
};

export function SourceTag({ sourceName, sourceRef, sourceUrl }: Props) {
  const label = sourceRef ? `${sourceName} — ${sourceRef}` : sourceName;
  if (sourceUrl) {
    return (
      <a
        href={sourceUrl}
        target="_blank"
        rel="noreferrer noopener"
        className="inline-flex items-center gap-1 text-xs text-slate-600 hover:text-brand-700 underline underline-offset-2"
      >
        <span>Source : {label}</span>
        <ExternalLink className="h-3 w-3" aria-hidden />
      </a>
    );
  }
  return <span className="text-xs text-slate-600">Source : {label}</span>;
}
