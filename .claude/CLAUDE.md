# Next Act Platform

## What This Is

Next Act is a Swedish mental training platform for athletes aged 15-25, built on ACT (Acceptance and Commitment Therapy) and the MAC (Mindfulness-Acceptance-Commitment) sport framework. It replaces a legacy stack of WordPress + Moodle + Azure + Mailgun with a unified, modern platform.

**Business context:** The company (Pratamera Sport / Next Act) currently has ~100 users on Moodle completing the old program. All new users will go to this platform. Moodle sunsets naturally — no migration needed.

**Domain:** nextact.se (DNS not yet pointed to this platform)

## Tech Stack

| Layer | Technology | Purpose |
|-------|-----------|---------|
| Framework | Next.js 15 (App Router) + React 19 | Full-stack web application |
| Language | TypeScript (strict mode) | Type safety |
| Database | Supabase (PostgreSQL + Auth + Storage + Realtime) | Backend-as-a-service |
| Hosting | Vercel | Deployment, CDN, serverless |
| AI | Claude API via Vercel AI SDK | AI coach for athletes |
| Payments | Stripe | Subscriptions (Free / Standard 799 SEK / Premium 2,499 SEK) |
| Email | Resend | Transactional email |
| SMS | Twilio | Critical alerts only |
| Video | Vimeo (existing account) | Video hosting |
| Styling | Tailwind CSS + Framer Motion | UI and animations |
| Testing | Vitest + Playwright | Unit + E2E tests |
| Package Manager | pnpm | Dependencies |

## Commands

- `pnpm dev` — development server (Turbopack)
- `pnpm build` — production build
- `pnpm lint` — ESLint
- `pnpm typecheck` — TypeScript strict check
- `pnpm test` — Vitest unit tests
- `pnpm test:e2e` — Playwright E2E tests
- `pnpm format` — Prettier formatting

## Current Implementation Status

### Built (Phase 1 — Foundation)
- Project scaffold with full directory structure
- Supabase schema: 14 tables with RLS policies, triggers, indexes
- Seed data: 12 ACT/MAC modules with 57 lessons (Swedish titles)
- Auth system: middleware, login/register pages, callback route, Zod validation
- Supabase clients: browser, server (cookies), admin (service role)
- Marketing pages: home, pricing, about, blog, contact, schools, clubs, privacy, terms
- Platform pages: dashboard, learn (module list, lesson feed), coach, profile, progress
- Admin pages: dashboard, content management, analytics, user management
- AI coach: streaming chat route, system prompt, crisis detection, rate limiter, context builder
- LMS components: lesson feed, 9 card types (video, text, exercise variants, quiz, AI prompt, callout, completion)
- Stripe integration: checkout, webhook handler, server actions
- Messaging: Resend email service + 5 React Email templates, Twilio SMS, notification center
- CI/CD: GitHub Actions for PRs (lint/typecheck/test) + production (migrations) + zizmor security
- UI components: Button, Input, Card, Badge
- Design: "Scandinavian Athletic Editorial" visual style

### Placeholder / Needs Work (Phase 2+)
- Lesson content is empty (`content: '[]'`) — needs actual content via admin editor
- Admin content editor (BlockNote integration) not built yet
- Vimeo video IDs not populated in lessons
- Stripe not connected to real account (no products/prices created)
- Anthropic API key not configured (AI coach won't work without it)
- Resend not connected (no domain verified)
- Twilio not connected
- No real tests written (test directories are empty)
- Social login (Google/Apple) not configured in Supabase
- PWA manifest not created
- No real user accounts exist

## Environment Variables

Copy `.env.example` to `.env.local` and fill in:

| Variable | Where to get it | Required for |
|----------|----------------|-------------|
| `NEXT_PUBLIC_SUPABASE_URL` | Supabase Dashboard > Settings > API | Everything |
| `NEXT_PUBLIC_SUPABASE_ANON_KEY` | Supabase Dashboard > Settings > API | Everything |
| `SUPABASE_SERVICE_ROLE_KEY` | Supabase Dashboard > Settings > API | Webhooks, admin operations |
| `STRIPE_SECRET_KEY` | Stripe Dashboard > Developers > API keys | Payments |
| `NEXT_PUBLIC_STRIPE_PUBLISHABLE_KEY` | Stripe Dashboard > Developers > API keys | Payments (client) |
| `STRIPE_WEBHOOK_SECRET` | Stripe Dashboard > Developers > Webhooks | Payment webhooks |
| `ANTHROPIC_API_KEY` | console.anthropic.com > API Keys | AI coach |
| `RESEND_API_KEY` | Resend Dashboard > API Keys | Email |
| `TWILIO_ACCOUNT_SID` | Twilio Console | SMS |
| `TWILIO_AUTH_TOKEN` | Twilio Console | SMS |
| `TWILIO_PHONE_NUMBER` | Twilio Console > Phone Numbers | SMS |
| `VIMEO_ACCESS_TOKEN` | Vimeo Developer > My Apps | Video |
| `NEXT_PUBLIC_APP_URL` | Your deployment URL | Links in emails, redirects |

**Only Supabase variables are needed to run locally.** Everything else can be added later as you set up each service.

## Conventions

### Language
- Swedish-first UI (`lang="sv"`), i18n-ready via next-intl
- All user-facing text is in Swedish
- Code, comments, and variable names are in English

### Architecture
- Server Components by default; `'use client'` only for interactivity
- Server Actions for mutations — thin wrappers calling service functions
- Route Handlers for streaming (AI coach) and webhooks (Stripe, Twilio)
- Services (`src/lib/services/`) contain pure business logic (testable, no Next.js imports)
- Actions (`src/lib/actions/`) are thin wrappers that call services

### Auth
- **Always use `getUser()`, never `getSession()`** — getSession() reads from JWT without server verification
- Roles stored in `auth.users.raw_app_meta_data.role`, not in the profiles table
- `auth.role()` SQL helper extracts role from JWT for RLS policies

### TypeScript
- `strict: true` — no exceptions
- Never use `any` — use `unknown` and narrow with type guards
- Prefer type inference; be explicit at function boundaries

### Design
- Brand: Montserrat headings, Source Sans Pro body, #2670E6 primary blue
- "Scandinavian Athletic Editorial" visual style — clean, minimal, confident
- Custom UI components (not a component library like shadcn)

### Git & CI
- GitHub Actions pinned to commit hashes (not version tags)
- zizmor for Actions security analysis
- pnpm as package manager

## Directory Structure

```
src/
  app/
    (marketing)/       # SSG marketing pages (home, pricing, about, blog, etc.)
    (auth)/            # Login, registration, auth callback
    (platform)/        # Authenticated LMS (dashboard, learn, coach, profile, progress)
    (admin)/admin/     # Admin dashboard (content, users, analytics)
    api/               # Route handlers (AI chat, Stripe webhook)
    layout.tsx         # Root layout (fonts, metadata, lang="sv")
  components/
    ui/                # Base UI primitives (Button, Input, Card, Badge)
    features/          # Domain components (auth/, coach/, lms/, marketing/, admin/, etc.)
    layouts/           # Layout components (marketing header/footer, app sidebar, admin nav)
  lib/
    actions/           # Server Actions (thin wrappers)
    services/          # Pure business logic (ai/, messaging/, stripe/, vimeo/)
    supabase/          # Supabase client helpers (client, server, admin, types)
    validations/       # Zod schemas
  hooks/               # React hooks
  types/               # TypeScript type definitions
  styles/              # Global CSS, font configuration
supabase/
  migrations/          # SQL migrations (00001_initial_schema.sql)
  seed.sql             # Seed data (12 modules, 57 lessons)
  config.toml          # Supabase local dev config
docs/
  plans/               # Design doc and implementation plan
tests/
  unit/                # Vitest unit tests (empty)
  integration/         # Integration tests (empty)
  e2e/                 # Playwright E2E tests (empty)
```

## Key Design Documents

- `docs/plans/2026-03-05-nextact-final-design.md` — Complete system specification (architecture, data model, AI coach design, pricing, content structure)
- `docs/plans/2026-03-05-implementation-plan.md` — 32-task phased implementation plan

## What to Work On Next

Refer to the implementation plan. Phase 1 is complete. Priority order:
1. **Content creation** — Fill lesson content via Supabase Studio or build the admin editor
2. **Stripe setup** — Create products/prices, connect webhook
3. **AI coach** — Add Anthropic API key, test the coaching flow
4. **Testing** — Write unit tests for services, E2E tests for critical flows
5. **Social login** — Configure Google/Apple OAuth in Supabase
6. **Email** — Set up Resend, verify domain
