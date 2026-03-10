"use client";

import Image from "next/image";
import { useRouter } from "next/navigation";

type StepStatus = "completed" | "active" | "locked";

type Step = {
  id: string;
  order: number;
  title: string;
  status: StepStatus;
};

// Hotspot positions as percentages of the image dimensions.
// Measured from the numbered circles in NextAct_kartan.png.
const HOTSPOT_POSITIONS: Record<number, { x: number; y: number }> = {
  1: { x: 8.2, y: 22 },
  2: { x: 12.5, y: 59 },
  3: { x: 37, y: 54 },
  4: { x: 53, y: 16 },
  5: { x: 47, y: 73 },
  6: { x: 66, y: 59 },
  7: { x: 86, y: 21 },
};

function LockIcon() {
  return (
    <svg width="12" height="12" viewBox="0 0 24 24" fill="currentColor">
      <path d="M17 11V7A5 5 0 0 0 7 7v4a2 2 0 0 0-2 2v8a2 2 0 0 0 2 2h10a2 2 0 0 0 2-2v-8a2 2 0 0 0-2-2zm-5 6a1.5 1.5 0 1 1 0-3 1.5 1.5 0 0 1 0 3zm3-6H9V7a3 3 0 0 1 6 0v4z" />
    </svg>
  );
}

function CheckIcon() {
  return (
    <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="3" strokeLinecap="round" strokeLinejoin="round">
      <polyline points="20 6 9 17 4 12" />
    </svg>
  );
}

function Hotspot({ step, onClick }: { step: Step; onClick: () => void }) {
  const pos = HOTSPOT_POSITIONS[step.order];
  if (!pos) return null;

  const isCompleted = step.status === "completed";
  const isActive = step.status === "active";
  const isLocked = step.status === "locked";

  return (
    <button
      onClick={isLocked ? undefined : onClick}
      disabled={isLocked}
      title={isLocked ? "Låst" : step.title}
      aria-label={`Steg ${step.order}: ${step.title}${isLocked ? " (låst)" : ""}`}
      style={{ left: `${pos.x}%`, top: `${pos.y}%` }}
      className="absolute -translate-x-1/2 -translate-y-1/2 focus:outline-none"
    >
      {/* Pulse ring for active step */}
      {isActive && (
        <span className="absolute inset-0 -m-1.5 animate-ping rounded-full bg-white/60" />
      )}

      {/* Main circle */}
      <span
        className={`
          relative flex h-9 w-9 items-center justify-center rounded-full border-2 text-sm font-bold shadow-md transition-transform
          ${isCompleted
            ? "border-white bg-green-500 text-white hover:scale-110"
            : isActive
              ? "border-white bg-white text-navy scale-110 shadow-lg hover:scale-[1.15]"
              : "border-white/30 bg-black/40 text-white/50 cursor-not-allowed"
          }
        `}
      >
        {isCompleted ? (
          <CheckIcon />
        ) : isLocked ? (
          <LockIcon />
        ) : (
          step.order
        )}
      </span>

      {/* Tooltip on hover */}
      {!isLocked && (
        <span className="pointer-events-none absolute bottom-full left-1/2 mb-2 -translate-x-1/2 whitespace-nowrap rounded-lg bg-navy px-2.5 py-1 text-xs font-semibold text-white opacity-0 shadow-lg transition-opacity group-hover:opacity-100">
          {step.title}
        </span>
      )}
    </button>
  );
}

export function JourneyMap({ steps }: { steps: Step[] }) {
  const router = useRouter();

  return (
    <div className="relative w-full overflow-hidden rounded-2xl shadow-sm">
      <Image
        src="/images/kartan.png"
        alt="Din resa"
        width={1450}
        height={810}
        className="w-full"
        priority
      />
      {steps.map((step) => (
        <Hotspot
          key={step.id}
          step={step}
          onClick={() => router.push(`/learn/${step.id}`)}
        />
      ))}
    </div>
  );
}
