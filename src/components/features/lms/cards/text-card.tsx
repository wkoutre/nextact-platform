"use client";

import { motion } from "framer-motion";

type TextCardProps = { title?: string; content: string; onContinue?: () => void };

export function TextCard({ title, content, onContinue }: TextCardProps) {
  return (
    <div className="w-full bg-primary px-6 py-10 sm:px-10 sm:py-12">
      <motion.div
        initial={{ opacity: 0, y: 16 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ duration: 0.4 }}
        className="mx-auto max-w-2xl"
      >
        {title && (
          <h2 className="font-heading text-3xl font-extrabold text-white sm:text-4xl">
            {title}
          </h2>
        )}
        <div className="mt-4 space-y-3 text-base leading-relaxed text-white/90">
          {content.split("\n\n").map((paragraph, i) => (
            <p key={i}>{paragraph}</p>
          ))}
        </div>
        {onContinue && (
          <button
            onClick={onContinue}
            className="mt-8 rounded-full border-2 border-white bg-white px-6 py-2.5 font-heading text-sm font-bold text-primary transition-all hover:bg-white/90"
          >
            Till nästa
          </button>
        )}
      </motion.div>
    </div>
  );
}
