# Next Act Ung — Design Document

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:writing-plans before any implementation.

**Datum:** 2026-03-09
**Status:** Godkänd av Axel Lindahl

---

## Mål

Skapa ett nytt program — *Next Act Ung* — som tränar mental styrka för 12-15-åringar. Programmet bygger på samma ACT/MAC-ramverk (tuffhetsmodellen) som vuxenprogrammet men är:

- **Inte idrottsspecifikt** — fungerar för alla, oavsett om de spelar fotboll eller har svårt att prata inför klassen
- **Karaktärsbaserat** — eleven skapar sin egen karaktär och hjälper den framåt
- **AI-onboardat** — en konversation med AI bygger karaktärsprofilen
- **Skol-primärt** — designat för klassrumsbruk (idrott & hälsa, livskunskap) men fungerar även självständigt

**Kärninsikt:** Motivation är låg när programmet inte känns relevant. Personalisering löser det — varje elev skapar ett program utifrån *sin* verklighet (fotboll, musik, skolan, socialt, vad som helst).

---

## Målgrupp

- **Primär:** 12-15 år, i skolan
- **Kanal:** Lärare köper licenser (B2B), kör det som del av undervisningen
- **Sekundär:** Elever som gör det självständigt hemma
- **Marknadsposition:** Livskunskapsprogram för mental styrka — inte ett renodlat idrottsprogram

---

## Ramverk: Tuffhetsmodellen (4 delar)

Samma fyra delar som vuxenprogrammet, men formulerade för livet i stort:

1. **Värderad riktning** — Vad är viktigt för dig? Vad vill du uppnå?
2. **Hinder** — Vad stoppar dig? Tankar, känslor, situationer.
3. **Nyckelaktioner** — Vad gör du när du möter hindren? (det du gör nu, inte vad du borde göra)
4. **Engagemang** — Vilka beteenden hjälper dig att röra dig mot din riktning trots hindren?

---

## Karaktärssystemet

Eleven **skapar en karaktär** i onboardingen:

- Ger karaktären ett namn (valfritt, kan vara ett smeknamn eller påhittat)
- Karaktärens "värderade riktning" = vad eleven själv brinner för (sport, skola, musik, etc.)
- Karaktärens "hinder" = det eleven själv kämpar med
- Karaktärens "situation" = ålder, kontext, vad de vill förändra

Karaktärens resa *är* programmets berättelse. Eleven hjälper karaktären genom utmaningar som speglar deras egna. Psykologisk effekt: **externalisering** — det är lättare att reflektera ärligt när det är "karaktärens" problem, inte "mitt" problem.

Karaktärsdata lagras i databasen och används som variabler i berättelsens text (`{character_name}`, `{valued_direction}`, `{main_obstacle}`).

---

## AI-onboarding: Karaktärssamtalet

**Flöde:**

1. Eleven börjar programmet → möts av en välkomstskärm med den animerade coachen
2. Coachen startar ett samtal: *"Berätta lite om dig själv. Vad är du bra på? Vad är viktigt för dig?"*
3. AI-chatten leder en strukturerad konversation (15-20 minuter, ca 10-15 frågor)
4. Under ytan samlar AI:n in de fyra tuffhetsmodell-komponenterna
5. Chatten avslutas med en sammanfattning: *"Så här ser jag din karaktär — stämmer det?"*
6. Eleven bekräftar eller korrigerar → profilen låses och karaktären skapas

**Vad AI:n samlar in:**

| Komponent | Exempelfrågor |
|-----------|--------------|
| Värderad riktning | "Vad drömmer du om att bli bättre på?" / "Vad gör dig stolt?" |
| Hinder | "När känner du att det är svårast?" / "Vad stoppar dig oftast?" |
| Nuvarande beteende | "Vad brukar du göra när det går dåligt?" |
| Kontext | "Är det mest i [idrott/skolan/socialt]?" |

**Viktiga designkrav för AI-chatten:**
- Nyfiken och varm ton — inte formulärlik
- Ställer följdfrågor om svaren är ytliga ("Berätta mer om det...")
- Tar inte det första svaret för givet — gräver djupare
- Eleven märker aldrig att det är ett "formulär" under konversationen
- **Strikt prompting** — AI genererar aldrig terapeutiskt innehåll, bara ställer frågor och sammanfattar
- Hallucineringsrisken är minimal: AI:n skapar inte historia, bara profil

---

## Programstruktur: 6 moduler

Varje modul = 3-4 lektioner à 20-40 min. Designat för ett halvt skolläsår.

| Modul | Fokus | Tuffhetsmodellen |
|-------|-------|-----------------|
| 0 | Välkommen + Karaktärsskapandet (AI-onboarding) | — |
| 1 | Vad driver dig? | Värderad riktning |
| 2 | Vad stoppar dig? | Hinder |
| 3 | Vad gör du nu? | Nuvarande beteende |
| 4 | Vad kan du göra istället? | Nyckelaktioner |
| 5 | Håll kursen | Engagemang + integration |

---

## Innehållsformat per lektion

**Fördelning:**
- 40% Story-block (berättelse om karaktären, personaliserat med elevens data)
- 35% Övningar (kortare, ofta flerval + korta textsvar — "hjälp din karaktär")
- 20% Texter (förklaringar av ACT-begrepp, förenklat språk)
- 5% Video (animerad coach introducerar modulen)

**Berättelseblockets logik:**
Karaktären möter en situation kopplad till elevens eget hinder. T.ex. om eleven sa att hens hinder är "nervositet inför viktiga situationer" möter karaktären nervositet inför en konsert / match / redovisning (beroende på elevens kontext). Eleven väljer vad karaktären ska göra — och lär sig ACT-verktyget i processen.

**Övningsframing:**
Inte "Vad är DU rädd för?" utan "Din karaktär {name} är nervös inför {situation}. Vad tror du hen tänker?" — följt av "Har du känt så själv någon gång?" som frivillig fördjupning.

---

## Den animerade coachen

- Könsneutral, ung, sportig AI-genererad karaktär
- Konsekvent röd tråd — samma karaktär genom hela programmet
- Pratar i korta video-clips (30 sek - 2 min) som introducerar moduler och förklarar begrepp
- Kan produceras billigt med AI-video-verktyg (t.ex. HeyGen, Synthesia) eller animation
- Möjlighet att komplettera med riktiga inspelade filmer för djupare förklaringar (t.ex. hjärnans funktion)

---

## AI:s roll i programmet (utöver onboarding)

AI används **inte** för att generera berättelseinnehåll. Däremot:

1. **Onboarding-chatten** — samlar in och strukturerar karaktärsprofilen (primär AI-roll)
2. **Övningsvalidering** — när eleven svarar på en textövning kan AI ge ett kort, uppmuntrande svar som bekräftar att de svarat genomtänkt (inte bedömning, bara bekräftelse)
3. **Inget fritt AI-chatt under lektioner** — minskar hallucineringsrisken och håller fokus

---

## Lärarvy

Version 1: **Minimal lärarfunktionalitet**

- Läraren ser klassens framsteg (moduler avklarade, % genomfört)
- Läraren ser **aldrig** innehållet i elevernas svar (integritetsskydd)
- Enkel länk/kod för att bjuda in elever till en klass
- Ingen komplex dashboard — håll det enkelt i v1

---

## Teknisk arkitektur

Bygger på befintlig plattform med tillägg:

**Ny databas-data:**
- `character_profiles` — name, valued_direction, main_obstacle, current_behavior, context (sport/school/social/etc.)
- Kopplas till `user_id`
- Innehållsblock kan referera till `{character_name}`, `{valued_direction}` etc. via template-variabler

**Ny AI-komponent:**
- Separat system prompt för onboarding-chatten (strukturerad intervju, inte fri chatt)
- Extraherar och sparar profil-data när samtalet är klart
- Befintlig AI-chat-infrastruktur kan återanvändas

**Nytt innehåll:**
- Nytt program "Next Act Ung" i `programs`-tabellen
- 6 moduler med nya lektioner
- Story-block är redan byggt i plattformen

**Vad som återanvänds:**
- Hela lesson-feed-infrastrukturen
- Alla befintliga block-typer (story, text, exercise_text, exercise_choice, callout)
- AI-chat-infrastrukturen (ny system prompt)
- Auth, profiles, progress-tracking

---

## Vad som inte byggs i v1

- Avancerade lärarverktyg / analytics
- Gamification (poäng, badges)
- Forking av berättelsen (branching choices)
- Fler än 6 moduler
- Integrering med skolsystem (Skolon, etc.)

---

## Öppna frågor inför implementation

1. Ska programmet ha ett eget varumärke ("Next Act Ung") eller vara ett spårval inom Next Act?
2. Vem skriver berättelseinnehållet? (kräver en skicklig copywriter som förstår ACT + tonår)
3. Ska animerade coach-filmer produceras direkt, eller börja med text-only och lägga till video senare?
4. Hur hanteras GDPR för minderåriga — behövs föräldrasamtycke, eller räcker skolans ansvar?
