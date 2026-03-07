"use client";

import { motion } from "framer-motion";

type TextCardProps = {
  title?: string;
  content: string;
  onContinue?: () => void;
};

export function TextCard({ title, content, onContinue }: TextCardProps) {
  return (
    <div className="flex h-dvh flex-col items-center justify-center bg-off-white p-6">
      <motion.div
        initial={{ opacity: 0, y: 24 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ duration: 0.5, ease: "easeOut" }}
        className="mx-auto w-full max-w-2xl"
      >
        {title && (
          <h2 className="mb-6 font-heading text-2xl font-bold text-navy md:text-3xl">
            {title}
          </h2>
        )}
        <div className="space-y-4 text-lg leading-relaxed text-charcoal">
          {content.split("\n\n").map((paragraph, i) => (
            <p key={i}>{paragraph}</p>
          ))}
        </div>
        {onContinue && (
          <motion.button
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            transition={{ delay: 0.8 }}
            onClick={onContinue}
            className="mt-8 inline-flex items-center gap-2 rounded-full bg-primary px-6 py-3 font-heading text-sm font-semibold text-white shadow-sm transition-all hover:bg-primary-hover"
          >
            Fortsätt
            <svg className="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth={2.5}>
              <path strokeLinecap="round" strokeLinejoin="round" d="M19 9l-7 7-7-7" />
            </svg>
          </motion.button>
        )}
      </motion.div>
    </div>
  );
}
