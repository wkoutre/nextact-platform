# Design Redesign Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Transform the platform from a generic SaaS template to a premium "Editorial Athletic" design — dark sidebar, athlete hero image on dashboard, bold typography, no emojis.

**Architecture:** Pure UI changes across 5 files. No new logic, no new routes, no new dependencies. Each task is independent and can be verified by running `pnpm build` + visual check.

**Tech Stack:** Next.js 15, Tailwind CSS v4 (@theme in globals.css), Framer Motion, Supabase Storage (public bucket for images), next/image

**Design doc:** `docs/plans/2026-03-07-design-redesign.md`

**Image URLs (after bucket is made public):**
- Rasmus Elm: `https://jdpqgfwzzxypjfhrtcsc.supabase.co/storage/v1/object/public/Next%20Act%20arbete/rasmus%20elm.png`
- Ebba Handfast: `https://jdpqgfwzzxypjfhrtcsc.supabase.co/storage/v1/object/public/Next%20Act%20arbete/ebba%20handfast.png`

---

### Task 1: Make Supabase storage bucket public

**Files:**
- No code files — Supabase MCP tool call

**Step 1: Run this SQL via Supabase MCP (execute_sql)**

```sql
UPDATE storage.buckets
SET public = true
WHERE id = 'Next Act arbete';
```

**Step 2: Verify with SQL**

```sql
SELECT id, name, public FROM storage.buckets WHERE id = 'Next Act arbete';
```

Expected: `public = true`

**Step 3: Test the URL in browser**

Open: `https://jdpqgfwzzxypjfhrtcsc.supabase.co/storage/v1/object/public/Next%20Act%20arbete/rasmus%20elm.png`

Expected: image loads without auth error

**Step 4: Commit**

```bash
git add -A
git commit -m "chore: make storage bucket public for athlete images"
```

---

### Task 2: Add dark color token + change platform background

**Files:**
- Modify: `src/styles/globals.css`
- Modify: `src/app/(platform)/layout.tsx`

**Step 1: Add color token to globals.css**

The `@theme` block currently ends with `--color-cyan: #1DBDD4;`. Add one line after it:

```css
@import "tailwindcss";

@theme {
  --font-heading: "Montserrat", sans-serif;
  --font-body: "Source Sans Pro", sans-serif;

  --color-primary: #2670E6;
  --color-primary-hover: #4582E4;
  --color-navy: #181827;
  --color-charcoal: #3C3950;
  --color-light-gray: #B7C6C9;
  --color-off-white: #F9F9F9;
  --color-off-white-alt: #F0F3F2;
  --color-success: #4AD48C;
  --color-cyan: #1DBDD4;
  --color-dark: #0D1117;
}
```

**Step 2: Update platform layout background + remove floating button**

Full replacement of `src/app/(platform)/layout.tsx`:

```tsx
import { redirect } from "next/navigation";
import { createClient } from "@/lib/supabase/server";
import { AppSidebar } from "@/components/layouts/app-sidebar";

export default async function PlatformLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  const supabase = await createClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();

  if (!user) {
    redirect("/logga-in");
  }

  const displayName =
    user.user_metadata?.display_name ?? user.email?.split("@")[0] ?? null;

  return (
    <div className="min-h-screen bg-white">
      <AppSidebar
        userName={displayName}
        avatarUrl={user.user_metadata?.avatar_url ?? null}
      />
      <main className="pb-20 lg:ml-64 lg:pb-0">
        <div className="mx-auto max-w-5xl px-4 py-6 sm:px-6 lg:px-8 lg:py-8">
          {children}
        </div>
      </main>
    </div>
  );
}
```

(Removed: floating bollplank button — coach is already in the sidebar nav)

**Step 3: Verify**

```bash
pnpm typecheck
```

Expected: no errors

**Step 4: Commit**

```bash
git add src/styles/globals.css src/app/(platform)/layout.tsx
git commit -m "feat: add dark color token, set platform bg to white"
```

---

### Task 3: Redesign the sidebar — dark editorial

**Files:**
- Modify: `src/components/layouts/app-sidebar.tsx`

**Step 1: Replace the full file**

```tsx
"use client";

import Link from "next/link";
import { usePathname } from "next/navigation";

const NAV_ITEMS = [
  { href: "/dashboard", label: "Dashboard", icon: DashboardIcon },
  { href: "/learn", label: "Lär dig", icon: LearnIcon },
  { href: "/coach", label: "Bollplank", icon: CoachIcon },
  { href: "/progress", label: "Framsteg", icon: ProgressIcon },
  { href: "/tuffhetsmodellen", label: "Tuffhetsmodellen", icon: TuffhetsmodellenIcon },
  { href: "/profile", label: "Profil", icon: ProfileIcon },
];

interface AppSidebarProps {
  userName?: string | null;
  avatarUrl?: string | null;
}

export function AppSidebar({ userName, avatarUrl }: AppSidebarProps) {
  const pathname = usePathname();

  return (
    <>
      {/* Desktop sidebar */}
      <aside className="fixed inset-y-0 left-0 z-30 hidden w-64 flex-col bg-dark lg:flex">
        {/* Logo */}
        <div className="flex h-16 items-center px-6">
          <Link
            href="/dashboard"
            className="font-heading text-xl font-bold text-white"
          >
            Next Act
          </Link>
        </div>

        {/* Navigation */}
        <nav className="flex-1 space-y-0.5 px-3 py-4">
          {NAV_ITEMS.map((item) => {
            const isActive =
              pathname === item.href || pathname.startsWith(item.href + "/");
            return (
              <Link
                key={item.href}
                href={item.href}
                className={`flex items-center gap-3 rounded-lg px-3 py-2.5 text-sm font-medium transition-colors ${
                  isActive
                    ? "border-l-2 border-primary bg-white/10 text-white"
                    : "border-l-2 border-transparent text-gray-400 hover:bg-white/5 hover:text-white"
                }`}
              >
                <item.icon active={isActive} />
                {item.label}
              </Link>
            );
          })}
        </nav>

        {/* User section */}
        <div className="border-t border-white/10 p-4">
          <div className="flex items-center gap-3">
            <div className="flex h-9 w-9 items-center justify-center rounded-full bg-white/10 text-sm font-semibold text-white">
              {avatarUrl ? (
                <img
                  src={avatarUrl}
                  alt=""
                  className="h-9 w-9 rounded-full object-cover"
                />
              ) : (
                (userName?.[0] ?? "?").toUpperCase()
              )}
            </div>
            <span className="truncate text-sm font-medium text-gray-300">
              {userName ?? "Idrottare"}
            </span>
          </div>
        </div>
      </aside>

      {/* Mobile bottom tab bar */}
      <nav className="fixed inset-x-0 bottom-0 z-30 flex bg-dark lg:hidden">
        {NAV_ITEMS.map((item) => {
          const isActive =
            pathname === item.href || pathname.startsWith(item.href + "/");
          return (
            <Link
              key={item.href}
              href={item.href}
              className={`flex flex-1 flex-col items-center gap-1 py-2 text-[10px] font-medium transition-colors ${
                isActive ? "text-primary" : "text-gray-500"
              }`}
            >
              <item.icon active={isActive} />
              {item.label}
            </Link>
          );
        })}
      </nav>
    </>
  );
}

function DashboardIcon({ active }: { active: boolean }) {
  return (
    <svg
      className={`h-5 w-5 ${active ? "text-white" : "text-gray-400"}`}
      fill="none"
      viewBox="0 0 24 24"
      stroke="currentColor"
      strokeWidth={1.5}
    >
      <path
        strokeLinecap="round"
        strokeLinejoin="round"
        d="M3.75 6A2.25 2.25 0 0 1 6 3.75h2.25A2.25 2.25 0 0 1 10.5 6v2.25a2.25 2.25 0 0 1-2.25 2.25H6a2.25 2.25 0 0 1-2.25-2.25V6ZM3.75 15.75A2.25 2.25 0 0 1 6 13.5h2.25a2.25 2.25 0 0 1 2.25 2.25V18a2.25 2.25 0 0 1-2.25 2.25H6A2.25 2.25 0 0 1 3.75 18v-2.25ZM13.5 6a2.25 2.25 0 0 1 2.25-2.25H18A2.25 2.25 0 0 1 20.25 6v2.25A2.25 2.25 0 0 1 18 10.5h-2.25a2.25 2.25 0 0 1-2.25-2.25V6ZM13.5 15.75a2.25 2.25 0 0 1 2.25-2.25H18a2.25 2.25 0 0 1 2.25 2.25V18A2.25 2.25 0 0 1 18 20.25h-2.25a2.25 2.25 0 0 1-2.25-2.25v-2.25Z"
      />
    </svg>
  );
}

function LearnIcon({ active }: { active: boolean }) {
  return (
    <svg
      className={`h-5 w-5 ${active ? "text-white" : "text-gray-400"}`}
      fill="none"
      viewBox="0 0 24 24"
      stroke="currentColor"
      strokeWidth={1.5}
    >
      <path
        strokeLinecap="round"
        strokeLinejoin="round"
        d="M12 6.042A8.967 8.967 0 0 0 6 3.75c-1.052 0-2.062.18-3 .512v14.25A8.987 8.987 0 0 1 6 18c2.305 0 4.408.867 6 2.292m0-14.25a8.966 8.966 0 0 1 6-2.292c1.052 0 2.062.18 3 .512v14.25A8.987 8.987 0 0 0 18 18a8.967 8.967 0 0 0-6 2.292m0-14.25v14.25"
      />
    </svg>
  );
}

function CoachIcon({ active }: { active: boolean }) {
  return (
    <svg
      className={`h-5 w-5 ${active ? "text-white" : "text-gray-400"}`}
      fill="none"
      viewBox="0 0 24 24"
      stroke="currentColor"
      strokeWidth={1.5}
    >
      <path
        strokeLinecap="round"
        strokeLinejoin="round"
        d="M8.625 12a.375.375 0 1 1-.75 0 .375.375 0 0 1 .75 0Zm0 0H8.25m4.125 0a.375.375 0 1 1-.75 0 .375.375 0 0 1 .75 0Zm0 0H12m4.125 0a.375.375 0 1 1-.75 0 .375.375 0 0 1 .75 0Zm0 0h-.375M21 12c0 4.556-4.03 8.25-9 8.25a9.764 9.764 0 0 1-2.555-.337A5.972 5.972 0 0 1 5.41 20.97a5.969 5.969 0 0 1-.474-.065 4.48 4.48 0 0 0 .978-2.025c.09-.457-.133-.901-.467-1.226C3.93 16.178 3 14.189 3 12c0-4.556 4.03-8.25 9-8.25s9 3.694 9 8.25Z"
      />
    </svg>
  );
}

function ProgressIcon({ active }: { active: boolean }) {
  return (
    <svg
      className={`h-5 w-5 ${active ? "text-white" : "text-gray-400"}`}
      fill="none"
      viewBox="0 0 24 24"
      stroke="currentColor"
      strokeWidth={1.5}
    >
      <path
        strokeLinecap="round"
        strokeLinejoin="round"
        d="M3 13.125C3 12.504 3.504 12 4.125 12h2.25c.621 0 1.125.504 1.125 1.125v6.75C7.5 20.496 6.996 21 6.375 21h-2.25A1.125 1.125 0 0 1 3 19.875v-6.75ZM9.75 8.625c0-.621.504-1.125 1.125-1.125h2.25c.621 0 1.125.504 1.125 1.125v11.25c0 .621-.504 1.125-1.125 1.125h-2.25a1.125 1.125 0 0 1-1.125-1.125V8.625ZM16.5 4.125c0-.621.504-1.125 1.125-1.125h2.25C20.496 3 21 3.504 21 4.125v15.75c0 .621-.504 1.125-1.125 1.125h-2.25a1.125 1.125 0 0 1-1.125-1.125V4.125Z"
      />
    </svg>
  );
}

function ProfileIcon({ active }: { active: boolean }) {
  return (
    <svg
      className={`h-5 w-5 ${active ? "text-white" : "text-gray-400"}`}
      fill="none"
      viewBox="0 0 24 24"
      stroke="currentColor"
      strokeWidth={1.5}
    >
      <path
        strokeLinecap="round"
        strokeLinejoin="round"
        d="M15.75 6a3.75 3.75 0 1 1-7.5 0 3.75 3.75 0 0 1 7.5 0ZM4.501 20.118a7.5 7.5 0 0 1 14.998 0A17.933 17.933 0 0 1 12 21.75c-2.676 0-5.216-.584-7.499-1.632Z"
      />
    </svg>
  );
}

function TuffhetsmodellenIcon({ active }: { active: boolean }) {
  return (
    <svg
      className={`h-5 w-5 ${active ? "text-white" : "text-gray-400"}`}
      fill="none"
      viewBox="0 0 24 24"
      stroke="currentColor"
      strokeWidth={1.5}
    >
      <path
        strokeLinecap="round"
        strokeLinejoin="round"
        d="M9 12.75 11.25 15 15 9.75m-3-7.036A11.959 11.959 0 0 1 3.598 6 11.99 11.99 0 0 0 3 9.749c0 5.592 3.824 10.29 9 11.623 5.176-1.332 9-6.03 9-11.622 0-1.31-.21-2.571-.598-3.751h-.152c-3.196 0-6.1-1.248-8.25-3.285Z"
      />
    </svg>
  );
}
```

**Step 2: Verify**

```bash
pnpm typecheck
```

Expected: no errors

**Step 3: Commit**

```bash
git add src/components/layouts/app-sidebar.tsx
git commit -m "feat: dark editorial sidebar and mobile nav"
```

---

### Task 4: Redesign the dashboard — hero image + clean stats

**Files:**
- Modify: `src/app/(platform)/dashboard/page.tsx`

**Context:**
- The file currently imports `Card` from `@/components/ui/card` and `Link` from `next/link`
- It fetches streak, currentModule, and recentLessons from Supabase
- The hero image is served from public Supabase storage (Task 1 must be done first)
- Use `next/image` — it's already available in Next.js, no import needed from package.json
- `Image` must be imported: `import Image from "next/image"`

**Step 1: Replace the full file**

```tsx
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

  // Fetch data in parallel
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

  const lessonsRemaining =
    (currentModule?.lessons_total ?? 0) -
    (currentModule?.lessons_completed ?? 0);

  return (
    <div className="space-y-8">
      {/* Hero card */}
      <div className="relative overflow-hidden rounded-2xl bg-dark" style={{ minHeight: "220px" }}>
        {/* Athlete photo — right half */}
        <div className="absolute inset-y-0 right-0 w-1/2">
          <Image
            src={HERO_IMAGE_URL}
            alt="Atlet"
            fill
            className="object-cover object-top"
            priority
            unoptimized
          />
          {/* Gradient fade from dark to transparent */}
          <div className="absolute inset-y-0 left-0 w-32 bg-gradient-to-r from-dark to-transparent" />
        </div>

        {/* Text — left half */}
        <div className="relative z-10 flex flex-col justify-center px-8 py-10 lg:py-12" style={{ maxWidth: "55%" }}>
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
```

**Step 2: Verify**

```bash
pnpm typecheck
```

Expected: no errors

**Step 3: Commit**

```bash
git add src/app/(platform)/dashboard/page.tsx
git commit -m "feat: dashboard hero with athlete photo and clean stats"
```

---

### Task 5: Redesign module cards — editorial band style

**Files:**
- Modify: `src/components/features/lms/module-card.tsx`

**Step 1: Replace the full file**

```tsx
import Link from "next/link";
import type { ActProcess } from "@/lib/supabase/types";

type ModuleStatus = "completed" | "in_progress" | "locked";

type ModuleCardProps = {
  id: string;
  number: number;
  title: string;
  actProcess: ActProcess | null;
  estimatedMinutes: number | null;
  lessonsCompleted: number;
  lessonsTotal: number;
  status: ModuleStatus;
  colorTheme?: string | null;
};

const actProcessLabels: Record<ActProcess, string> = {
  values: "Värderingar",
  acceptance: "Acceptans",
  defusion: "Defusion",
  present_moment: "Närvarande Ögonblick",
  self_as_context: "Självet som Kontext",
  committed_action: "Engagerat Handlande",
  integration: "Integration",
};

const statusConfig = {
  completed: {
    border: "border-l-success",
    badge: "bg-success/10 text-success",
    badgeText: "Klar",
  },
  in_progress: {
    border: "border-l-primary",
    badge: "bg-primary/10 text-primary",
    badgeText: "Aktiv",
  },
  locked: {
    border: "border-l-light-gray",
    badge: "bg-light-gray/20 text-light-gray",
    badgeText: "Låst",
  },
};

export function ModuleCard({
  id,
  number,
  title,
  actProcess,
  estimatedMinutes,
  lessonsCompleted,
  lessonsTotal,
  status,
}: ModuleCardProps) {
  const config = statusConfig[status];
  const isLocked = status === "locked";

  const content = (
    <div
      className={`
        rounded-xl border-l-4 bg-white px-6 py-5 transition-all
        ${config.border}
        ${isLocked ? "" : "hover:bg-off-white"}
      `}
    >
      <div className="flex items-start justify-between gap-4">
        <div className="min-w-0 flex-1">
          {/* Module number */}
          <p className="font-mono text-xs font-medium text-light-gray">
            {String(number).padStart(2, "0")}
          </p>

          {/* Title */}
          <h3
            className={`mt-1 font-heading text-xl font-extrabold leading-tight ${
              isLocked ? "text-light-gray" : "text-navy"
            }`}
          >
            {title}
          </h3>

          {/* Meta line */}
          <p className={`mt-1.5 text-sm ${isLocked ? "text-light-gray" : "text-charcoal"}`}>
            {[
              actProcess ? actProcessLabels[actProcess] : null,
              estimatedMinutes ? `${estimatedMinutes} min` : null,
              !isLocked && lessonsTotal > 0
                ? `${lessonsCompleted} av ${lessonsTotal} lektioner`
                : null,
            ]
              .filter(Boolean)
              .join(" · ")}
          </p>
        </div>

        {/* Status badge */}
        <span
          className={`shrink-0 rounded-full px-3 py-1 text-xs font-semibold uppercase tracking-wide ${config.badge}`}
        >
          {config.badgeText}
        </span>
      </div>
    </div>
  );

  if (isLocked) {
    return <div aria-disabled="true">{content}</div>;
  }

  return (
    <Link href={`/learn/${id}`} className="block">
      {content}
    </Link>
  );
}
```

**Step 2: Verify**

```bash
pnpm typecheck
```

Expected: no errors

**Step 3: Commit**

```bash
git add src/components/features/lms/module-card.tsx
git commit -m "feat: editorial band-style module cards with status badges"
```

---

### Task 6: Build check + deploy

**Step 1: Full build**

```bash
pnpm build
```

Expected: Build succeeds with no errors. Warnings about Image `unoptimized` prop are fine.

**Step 2: Deploy to Vercel**

```bash
git push
```

Vercel will auto-deploy from the main branch push.

**Step 3: Verify live**

Open https://nextact-platform-eight.vercel.app/dashboard

Check:
- Dark sidebar visible
- Hero card with athlete photo loads
- Stats show clean numbers (no emojis)
- Module list shows band-style cards with colored left borders and status badges
