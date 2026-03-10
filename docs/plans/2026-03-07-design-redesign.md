# Design Redesign: "Editorial Athletic"

**Goal:** Transform the platform from a generic SaaS template to a premium sports performance product that feels real and professional — anchored by real athlete photos and bold editorial typography.

**Problem:** Current design uses emoji stat icons, off-white backgrounds, white cards with thin borders, and generic SaaS layout. Feels AI-generated and fake.

**Solution:** Dark sidebar, athlete hero image on dashboard, large bold numbers replacing emoji stats, editorial module cards with left accent bars.

---

## Visual Language

### Colors
Add one new token to `src/styles/globals.css`:
```css
--color-dark: #0D1117;
```

Existing tokens stay. Key usage changes:
- Sidebar background: `--color-dark` (#0D1117) — was white
- Platform content background: `#FFFFFF` — was `off-white` (#F9F9F9)
- Card surface: `off-white` (#F9F9F9) — stays

### Typography
No new fonts. Scale changes only:
- Dashboard H1: `text-4xl` (was `text-2xl`)
- Stat numbers: `text-5xl font-extrabold` (was `text-2xl`)
- Module title: `text-2xl font-extrabold` (was `text-lg font-semibold`)

### Remove all emojis
- 🔥 → removed, just show number + "Dagar i rad" label
- 📚 → removed
- 🧠 → removed

---

## Storage

### Make bucket public
The "Next Act arbete" bucket must be made public so images can be embedded directly.

Public URL pattern:
```
https://jdpqgfwzzxypjfhrtcsc.supabase.co/storage/v1/object/public/Next%20Act%20arbete/rasmus%20elm.png
```

Available hero images (in priority order):
1. `rasmus elm.png` (76 KB) — primary dashboard hero
2. `ebba handfast.png` (76 KB) — alternate / second hero
3. `Athlete-focus-300x169.jpg` — fallback if above are too small

---

## Components to Change

### 1. `src/styles/globals.css`
Add `--color-dark: #0D1117`.
Change platform content background from `off-white` to `white` in layout.

### 2. `src/components/layouts/app-sidebar.tsx`
**Desktop sidebar:**
- `bg-white border-r` → `bg-dark`
- Nav default: `text-gray-400 hover:text-white hover:bg-white/5`
- Nav active: `text-white bg-white/10 border-l-2 border-primary`
- Logo: `text-white`
- User section: `border-white/10`, `text-gray-300`

**Mobile bottom bar:**
- `bg-white border-t` → `bg-dark border-t-0`
- Active icon: `text-primary`, default: `text-gray-500`

### 3. `src/app/(platform)/layout.tsx`
- `bg-off-white` → `bg-white`
- Remove floating bollplank button (redundant — coach is in the nav)

### 4. `src/app/(platform)/dashboard/page.tsx`
Replace the current 3-card grid with:

**Hero card (new):**
```
┌────────────────────────────────────────────┐
│ Left 55%: dark bg (#0D1117)                │
│   "Hej, [Namn]!"  (white, text-3xl bold)   │
│   "Välkommen tillbaka..."  (gray-400)       │
│   [Fortsätt träna →]  (primary blue btn)   │
│                                            │
│ Right 45%: athlete photo                   │
│   object-cover object-top                  │
│   gradient overlay left edge               │
└────────────────────────────────────────────┘
```

**Stat row (replaces emoji cards):**
Three clean stat cards side by side:
- Card 1: Big number (current_streak) + "Dagar i rad" label + sub-text
- Card 2: Big percentage (modulePercent%) + "Modulframsteg" label + lesson count
- Card 3: "Bollplank" label + "Öppna chatten" button (no brain emoji)

Numbers: `text-5xl font-extrabold text-navy font-heading`
Labels: `text-sm text-charcoal uppercase tracking-wide`

**Dagens övning section:** Keep, but style as a full-width banner card with primary blue left border.

### 5. `src/components/features/lms/module-card.tsx`
Replace white rounded card with editorial horizontal band:

```
┌─ 3px left border (blue/green/gray) ──────────────────┐
│  01        Introduktion till mental träning    AKTIV  │
│            Värderingar · 45 min · 3 av 5 lektioner    │
└───────────────────────────────────────────────────────┘
```

- Border color: `border-primary` (active), `border-success` (completed), `border-light-gray` (locked)
- Module number: `text-xs text-charcoal font-mono` top-left
- Title: `text-2xl font-extrabold text-navy` (locked: `text-light-gray`)
- Status badge: pill — "AKTIV" (blue bg), "KLAR" (green bg), "LÅST" (gray bg)
- Sub-line: act process label · estimated minutes · "X av Y lektioner"
- No progress bar
- Background: `bg-white` with `hover:bg-off-white` transition
- Padding: `py-5 px-6`
- Full rounded: `rounded-xl`

### 6. `src/components/ui/card.tsx`
Read first to understand current implementation. Likely just needs surface color tweak.

---

## Image Integration

In `dashboard/page.tsx`, fetch a signed URL server-side OR use the public bucket URL directly.

Since bucket will be made public:
```ts
const HERO_IMAGE_URL =
  "https://jdpqgfwzzxypjfhrtcsc.supabase.co/storage/v1/object/public/Next%20Act%20arbete/rasmus%20elm.png";
```

Use `next/image` with `fill` and `object-cover` inside a positioned container.

---

## Out of Scope
- Lesson card redesign (text-card, story-card etc.) — fine as-is
- Marketing pages — separate project
- Admin pages — separate project
- Animation/transition overhaul
