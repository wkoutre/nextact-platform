# Next Act Platform

## Overview
Mental training platform for Swedish athletes, built on ACT (Acceptance and Commitment Therapy) / MAC framework.

**Status (March 2026):** Phase 1 (Foundation) complete. Platform scaffolded with 121 source files. See `.claude/CLAUDE.md` for comprehensive project context, implementation status, and what to work on next.

## Getting Started

New to this project? See:
- **`.claude/CLAUDE.md`** — Full project context for Claude Code (tech stack, conventions, architecture, status)
- **`docs/SETUP-GUIDE.md`** — Step-by-step setup instructions
- **`docs/HANDOFF-NOTES.md`** — Decisions, known issues, and context from the initial build
- **`docs/plans/2026-03-05-nextact-final-design.md`** — Complete system design specification
- **`docs/plans/2026-03-05-implementation-plan.md`** — 32-task phased implementation plan

## Tech Stack
- Next.js 15 (App Router) + React 19 + TypeScript (strict)
- Supabase (auth, PostgreSQL, storage, realtime)
- Vercel (hosting)
- Claude API via Vercel AI SDK (AI coach)
- Stripe (payments)
- Resend (email), Twilio (SMS)
- Tailwind CSS, Framer Motion

## Commands
- `pnpm dev` — development server
- `pnpm build` — production build
- `pnpm lint` — ESLint
- `pnpm typecheck` — TypeScript strict check
- `pnpm test` — Vitest unit tests
- `pnpm test:e2e` — Playwright E2E tests

## Conventions
- Swedish-first UI (lang="sv"), i18n-ready
- Server components by default, client components only for interactivity
- Server Actions for mutations (thin wrappers calling services)
- Route Handlers for streaming (AI coach) and webhooks (Stripe, Twilio)
- Never use `any` — use `unknown` and narrow with type guards
- Never use getSession() for auth — always getUser()
- Roles stored in auth.users.raw_app_meta_data, not profiles table
- GitHub Actions pinned to commit hashes
- Brand: Montserrat headings, Source Sans Pro body, #2670E6 primary blue

## Directory Structure
- `src/app/(marketing)/` — SSG marketing pages
- `src/app/(auth)/` — login, registration
- `src/app/(platform)/` — authenticated LMS
- `src/app/(admin)/admin/` — admin dashboard
- `src/components/ui/` — base UI primitives
- `src/components/features/` — domain-specific components
- `src/lib/actions/` — thin server action wrappers
- `src/lib/services/` — pure business logic (testable)
- `src/lib/supabase/` — Supabase client helpers
- `src/lib/validations/` — Zod schemas
