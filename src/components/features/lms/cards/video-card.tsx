"use client";

import { VimeoPlayer } from "@/components/features/lms/vimeo-player";

type VideoCardProps = {
  title: string;
  videoId?: string;
  onComplete?: () => void;
  onContinue?: () => void;
};

export function VideoCard({
  title,
  videoId,
  onComplete,
  onContinue,
}: VideoCardProps) {
  return (
    <div className="w-full bg-white">
      {/* Video — full content width */}
      {videoId ? (
        <VimeoPlayer
          videoId={videoId}
          onComplete={onComplete}
          className="w-full rounded-none"
        />
      ) : (
        <div className="aspect-video w-full bg-gray-100" />
      )}

      {/* Title + continue button */}
      <div className="px-6 py-8 sm:px-8">
        {title && (
          <h2 className="font-heading text-2xl font-bold text-navy">{title}</h2>
        )}
        <button
          type="button"
          onClick={onContinue}
          className="mt-6 inline-flex items-center rounded-full bg-primary px-8 py-3 font-heading text-base font-bold text-white transition-all hover:bg-primary-hover"
        >
          Fortsätt →
        </button>
      </div>
    </div>
  );
}
