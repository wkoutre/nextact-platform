"use client";

type StoryCardProps = { content: string; onContinue?: () => void };

export function StoryCard({ content, onContinue }: StoryCardProps) {
  return (
    <div className="flex h-dvh flex-col items-center justify-center bg-off-white p-8">
      <blockquote className="max-w-prose border-l-4 border-primary pl-6">
        <p className="font-source-sans text-lg italic leading-relaxed text-charcoal">
          {content}
        </p>
      </blockquote>
      {onContinue && (
        <button
          onClick={onContinue}
          className="mt-10 inline-flex items-center gap-2 rounded-full bg-primary px-6 py-3 font-heading text-sm font-semibold text-white shadow-sm transition-all hover:bg-primary-hover"
        >
          Fortsätt
          <svg className="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth={2.5}>
            <path strokeLinecap="round" strokeLinejoin="round" d="M19 9l-7 7-7-7" />
          </svg>
        </button>
      )}
    </div>
  );
}
