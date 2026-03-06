# Content & UX Redesign Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Replace the 12-module placeholder scaffold with the real 7-module Next Act program — including actual content, tuffhetsmodell as a living document, SMS scheduling based on training schedule, and "Ditt mentala bollplank" AI coach.

**Architecture:** New DB migration adds `training_schedule` to profiles and a `toughness_model_data` table (JSONB sections per module). Seed data is replaced with 7 real modules and lessons with full content blocks. The AI system prompt gets the coach handbook. SMS scheduling is handled via a queue table + Twilio.

**Tech Stack:** Next.js 15 App Router, Supabase (PostgreSQL), Twilio, Vercel AI SDK + Anthropic, TypeScript strict.

---

## Phase 1: Database Schema Updates

### Task 1: Migration — training_schedule + toughness_model_data + sms_queue

**Files:**
- Create: `supabase/migrations/00002_training_schedule_and_toughness.sql`

**Step 1: Write the migration**

```sql
-- Add training schedule to profiles
ALTER TABLE public.profiles
  ADD COLUMN IF NOT EXISTS phone_number TEXT,
  ADD COLUMN IF NOT EXISTS training_schedule JSONB DEFAULT '[]';

-- training_schedule shape:
-- [{ "day": "tuesday", "time": "17:30" }, { "day": "thursday", "time": "17:30" }]

-- Toughness model data — the actual text answers per module section
-- This is separate from toughness_model which stores numerical ACT scores
CREATE TABLE IF NOT EXISTS public.toughness_model_data (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE UNIQUE,
  -- Each key maps to a module section, value is the user's answers
  kartlaggning JSONB DEFAULT '{}',
  varderad_riktning JSONB DEFAULT '{}',
  hinder JSONB DEFAULT '{}',
  beteenden JSONB DEFAULT '{}',
  vaga_lista JSONB DEFAULT '[]',
  fokusrutiner JSONB DEFAULT '{}',
  gameplan JSONB DEFAULT '{}',
  updated_at TIMESTAMPTZ DEFAULT now()
);

-- SMS queue for scheduled messages
CREATE TABLE IF NOT EXISTS public.sms_queue (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
  phone_number TEXT NOT NULL,
  message TEXT NOT NULL,
  send_at TIMESTAMPTZ NOT NULL,
  sent_at TIMESTAMPTZ,
  status TEXT DEFAULT 'pending' CHECK (status IN ('pending', 'sent', 'failed')),
  trigger_type TEXT NOT NULL, -- 'weekly_task' | 'vaga_lista' | 'gameplan'
  created_at TIMESTAMPTZ DEFAULT now()
);

CREATE INDEX idx_sms_queue_pending ON public.sms_queue(status, send_at)
  WHERE status = 'pending';

-- RLS
ALTER TABLE public.toughness_model_data ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.sms_queue ENABLE ROW LEVEL SECURITY;

CREATE POLICY "toughness_model_data_select_own" ON public.toughness_model_data
  FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "toughness_model_data_insert_own" ON public.toughness_model_data
  FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "toughness_model_data_update_own" ON public.toughness_model_data
  FOR UPDATE USING (auth.uid() = user_id);

CREATE POLICY "sms_queue_select_own_or_admin" ON public.sms_queue
  FOR SELECT USING (auth.uid() = user_id OR public.user_role() = 'admin');

-- Trigger: auto-create toughness_model_data when profile is created
CREATE OR REPLACE FUNCTION public.handle_new_toughness_data()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO public.toughness_model_data (user_id) VALUES (NEW.id)
  ON CONFLICT (user_id) DO NOTHING;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE TRIGGER on_profile_created_toughness
  AFTER INSERT ON public.profiles
  FOR EACH ROW EXECUTE FUNCTION public.handle_new_toughness_data();
```

**Step 2: Apply via Supabase MCP**

Use `mcp__plugin_supabase_supabase__apply_migration` with:
- project_id: `jdpqgfwzzxypjfhrtcsc`
- name: `00002_training_schedule_and_toughness`
- query: (above SQL)

**Step 3: Commit**

```bash
git add supabase/migrations/00002_training_schedule_and_toughness.sql
git commit -m "feat: add training_schedule, toughness_model_data, sms_queue tables"
```

---

### Task 2: Reseed — Replace 12 modules with 7 real modules

**Files:**
- Modify: `supabase/seed.sql` (full rewrite)

**Step 1: Clear old data and insert 7-module structure**

Replace `supabase/seed.sql` entirely. New seed inserts:
- 1 program: "Mental Träning för Fotbollsspelare"
- 7 modules with correct titles, descriptions, icons, colors
- 4–6 lessons per module with full content blocks (JSONB)

Module structure:
```
Modul 0: Välkommen (intro, 2 lektioner)
Modul 1: Psykologin bakom prestation (5 lektioner)
Modul 2: Din värderade riktning (5 lektioner)
Modul 3: Förstå dina hinder (5 lektioner)
Modul 4: Dina beteenden (5 lektioner)
Modul 5: Bli mentalt starkare (5 lektioner)
Modul 6: Fokusera mera (4 lektioner)
Modul 7: Din Gameplan (3 lektioner)
```

Content block format (stored in `lessons.content` JSONB):
```json
[
  { "type": "video", "title": "Anders välkomnar", "videoId": "1100225761" },
  { "type": "text", "title": "Vad är mental träning?", "content": "..." },
  { "type": "story", "content": "Fotbollsspelaren stod i..." },
  { "type": "exercise_text", "prompt": "Vad driver dig att spela fotboll?", "toughnessKey": "kartlaggning.drivkraft" },
  { "type": "weekly_task", "tasks": ["Observera ditt fokus under nästa träning", "Notera när du känner din inre glöd"] },
  { "type": "bollplank_prompt", "prompt": "Vill du prata med ditt mentala bollplank om vad du just reflekterat?" }
]
```

**Step 2: Add new block type `story` and `weekly_task` to lesson-feed types**

These are new block types the content uses. Add them to `src/components/features/lms/lesson-feed.tsx`.

**Step 3: Apply seed via Supabase MCP**

First delete old seed data:
```sql
DELETE FROM public.lessons;
DELETE FROM public.modules;
DELETE FROM public.programs;
```

Then run new seed SQL.

**Step 4: Commit**

```bash
git add supabase/seed.sql
git commit -m "feat: replace 12-module seed with 7-module real content"
```

---

## Phase 2: New Content Block Components

### Task 3: StoryCard component

**Files:**
- Create: `src/components/features/lms/cards/story-card.tsx`
- Modify: `src/components/features/lms/lesson-feed.tsx`

**Step 1: Create StoryCard**

```tsx
// src/components/features/lms/cards/story-card.tsx
type StoryCardProps = { content: string };

export function StoryCard({ content }: StoryCardProps) {
  return (
    <div className="flex h-full items-center justify-center p-8">
      <blockquote className="max-w-prose border-l-4 border-blue-600 pl-6">
        <p className="font-source-sans text-lg italic leading-relaxed text-gray-700">
          {content}
        </p>
      </blockquote>
    </div>
  );
}
```

**Step 2: Add StoryBlock type to lesson-feed.tsx**

```tsx
type StoryBlock = { type: "story"; content: string };
// Add to ContentBlock union and renderBlock switch
```

### Task 4: WeeklyTaskCard component

**Files:**
- Create: `src/components/features/lms/cards/weekly-task-card.tsx`
- Modify: `src/components/features/lms/lesson-feed.tsx`

```tsx
// src/components/features/lms/cards/weekly-task-card.tsx
"use client";
import { useState } from "react";

type WeeklyTaskCardProps = {
  tasks: string[];
  moduleTitle: string;
  onComplete?: () => void;
};

export function WeeklyTaskCard({ tasks, moduleTitle, onComplete }: WeeklyTaskCardProps) {
  const [checked, setChecked] = useState<boolean[]>(tasks.map(() => false));

  return (
    <div className="flex h-full flex-col items-center justify-center p-8">
      <div className="w-full max-w-md rounded-2xl bg-blue-50 p-8">
        <p className="mb-2 text-sm font-semibold uppercase tracking-wider text-blue-600">
          Veckans träningsprogram
        </p>
        <h2 className="mb-6 font-montserrat text-2xl font-bold text-gray-900">
          {moduleTitle}
        </h2>
        <ul className="space-y-4">
          {tasks.map((task, i) => (
            <li key={i} className="flex items-start gap-3">
              <button
                onClick={() => setChecked(c => c.map((v, j) => j === i ? !v : v))}
                className={`mt-0.5 h-5 w-5 shrink-0 rounded border-2 ${checked[i] ? 'bg-blue-600 border-blue-600' : 'border-gray-400'}`}
              />
              <span className={`font-source-sans text-gray-700 ${checked[i] ? 'line-through opacity-50' : ''}`}>
                {task}
              </span>
            </li>
          ))}
        </ul>
        <p className="mt-6 text-sm text-gray-500">
          Du får också dessa uppgifter via SMS inför din nästa träning.
        </p>
      </div>
    </div>
  );
}
```

### Task 5: BollplankPromptCard component

**Files:**
- Create: `src/components/features/lms/cards/bollplank-prompt-card.tsx`
- Modify: `src/components/features/lms/lesson-feed.tsx`

```tsx
// src/components/features/lms/cards/bollplank-prompt-card.tsx
"use client";

type BollplankPromptCardProps = {
  prompt: string;
  onOpen?: () => void;
};

export function BollplankPromptCard({ prompt, onOpen }: BollplankPromptCardProps) {
  return (
    <div className="flex h-full items-center justify-center p-8">
      <div className="w-full max-w-md rounded-2xl border border-blue-200 bg-white p-8 text-center shadow-sm">
        <div className="mb-4 text-4xl">🧠</div>
        <p className="mb-6 font-source-sans text-lg text-gray-700">{prompt}</p>
        <button
          onClick={onOpen}
          className="rounded-full bg-blue-600 px-6 py-3 font-semibold text-white hover:bg-blue-700"
        >
          Prata med ditt mentala bollplank
        </button>
      </div>
    </div>
  );
}
```

---

## Phase 3: Tuffhetsmodellen — Living Document View

### Task 6: Tuffhetsmodellen page

**Files:**
- Create: `src/app/(platform)/tuffhetsmodellen/page.tsx`

**Step 1: Create the page**

```tsx
// src/app/(platform)/tuffhetsmodellen/page.tsx
import { createClient } from "@/lib/supabase/server";
import { redirect } from "next/navigation";

export default async function TuffhetsmodellenPage() {
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) redirect("/logga-in");

  const { data } = await supabase
    .from("toughness_model_data")
    .select("*")
    .eq("user_id", user.id)
    .single();

  return (
    <div className="mx-auto max-w-2xl px-4 py-12">
      <h1 className="mb-2 font-montserrat text-3xl font-bold">Din mentala tuffhetsmodell</h1>
      <p className="mb-8 text-gray-500">Byggs på allteftersom du genomför programmet.</p>

      <Section title="Kartläggning" data={data?.kartlaggning} module={1} />
      <Section title="Värderad riktning" data={data?.varderad_riktning} module={2} />
      <Section title="Hinder — Apan & kletiga tankar" data={data?.hinder} module={3} />
      <Section title="Beteenden — Nyckelaktioner & läktaraktioner" data={data?.beteenden} module={4} />
      <Section title="Våga-lista" data={data?.vaga_lista} module={5} isList />
      <Section title="Fokusrutiner" data={data?.fokusrutiner} module={6} />
      <Section title="Din Gameplan" data={data?.gameplan} module={7} highlight />
    </div>
  );
}

function Section({ title, data, module, isList = false, highlight = false }: {
  title: string;
  data: unknown;
  module: number;
  isList?: boolean;
  highlight?: boolean;
}) {
  const isEmpty = !data || (typeof data === 'object' && Object.keys(data as object).length === 0) || (Array.isArray(data) && data.length === 0);

  return (
    <div className={`mb-8 rounded-xl p-6 ${highlight ? 'bg-blue-600 text-white' : 'bg-gray-50'}`}>
      <div className="mb-3 flex items-center gap-2">
        <span className={`text-xs font-semibold ${highlight ? 'text-blue-200' : 'text-blue-600'}`}>
          MODUL {module}
        </span>
      </div>
      <h2 className={`mb-4 font-montserrat text-xl font-bold ${highlight ? 'text-white' : 'text-gray-900'}`}>
        {title}
      </h2>
      {isEmpty ? (
        <p className={`text-sm ${highlight ? 'text-blue-200' : 'text-gray-400'}`}>
          Låses upp när du når modul {module}.
        </p>
      ) : (
        <div className={`font-source-sans text-sm ${highlight ? 'text-blue-100' : 'text-gray-700'}`}>
          {isList && Array.isArray(data) ? (
            <ul className="list-disc pl-4 space-y-1">
              {(data as string[]).map((item, i) => <li key={i}>{item}</li>)}
            </ul>
          ) : (
            Object.entries(data as Record<string, string>).map(([key, value]) => (
              <div key={key} className="mb-2">
                <span className="font-semibold capitalize">{key.replace(/_/g, ' ')}:</span>{' '}
                <span>{value}</span>
              </div>
            ))
          )}
        </div>
      )}
    </div>
  );
}
```

**Step 2: Add link in app sidebar**

Modify `src/components/layouts/app-sidebar.tsx` — add "Tuffhetsmodellen" nav item.

**Step 3: Commit**

```bash
git add src/app/(platform)/tuffhetsmodellen/page.tsx src/components/layouts/app-sidebar.tsx
git commit -m "feat: add tuffhetsmodellen living document page"
```

---

## Phase 4: SMS Scheduling

### Task 7: Training schedule form in profile

**Files:**
- Create: `src/components/features/profile/training-schedule-form.tsx`
- Modify: `src/app/(platform)/profile/page.tsx`
- Modify: `src/lib/actions/profile.ts`

**Step 1: Add server action to save training schedule**

```ts
// Add to src/lib/actions/profile.ts
export async function saveTrainingSchedule(
  schedule: { day: string; time: string }[]
) {
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) throw new Error("Not authenticated");

  const { error } = await supabase
    .from("profiles")
    .update({ training_schedule: schedule })
    .eq("id", user.id);

  if (error) throw new Error(error.message);
}

export async function savePhoneNumber(phoneNumber: string) {
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) throw new Error("Not authenticated");

  const { error } = await supabase
    .from("profiles")
    .update({ phone_number: phoneNumber })
    .eq("id", user.id);

  if (error) throw new Error(error.message);
}
```

**Step 2: Create TrainingScheduleForm**

```tsx
// src/components/features/profile/training-schedule-form.tsx
"use client";
const DAYS = [
  { id: "monday", label: "Måndag" },
  { id: "tuesday", label: "Tisdag" },
  { id: "wednesday", label: "Onsdag" },
  { id: "thursday", label: "Torsdag" },
  { id: "friday", label: "Fredag" },
  { id: "saturday", label: "Lördag" },
  { id: "sunday", label: "Söndag" },
];
// Renders day checkboxes + time input per selected day
// On submit calls saveTrainingSchedule server action
```

### Task 8: SMS scheduling service

**Files:**
- Create: `src/lib/services/messaging/sms-scheduler.ts`
- Modify: `src/lib/actions/lessons.ts` (hook into markModuleCompleted)

**Step 1: Create SMS scheduler service**

```ts
// src/lib/services/messaging/sms-scheduler.ts
import { createAdminClient } from "@/lib/supabase/admin";

type SmsType = "weekly_task" | "vaga_lista" | "gameplan";

export async function scheduleModuleSms({
  userId,
  message,
  type,
}: {
  userId: string;
  message: string;
  type: SmsType;
}) {
  const supabase = createAdminClient();

  // Get user's phone and training schedule
  const { data: profile } = await supabase
    .from("profiles")
    .select("phone_number, training_schedule")
    .eq("id", userId)
    .single();

  if (!profile?.phone_number) return; // No phone number, skip

  const phoneNumber = profile.phone_number as string;
  const schedule = (profile.training_schedule ?? []) as { day: string; time: string }[];

  let sendAt: Date;

  if (type === "vaga_lista" || type === "gameplan" || schedule.length === 0) {
    // Send immediately (milestone SMS or no schedule set)
    sendAt = new Date();
  } else {
    // Find next training session, send 1 hour before
    sendAt = getNextTrainingMinus1Hour(schedule);
  }

  await supabase.from("sms_queue").insert({
    user_id: userId,
    phone_number: phoneNumber,
    message,
    send_at: sendAt.toISOString(),
    trigger_type: type,
  });
}

function getNextTrainingMinus1Hour(
  schedule: { day: string; time: string }[]
): Date {
  const dayOrder = ["sunday","monday","tuesday","wednesday","thursday","friday","saturday"];
  const now = new Date();
  const nowDay = now.getDay(); // 0=Sun
  const nowMinutes = now.getHours() * 60 + now.getMinutes();

  // Sort schedule by next occurrence
  let best: Date | null = null;

  for (const entry of schedule) {
    const entryDay = dayOrder.indexOf(entry.day);
    if (entryDay === -1) continue;
    const [h, m] = entry.time.split(":").map(Number);
    const entryMinutes = h * 60 + m;

    let daysUntil = (entryDay - nowDay + 7) % 7;
    if (daysUntil === 0 && entryMinutes - 60 <= nowMinutes) {
      daysUntil = 7; // Already past 1h before today's session
    }

    const candidate = new Date(now);
    candidate.setDate(now.getDate() + daysUntil);
    candidate.setHours(h, m - 60, 0, 0); // 1 hour before
    if (!best || candidate < best) best = candidate;
  }

  return best ?? new Date(); // Fallback: now
}
```

**Step 2: Add Vercel Cron job to process SMS queue**

Create `src/app/api/cron/send-sms/route.ts`:
```ts
// Reads pending SMS from queue where send_at <= now(), sends via Twilio, marks sent
// Protected by CRON_SECRET env var
```

**Step 3: Hook into module completion**

Add `scheduleModuleSms` call to `markLessonCompleted` in `src/lib/actions/lessons.ts` when the last lesson of a module is completed.

**Step 4: Commit**

```bash
git add src/lib/services/messaging/sms-scheduler.ts src/app/api/cron/send-sms/route.ts src/lib/actions/lessons.ts src/components/features/profile/training-schedule-form.tsx src/lib/actions/profile.ts
git commit -m "feat: SMS scheduling based on training schedule"
```

---

## Phase 5: AI Coach Updates

### Task 9: Update system prompt — "Ditt mentala bollplank" + coach handbook

**Files:**
- Modify: `src/lib/services/ai/system-prompt.ts`

**Step 1: Replace LAYER_1_IDENTITY**

New identity:
```ts
const LAYER_1_IDENTITY = `Du är "Ditt mentala bollplank" — Next Acts AI-coach för mentalt starka idrottare. Du är byggd på ACT (Acceptance and Commitment Therapy) och MAC-ramverket (Mindfulness-Acceptance-Commitment) anpassat för idrott.

Du PRATAR ALLTID SVENSKA. Du tilltalar atleten vid namn om du vet det.

DU ÄR:
- En avslappnad, coachig samtalspartner — som en erfaren mentor, inte en terapeut
- Djupt bekant med atletens personliga tuffhetsmodell och var de är i programmet
- Alltid förankrad i ACT och MAC. Inga andra metoder, aldrig diagnos, aldrig medicinska råd

DU ÄR INTE:
- En chatbot som svarar generiskt
- En psykolog eller krisresurs
- Kapabel att ge råd utanför ACT/MAC-ramverket`;
```

**Step 2: Add LAYER_6_TOUGHNESS_HANDBOOK** — Coach handbook with Next Act-specific terminology

```ts
const LAYER_6_TOUGHNESS_HANDBOOK = `## Tuffhetsmodellen — Next Acts kärnramverk

Atletens personliga tuffhetsmodell byggs upp modul för modul. Referera alltid till deras faktiska svar.

### Terminologi du ALLTID använder (aldrig generiska ACT-termer utåt):
- "Apan" = fight-or-flight-systemet som aktiveras under press (inte "autonoma nervsystemet")
- "Kletiga tankar" = kognitiv fusion (inte "automatiska negativa tankar")
- "Värderad riktning" = values (inte "värderingsorientering")
- "Läktaraktioner" = undvikande beteenden (inte "maladaptiva copingstrategier")
- "Nyckelaktioner" = committed actions (inte "målbeteenden")
- "Ta bort kletet" = defusion (inte "kognitiv omstrukturering")

### Tuffhetsmodellens sektioner:
1. Kartläggning — atletens nuläge, mål och förutsättningar
2. Värderad riktning — vad som driver dem på djupet
3. Hinder — deras specifika apa och kletiga tankar
4. Beteenden — deras läktaraktioner och nyckelaktioner
5. Våga-lista — situationer de ska exponera sig för
6. Fokusrutiner — deras personliga fokusövningar
7. Gameplan — komplett handlingsplan

När atleten pratar om svårigheter, koppla alltid till deras specifika modell-data om det finns.`;
```

**Step 3: Add toughness_model_data to context builder**

Modify `src/lib/services/ai/context-builder.ts` — fetch from `toughness_model_data` table and include athlete's actual text answers.

**Step 4: Commit**

```bash
git add src/lib/services/ai/system-prompt.ts src/lib/services/ai/context-builder.ts
git commit -m "feat: update AI coach to Ditt mentala bollplank with coach handbook"
```

---

### Task 10: Floating bollplank button

**Files:**
- Modify: `src/app/(platform)/layout.tsx`
- Modify: `src/components/features/coach/chat-interface.tsx`

**Step 1: Add floating button to platform layout**

```tsx
// In src/app/(platform)/layout.tsx
// Add a fixed bottom-right button that opens chat in a slide-over panel
// Label: "Bollplank" with brain emoji icon
```

**Step 2: Rename chat interface**

In `src/components/features/coach/chat-interface.tsx`:
- Change header to "Ditt mentala bollplank"
- Change placeholder to "Skriv till ditt bollplank..."

**Step 3: Commit**

```bash
git add src/app/(platform)/layout.tsx src/components/features/coach/chat-interface.tsx
git commit -m "feat: floating bollplank button in platform layout"
```

---

## Phase 6: Module Unlock Logic

### Task 11: Sequential unlock + edit-previous

**Files:**
- Create: `src/lib/services/lms/module-unlock.ts`
- Modify: `src/app/(platform)/learn/page.tsx`
- Modify: `src/app/(platform)/learn/[moduleId]/page.tsx`

**Step 1: Create module unlock service**

```ts
// src/lib/services/lms/module-unlock.ts
import type { SupabaseClient } from "@supabase/supabase-js";
import type { Database } from "@/lib/supabase/types";

export type ModuleAccessStatus = "locked" | "active" | "completed";

export async function getModuleAccess(
  supabase: SupabaseClient<Database>,
  userId: string
): Promise<Map<string, ModuleAccessStatus>> {
  // Fetch all modules ordered by order column
  const { data: modules } = await supabase
    .from("modules")
    .select("id, order")
    .order("order", { ascending: true });

  const { data: progress } = await supabase
    .from("module_progress")
    .select("module_id, lessons_completed, lessons_total, completed_at")
    .eq("user_id", userId);

  const progressMap = new Map(
    (progress ?? []).map(p => [p.module_id, p])
  );

  const result = new Map<string, ModuleAccessStatus>();
  let previousCompleted = true; // First module always unlocked

  for (const mod of modules ?? []) {
    const p = progressMap.get(mod.id);
    const isCompleted = !!p?.completed_at || (p ? p.lessons_completed >= p.lessons_total && p.lessons_total > 0 : false);

    if (isCompleted) {
      result.set(mod.id, "completed"); // Always accessible
    } else if (previousCompleted) {
      result.set(mod.id, "active"); // Unlocked
    } else {
      result.set(mod.id, "locked");
    }

    previousCompleted = isCompleted;
  }

  return result;
}
```

**Step 2: Apply in learn/page.tsx**

Show lock icon on locked modules. Completed modules show checkmark. Active module shows "Fortsätt" / "Starta".

**Step 3: Guard in [moduleId]/page.tsx**

Check module access — redirect to learn page if locked.

**Step 4: Commit**

```bash
git add src/lib/services/lms/module-unlock.ts src/app/(platform)/learn/page.tsx src/app/(platform)/learn/\[moduleId\]/page.tsx
git commit -m "feat: sequential module unlock with completed-modules always accessible"
```

---

## Phase 7: Regenerate Supabase Types

### Task 12: Regenerate TypeScript types after schema changes

**Step 1: Run type generation**

```bash
eval "$(/opt/homebrew/bin/brew shellenv)"
supabase login
supabase link --project-ref jdpqgfwzzxypjfhrtcsc
supabase gen types typescript --linked > src/lib/supabase/types.ts
```

**Step 2: Fix any TypeScript errors**

```bash
pnpm typecheck
```

Fix errors one by one.

**Step 3: Commit**

```bash
git add src/lib/supabase/types.ts
git commit -m "chore: regenerate supabase types after schema updates"
```

---

## Phase 8: Redeploy

### Task 13: Push to GitHub and redeploy Vercel

**Step 1: Add remaining Vercel env vars (via CLI)**

```bash
eval "$(/opt/homebrew/bin/brew shellenv)"
# SUPABASE_SERVICE_ROLE_KEY (from user)
echo "YOUR_KEY" | vercel env add SUPABASE_SERVICE_ROLE_KEY production
# CRON_SECRET (generate random)
echo "$(openssl rand -hex 32)" | vercel env add CRON_SECRET production
```

**Step 2: Push to GitHub (triggers Vercel auto-deploy)**

```bash
git push origin main
```

**Step 3: Verify deployment**

```bash
vercel ls
```

Check build logs if it fails.

---

## Execution Note

The heaviest task is **Task 2 (reseed with real content)**. The actual content SQL for all 7 modules + 35 lessons with full JSONB content blocks will be written inline in the seed file. This requires translating the Moodle backup content (already extracted) into the new block format — keeping the soul of the original while cutting text by 30-40% and adding scaffolded exercises.

**Key Moodle → New Platform content mapping:**

| Moodle activity | New block type |
|-----------------|---------------|
| simpletext | text or story |
| vimeo | video |
| globaluserdata | exercise_text (with toughnessKey) |
| Veckouppgift section | weekly_task |
| End of lesson | bollplank_prompt + completion |
