import { useState } from 'react';
import { Check, Flag } from 'lucide-react';
import { reportQuestionError } from '../lib/api';

type Props = {
  questionId: string;
  questionNumber: number | null;
};

// Rendu avec key={questionId} par l'appelant pour que le statut reparte à
// zéro à chaque nouvelle question (remontage du composant).
export function ReportErrorButton({ questionId, questionNumber }: Props) {
  const [status, setStatus] = useState<'idle' | 'sending' | 'sent' | 'error'>('idle');

  async function handleClick() {
    if (status === 'sending' || status === 'sent') return;
    setStatus('sending');
    try {
      await reportQuestionError(questionId, questionNumber);
      setStatus('sent');
    } catch {
      setStatus('error');
    }
  }

  if (status === 'sent') {
    return (
      <span className="inline-flex items-center gap-1 text-xs text-green-700">
        <Check className="h-3.5 w-3.5" aria-hidden />
        Signalé, merci
      </span>
    );
  }

  return (
    <button
      type="button"
      onClick={handleClick}
      disabled={status === 'sending'}
      className="inline-flex items-center gap-1 text-xs text-slate-500 hover:text-red-700 disabled:opacity-50"
    >
      <Flag className="h-3.5 w-3.5" aria-hidden />
      {status === 'error' ? 'Réessayer' : 'Signaler une erreur'}
    </button>
  );
}
