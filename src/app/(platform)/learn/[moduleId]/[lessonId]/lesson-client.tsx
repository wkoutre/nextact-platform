"use client";

import Link from "next/link";
import { useCallback, useRef } from "react";
import {
  LessonFeed,
  type ContentBlock,
} from "@/components/features/lms/lesson-feed";
import {
  markLessonCompleted,
  submitExerciseResponse,
} from "@/lib/actions/lessons";

type LessonClientProps = {
  blocks: ContentBlock[];
  lessonId: string;
  moduleName: string;
  moduleHref: string;
  lessonTitle: string;
};

export function LessonClient({
  blocks,
  lessonId,
  moduleName,
  moduleHref,
  lessonTitle,
}: LessonClientProps) {
  const responsesRef = useRef<Record<string, unknown>>({});
  const completedRef = useRef(false);

  const handleExerciseSubmit = useCallback(
    async (blockIndex: number, response: unknown) => {
      responsesRef.current[String(blockIndex)] = response;
      await submitExerciseResponse(lessonId, responsesRef.current);
    },
    [lessonId]
  );

  const handleCardChange = useCallback(
    async (index: number) => {
      const block = blocks[index];
      if (block?.type === "completion" && !completedRef.current) {
        completedRef.current = true;
        await markLessonCompleted(lessonId);
      }
    },
    [blocks, lessonId]
  );

  return (
    <div className="-mx-4 -my-6 sm:-mx-6 lg:-mx-8 lg:-my-8">
      {/* Breadcrumb sub-header */}
      <div className="border-b border-gray-200 bg-white px-4 py-3 sm:px-6">
        <nav aria-label="Brödsmulor" className="flex items-center gap-1.5 text-sm">
          <Link href="/learn" className="text-gray-500 hover:text-navy transition-colors">
            Program
          </Link>
          <span className="text-gray-300">/</span>
          <Link href={moduleHref} className="max-w-[160px] truncate text-gray-500 hover:text-navy transition-colors sm:max-w-xs">
            {moduleName}
          </Link>
          <span className="text-gray-300">/</span>
          <span className="max-w-[160px] truncate font-medium text-navy sm:max-w-xs">
            {lessonTitle}
          </span>
        </nav>
      </div>

      <LessonFeed
        blocks={blocks}
        onCardChange={handleCardChange}
        onExerciseSubmit={handleExerciseSubmit}
      />
    </div>
  );
}
