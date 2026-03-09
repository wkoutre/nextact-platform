"use client";

type StoryCardProps = { content: string; onContinue?: () => void };

export function StoryCard({ content, onContinue }: StoryCardProps) {
  return (
    <div className="w-full bg-primary px-6 py-10 sm:px-10 sm:py-12">
      <div className="mx-auto max-w-2xl">
        <blockquote className="border-l-4 border-white/40 pl-6">
          <p className="font-body text-lg italic leading-relaxed text-white/90">
            {content}
          </p>
        </blockquote>
        {onContinue && (
          <button
            onClick={onContinue}
            className="mt-8 rounded-full border-2 border-white bg-white px-6 py-2.5 font-heading text-sm font-bold text-primary transition-all hover:bg-white/90"
          >
            Till nästa
          </button>
        )}
      </div>
    </div>
  );
}
