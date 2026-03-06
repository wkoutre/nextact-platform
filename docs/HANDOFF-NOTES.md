# Handoff Notes

This document captures context, decisions, and known issues from the initial build of the Next Act platform. It's meant to help you (or your Claude Code instance) understand *why* things are the way they are.

## Who Built This

Nick Koutrelakos built the initial platform using Claude Code over two intensive sessions on March 5-6, 2026. The goal was to scaffold the entire platform quickly so you (Axel) can take ownership and continue development.

## Key Decisions and Why

### Why Not WordPress + Moodle Anymore?

The existing stack (WordPress marketing site + Moodle LMS + Azure auth + Mailgun email) had several problems:
- Four separate systems with no shared user experience
- Moodle's UX is dated and doesn't match the brand
- No ability to add AI coaching or modern interactive exercises
- Maintenance burden across multiple platforms
- Can't customize the learning experience (microlearning, swipeable content)

The new platform unifies everything into one codebase.

### Why Supabase Over Other Options?

- **PostgreSQL** — real relational database, not a toy
- **Built-in auth** — no need for a separate auth service
- **Row Level Security** — security at the database level
- **Realtime** — for notifications and live features
- **Storage** — for future file uploads
- **Free tier** — good enough to launch
- **eu-north-1 (Stockholm)** — data stays in Sweden, low latency for Swedish users

### Why Next.js App Router?

- Server Components reduce client JavaScript
- Server Actions simplify form handling
- Built-in routing matches the page structure
- Vercel hosting is seamless
- React 19 features (use, Suspense boundaries)

### Why Not a Component Library (shadcn, etc.)?

Intentional decision. The "Scandinavian Athletic Editorial" design style is distinctive and minimal. A component library would add complexity and fight the custom aesthetic. The four UI primitives (Button, Input, Card, Badge) are small and purposeful.

### Why Swedish-First with i18n-Ready?

All users are Swedish athletes. English can come later. The `next-intl` package is installed and the architecture supports multiple languages, but only Swedish content exists now.

### Why `getUser()` Not `getSession()`?

`getSession()` reads the JWT without verifying it against the server. This is a known Supabase footgun — it can return stale or tampered data. `getUser()` makes a server call to verify. Slightly slower, but correct. This is enforced as a convention throughout the codebase.

## What's Real vs. Placeholder

### Real Implementation (works end-to-end)
- Database schema with all 14 tables, RLS policies, triggers, indexes
- Auth flow (email + password registration and login)
- Middleware (route protection, token refresh)
- Marketing pages (fully designed, all text in Swedish)
- Supabase client configuration (browser, server, admin)
- CI/CD pipelines (typecheck, lint, test on PRs; migration push on main)
- Curriculum structure (12 modules, 57 lessons with correct Swedish titles)

### Scaffolded but Needs Work
- **Platform pages** — Layout and basic structure exist, but data fetching is minimal or uses placeholder data
- **LMS lesson feed** — Component structure is complete but lesson `content` field is empty (`[]`)
- **AI coach** — Route handler, system prompt, and chat UI exist, but need an API key to test
- **Admin pages** — Basic pages exist but content editor (BlockNote) is not integrated
- **Exercise components** — Card components exist but save/submit logic may need testing
- **Stripe webhook** — Handler exists but no real Stripe products are set up

### Empty / Not Started
- Test files (all test directories contain only `.gitkeep`)
- PWA manifest
- Real lesson content (videos, text, exercises)
- Social login (Google/Apple OAuth providers)
- Blog content

## Known Limitations

1. **No tests** — The CI pipeline runs tests, but there are no actual test files. This is the biggest gap.

2. **Supabase types may be stale** — `src/lib/supabase/types.ts` was generated from the schema at build time. If you modify the schema, regenerate with:
   ```bash
   supabase gen types typescript --linked > src/lib/supabase/types.ts
   ```

3. **Content is structural only** — Modules and lessons exist in the database with correct titles and ordering, but the `content` JSONB field is empty. Each lesson needs actual content blocks (text paragraphs, video IDs, exercise prompts, etc.).

4. **Unicode was an issue** — Some files originally had Unicode escape sequences (`\u00e4` instead of `a`) for Swedish characters. This was fixed, but if you see escaped characters, convert them to real UTF-8.

5. **GitHub Actions secrets** — The CI workflows need these secrets configured in your GitHub repo settings (Settings > Secrets and Variables > Actions):
   - `SUPABASE_ACCESS_TOKEN` — for `supabase db push` in the production workflow
   - `SUPABASE_PROJECT_REF` — your project reference ID
   - `SUPABASE_DB_PASSWORD` — your database password

## Implementation Plan Status

The implementation plan (`docs/plans/2026-03-05-implementation-plan.md`) has 32 tasks across 6 phases:

| Phase | Tasks | Status |
|-------|-------|--------|
| 1: Foundation | Tasks 1-8 | Complete |
| 2: Core LMS | Tasks 9-14 | Partially scaffolded |
| 3: AI Coach | Tasks 15-19 | Scaffolded, needs API key + testing |
| 4: Payments & Messaging | Tasks 20-23 | Scaffolded, needs real service accounts |
| 5: Admin & Polish | Tasks 24-28 | Basic scaffolding only |
| 6: Launch Prep | Tasks 29-32 | Not started |

## Product Owner Questions

These questions from the design document need your input to guide development:

1. **Content format** — How detailed should each lesson be? Short TikTok-style cards or longer educational content?
2. **AI coach personality** — How formal/casual should the AI coach be? Name?
3. **Pricing tiers** — Are the three tiers (Free/Standard 799 SEK/Premium 2,499 SEK) final?
4. **Social login priority** — Google first? Apple? Both?
5. **Notification strategy** — Which events should trigger email vs. in-app vs. SMS?
6. **Blog content** — Will you write blog posts, or is this low priority?
7. **Video content** — Are existing Vimeo videos ready to link, or do new ones need to be recorded?
8. **Mobile app** — Is a PWA sufficient or do you need native apps eventually?
9. **Analytics** — What metrics matter most for tracking athlete engagement?
10. **Launch timeline** — When do you want to start onboarding new users?

## File Count Summary

- **121 source files** in `src/`
- **1 migration** + **1 seed file** in `supabase/`
- **3 GitHub Actions workflows**
- **2 planning documents** in `docs/plans/`
- **5 commits** on main branch
