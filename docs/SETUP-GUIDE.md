# Setup Guide

This guide walks you through setting up the Next Act platform on your machine. It's written for someone using Claude Code — you can paste any step into Claude Code and ask it to help if you get stuck.

## Prerequisites

You need these tools installed. If you don't have them, ask Claude Code to help you install each one.

### 1. Node.js (v22+)

Check: `node --version`

If not installed:
```bash
# macOS
brew install node
```

### 2. pnpm (package manager)

Check: `pnpm --version`

If not installed:
```bash
npm install -g pnpm
```

### 3. Git

Check: `git --version`

Usually pre-installed on macOS. If not: `brew install git`

### 4. Supabase CLI

Check: `supabase --version`

If not installed:
```bash
brew install supabase/tap/supabase
```

### 5. GitHub CLI (optional, for repo management)

Check: `gh --version`

If not installed: `brew install gh`

---

## Step 1: Clone the Repository

This downloads the project code to your computer.

```bash
cd ~  # or wherever you keep projects
git clone https://github.com/YOUR_USERNAME/nextact-platform.git
cd nextact-platform
```

Replace `YOUR_USERNAME` with your GitHub username.

## Step 2: Install Dependencies

This downloads all the libraries the project needs.

```bash
pnpm install
```

This reads `package.json` and installs everything listed there. It takes 1-2 minutes.

## Step 3: Create a Supabase Project

1. Go to [supabase.com](https://supabase.com) and create an account
2. Click "New Project"
3. Choose your organization (or create one)
4. Settings:
   - **Name:** `nextact-platform`
   - **Database Password:** Generate a strong one and save it somewhere safe
   - **Region:** `eu-north-1 (Stockholm)` — closest to Swedish users
   - **Plan:** Free tier is fine to start
5. Wait for the project to finish provisioning (~2 minutes)

## Step 4: Get Your Supabase Credentials

1. In your Supabase project dashboard, go to **Settings > API**
2. You need three values:
   - **Project URL** (looks like `https://xxxx.supabase.co`)
   - **anon public key** (long string starting with `eyJ...`)
   - **service_role secret key** (another long string — keep this secret!)

## Step 5: Create Environment File

This file stores your secret keys locally (it's never committed to git).

```bash
cp .env.example .env.local
```

Now open `.env.local` and fill in your Supabase values:

```
NEXT_PUBLIC_SUPABASE_URL=https://your-project-id.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=eyJhbGci...your-anon-key
SUPABASE_SERVICE_ROLE_KEY=eyJhbGci...your-service-role-key
NEXT_PUBLIC_APP_URL=http://localhost:3000
```

Leave all other variables empty for now — they're for services you'll set up later (Stripe, AI coach, email, etc.).

## Step 6: Apply Database Schema

This creates all the tables, security policies, and indexes in your Supabase database.

### Option A: Using Supabase CLI (recommended)

Link your local project to your remote Supabase project:

```bash
supabase login
supabase link --project-ref YOUR_PROJECT_REF
```

Your project ref is the part of your Supabase URL between `https://` and `.supabase.co`.

Then push the migrations:

```bash
supabase db push
```

### Option B: Manual SQL

1. Open your Supabase Dashboard > SQL Editor
2. Copy the contents of `supabase/migrations/00001_initial_schema.sql`
3. Paste and run it

## Step 7: Seed the Database

This adds the 12 training modules and 57 lessons to your database.

### Option A: Using Supabase CLI

```bash
supabase db reset
```

Note: This drops and recreates everything, then runs migrations AND seed. Only use this on an empty/dev database.

### Option B: Manual SQL

1. Open Supabase Dashboard > SQL Editor
2. Copy the contents of `supabase/seed.sql`
3. Paste and run it

## Step 8: Run Locally

```bash
pnpm dev
```

Open [http://localhost:3000](http://localhost:3000) in your browser. You should see the Next Act marketing home page.

**What works without extra setup:**
- All marketing pages (home, pricing, about, blog, etc.)
- Registration and login (email + password via Supabase Auth)
- Platform pages (dashboard, learn, progress)
- Database reads (modules, lessons)

**What needs additional service setup:**
- AI coach (needs `ANTHROPIC_API_KEY`)
- Payments (needs Stripe account + keys)
- Email sending (needs Resend account + keys)
- SMS (needs Twilio account + keys)
- Video playback (needs Vimeo access token)
- Social login (needs Google/Apple OAuth configured in Supabase)

## Step 9: Deploy to Vercel

1. Go to [vercel.com](https://vercel.com) and create an account
2. Click "Import Project" or "Add New > Project"
3. Connect your GitHub account and select the `nextact-platform` repository
4. Vercel auto-detects Next.js — the defaults are correct
5. Add environment variables (same ones from your `.env.local`):
   - `NEXT_PUBLIC_SUPABASE_URL`
   - `NEXT_PUBLIC_SUPABASE_ANON_KEY`
   - `SUPABASE_SERVICE_ROLE_KEY`
   - `NEXT_PUBLIC_APP_URL` = your Vercel deployment URL
6. Click Deploy

After deployment, update `NEXT_PUBLIC_APP_URL` in Vercel's environment variables to match your actual deployment URL (e.g., `https://nextact-platform.vercel.app`).

Also add your Vercel deployment URL to Supabase's allowed redirect URLs:
1. Supabase Dashboard > Authentication > URL Configuration
2. Add your Vercel URL to "Redirect URLs"

---

## Future Setup (when ready)

### Stripe (Payments)

1. Create a [Stripe account](https://stripe.com)
2. Create three Products with Prices:
   - Free (no Stripe product needed)
   - Standard: 799 SEK/month
   - Premium: 2,499 SEK/month
3. Set up a webhook endpoint pointing to `YOUR_URL/api/webhooks/stripe`
4. Add keys to environment variables

### Anthropic (AI Coach)

1. Create an account at [console.anthropic.com](https://console.anthropic.com)
2. Generate an API key
3. Add `ANTHROPIC_API_KEY` to your environment variables

### Resend (Email)

1. Create a [Resend account](https://resend.com)
2. Verify your domain (nextact.se)
3. Generate an API key
4. Add `RESEND_API_KEY` to environment variables

### DNS Cutover

When ready to go live on nextact.se:
1. Point DNS A/CNAME records to Vercel
2. Add the domain in Vercel project settings
3. Update `NEXT_PUBLIC_APP_URL` to `https://nextact.se`
4. Update Supabase redirect URLs

---

## Troubleshooting

**Build fails with TypeScript errors:**
```bash
pnpm typecheck
```
This shows you exactly which files have type errors.

**Supabase connection fails:**
- Double-check your `.env.local` values
- Make sure you didn't add quotes around the values
- Verify the Supabase project is active (not paused)

**"Module not found" errors:**
```bash
pnpm install
```
Dependencies might not be installed.

**Need help with anything?**
Open Claude Code in the project directory and describe what you're trying to do. The `.claude/CLAUDE.md` file gives Claude full context about the project.
