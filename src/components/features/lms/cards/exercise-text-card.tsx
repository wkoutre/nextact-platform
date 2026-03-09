"use client";

import { useState } from "react";

type ExerciseTextCardProps = {
  prompt: string;
  placeholder?: string;
  maxLength?: number;
  onSubmit?: (response: string) => void;
};

export function ExerciseTextCard({ prompt, placeholder, maxLength, onSubmit }: ExerciseTextCardProps) {
  const [value, setValue] = useState("");
  const [submitted, setSubmitted] = useState(false);

  function handleSubmit() {
    if (!value.trim()) return;
    onSubmit?.(value);
    setSubmitted(true);
  }

  return (
    <div className="w-full bg-white px-6 py-8 sm:px-10">
      <div className="mx-auto max-w-2xl">
        <h3 className="font-heading text-xl font-bold text-primary">{prompt}</h3>
        <textarea
          value={value}
          onChange={(e) => setValue(e.target.value)}
          placeholder={placeholder ?? "Skriv ditt svar här..."}
          maxLength={maxLength}
          disabled={submitted}
          rows={5}
          className="mt-4 w-full rounded-lg border-2 border-primary bg-[#E8EEF5] px-4 py-3 text-base text-navy placeholder-charcoal/50 outline-none transition focus:border-primary focus:ring-2 focus:ring-primary/20 disabled:opacity-60"
        />
        {!submitted ? (
          <button
            onClick={handleSubmit}
            disabled={!value.trim()}
            className="mt-4 rounded-full bg-primary px-6 py-2.5 font-heading text-sm font-bold text-white transition hover:bg-primary-hover disabled:opacity-40"
          >
            Skicka svar
          </button>
        ) : (
          <p className="mt-3 text-sm font-medium text-success">Svar sparat!</p>
        )}
      </div>
    </div>
  );
}
