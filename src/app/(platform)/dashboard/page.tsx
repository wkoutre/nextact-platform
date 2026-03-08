import type { Metadata } from "next";
import Link from "next/link";
import Image from "next/image";
import { createClient } from "@/lib/supabase/server";

export const metadata: Metadata = {
  title: "Dashboard — Next Act",
};

const HERO_IMAGE_URL =
  "https://jdpqgfwzzxypjfhrtcsc.supabase.co/storage/v1/object/public/Next%20Act%20arbete/rasmus%20elm.png";

export default async function DashboardPage() {
  const supabase = await createClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();

  const userId = user!.id;
  const displayName =
    user!.user_metadata?.display_name ??
    user!.email?.split("@")[0] ??
    "Idrottare";

  const [streakResult, progressResult, recentResult] = await Promise.all([
    supabase
      .from("user_streaks")
      .select("current_streak, longest_streak, last_activity_date")
      .eq("user_id", userId)
      .single(),
    supabase
      .from("module_progress")
      .select("module_id, lessons_completed, lessons_total, completed_at")
      .eq("user_id", userId)
      .is("completed_at", null)
      .order("created_at", { ascending: false })
      .limit(1)
      .single(),
    supabase
      .from("lesson_progress")
      .select("lesson_id, status, completed_at")
      .eq("user_id", userId)
      .eq("status", "completed")
      .order("completed_at", { ascending: false })
      .limit(5),
  ]);

  const streak = streakResult.data;
  const currentModule = progressResult.data;
  const recentLessons = recentResult.data ?? [];

  const modulePercent =
    currentModule && (currentModule.lessons_total ?? 0) > 0
      ? Math.round(
          ((currentModule.lessons_completed ?? 0) /
            (currentModule.lessons_total ?? 1)) *
            100
        )
      : 0;

  const lessonsRemaining = Math.max(
    0,
    (currentModule?.lessons_total ?? 0) -
      (currentModule?.lessons_completed ?? 0)
  );

  return (
    <div className="space-y-8">
      {/* Hero card */}
      <div className="relative min-h-[220px] overflow-hidden rounded-2xl bg-dark">
        {/* Athlete photo — right half */}
        <div className="absolute inset-y-0 right-0 w-1/2">
          <Image
            src={HERO_IMAGE_URL}
            alt=""
            fill
            className="object-cover object-top"
            priority
            unoptimized
          />
          {/* Gradient fade from dark to transparent */}
          <div className="absolute inset-y-0 left-0 w-32 bg-gradient-to-r from-dark to-transparent" />
        </div>

        {/* Text — left half */}
        <div className="relative z-10 flex max-w-[55%] flex-col justify-center px-8 py-10 lg:py-12">
          <p className="text-sm font-medium uppercase tracking-widest text-gray-400">
            Välkommen tillbaka
          </p>
          <h1 className="mt-2 font-heading text-3xl font-extrabold text-white lg:text-4xl">
            {displayName}
          </h1>
          <p className="mt-2 text-sm text-gray-400">
            {currentModule
              ? `${lessonsRemaining} lektion${lessonsRemaining !== 1 ? "er" : ""} kvar i pågående modul`
              : "Starta din första lektion"}
          </p>
          <Link
            href="/learn"
            className="mt-6 inline-flex w-fit items-center gap-2 rounded-xl bg-primary px-5 py-2.5 text-sm font-semibold text-white transition-colors hover:bg-primary-hover"
          >
            Fortsätt träna
            <svg className="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth={2}>
              <path strokeLinecap="round" strokeLinejoin="round" d="M13.5 4.5 21 12m0 0-7.5 7.5M21 12H3" />
            </svg>
          </Link>
        </div>
      </div>

      {/* Stats row */}
      <div className="grid gap-4 sm:grid-cols-3">
        {/* Streak */}
        <div className="rounded-2xl bg-off-white p-6">
          <p className="text-xs font-semibold uppercase tracking-widest text-charcoal">
            Dagar i rad
          </p>
          <p className="mt-2 font-heading text-5xl font-extrabold text-navy">
            {streak?.current_streak ?? 0}
          </p>
          <p className="mt-1 text-sm text-charcoal">
            {(streak?.current_streak ?? 0) >= 7
              ? "Fantastiskt — du är på gång!"
              : (streak?.current_streak ?? 0) > 0
                ? "Bra jobbat, fortsätt så!"
                : "Börja en ny streak idag"}
          </p>
        </div>

        {/* Module progress */}
        <div className="rounded-2xl bg-off-white p-6">
          <p className="text-xs font-semibold uppercase tracking-widest text-charcoal">
            Modulframsteg
          </p>
          <p className="mt-2 font-heading text-5xl font-extrabold text-navy">
            {modulePercent}%
          </p>
          <p className="mt-1 text-sm text-charcoal">
            {currentModule
              ? `${currentModule.lessons_completed} av ${currentModule.lessons_total} lektioner klara`
              : "Påbörja din första modul"}
          </p>
        </div>

        {/* Bollplank */}
        <div className="flex flex-col justify-between rounded-2xl bg-dark p-6">
          <div>
            <p className="text-xs font-semibold uppercase tracking-widest text-gray-400">
              Bollplank
            </p>
            <p className="mt-2 font-heading text-lg font-bold text-white">
              Ditt mentala bollplank
            </p>
            <p className="mt-1 text-sm text-gray-400">
              Ställ frågor, bearbeta tankar
            </p>
          </div>
          <Link
            href="/coach"
            className="mt-4 inline-flex w-full items-center justify-center rounded-xl bg-primary px-4 py-2.5 text-sm font-semibold text-white transition-colors hover:bg-primary-hover"
          >
            Öppna chatten
          </Link>
        </div>
      </div>

      {/* Recent activity */}
      {recentLessons.length > 0 && (
        <section>
          <h2 className="font-heading text-lg font-semibold text-navy">
            Senaste aktivitet
          </h2>
          <div className="mt-3 space-y-2">
            {recentLessons.map((lesson) => (
              <div
                key={lesson.lesson_id}
                className="flex items-center gap-3 rounded-xl bg-off-white p-3"
              >
                <div className="flex h-8 w-8 items-center justify-center rounded-lg bg-success/15 text-success">
                  <svg className="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth={2}>
                    <path strokeLinecap="round" strokeLinejoin="round" d="m4.5 12.75 6 6 9-13.5" />
                  </svg>
                </div>
                <div className="min-w-0 flex-1">
                  <p className="truncate text-sm font-medium text-navy">
                    Lektion avklarad
                  </p>
                  <p className="text-xs text-charcoal">
                    {lesson.completed_at
                      ? new Date(lesson.completed_at).toLocaleDateString("sv-SE")
                      : ""}
                  </p>
                </div>
              </div>
            ))}
          </div>
        </section>
      )}
    </div>
  );
}
