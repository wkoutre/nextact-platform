# Next Act Platform — Content & UX Redesign Design

**Date:** 2026-03-06
**Status:** Approved
**Author:** Axel Lindahl + Claude

---

## Bakgrund

Det gamla programmet (Moodle/Fotboll) ersätts med en moderniserad version på den nya plattformen. Innehållet baseras på originalet men är anpassat för målgruppen (svenska idrottare 15–25), med bättre UX, kortare text och djupare AI-integration.

---

## Beslut

| Fråga | Beslut |
|-------|--------|
| Sport | Fotboll till att börja med, arkitektur designad för fler sporter senare |
| Format | Traditionellt men moderniserat — 10–20 min per session |
| AI-coach | Alltid tillgänglig chattkomponent ("Ditt mentala bollplank") |
| Tuffhetsmodellen | Levande dokument som byggs upp modul för modul |
| Veckouppgifter | Inbyggda i varje modul + skickade via SMS |
| Upplåsning | Sekventiell — avklarade moduler förblir redigerbara |

---

## 1. Modulstruktur (7 moduler)

| # | Namn | Kärntema | Tuffhetsmodellen |
|---|------|----------|-----------------|
| 1 | Psykologin bakom prestation | ACT-intro, kartläggning, mental tuffhet definieras | Del 1: Nuläge + mål |
| 2 | Din värderade riktning | Vad driver dig? 80-årsdag-övning, din inre glöd | Del 2: Värderad riktning |
| 3 | Förstå dina hinder | Hjärnan, Apan, kletiga tankar, defusion | Del 3: Hinder |
| 4 | Dina beteenden | 5-stegsanalys, läktaraktioner, nyckelaktioner, lagkultur | Del 4: Beteenden |
| 5 | Bli mentalt starkare | Exponering, acceptans, fokus på nästa aktion, våga-lista | Del 5: Våga-lista |
| 6 | Fokusera mera | Fokusövningar, refokusering, rutiner | Del 6: Fokusrutiner |
| 7 | Din Gameplan | Sammanfattning, komplett modell, nästa steg | Del 7: Gameplan |

**Upplåsningslogik:**
- Moduler låses upp sekventiellt när föregående är avklarad
- Avklarade moduler är alltid redigerbara — atleten kan gå tillbaka och ändra svar

---

## 2. Lektionsformat

Varje modul innehåller 4–6 lektioner. Lektioner scrollas uppifrån och ned (ej swipe). Mål: 10–20 min per lektion.

### Innehållsblock

| Block | Beskrivning | Max längd |
|-------|-------------|-----------|
| Video | Vimeo-video med Anders/Henrik. Måste ses klart | — |
| Text | Löptext skriven som en coach pratar — direkt, personlig | 100–150 ord |
| Berättelse | Kursiverad case-story om en fotbollsspelare | 80–120 ord |
| Ovning | Guidade fritextfält med 2–3 scaffolding-frågor | — |
| Veckouppgift | Checklistekort med 2–3 IRL-uppgifter | — |
| Bollplank-ingång | Mjuk uppmaning att öppna AI-chatten | — |

### Textriktlinjer
- Max 100–150 ord per textblock (vs. 300–500 i gamla programmet)
- Skriv som en coach pratar, inte som en lärobok
- Teorin levereras via video (Anders/Henrik), text kompletterar
- Övningar är guidade med scaffolding-frågor, inte öppna tomma rutor

---

## 3. SMS-triggers

Atleten fyller i sitt träningsschema (dagar + tider) i profilen. SMS skickas via Twilio.

| Trigger | Innehåll | Timing |
|---------|----------|--------|
| Modul 1–7 avklarad | Veckouppgiften för den avklarade modulen | 1 timme innan nästa träning per schema |
| Modul 5 avklarad | Din Våga-lista | Direkt |
| Modul 7 avklarad | Din Gameplan | Direkt |

**Fallback:** Om inget träningsschema är ifyllt skickas SMS direkt med en uppmaning att fylla i schemat.

---

## 4. Ditt mentala bollplank (AI-coachen)

### Tillgänglighet
- Flytande knapp längst ned i appen — alltid synlig, aldrig påtvingad
- Öppnas som en sidopanel eller modal

### Kontext & minne
Bollplanket har alltid tillgång till:
- Var i programmet atleten befinner sig (aktuell modul + lektion)
- Atletens kompletta tuffhetsmodell (alla svar på övningar)
- Tidigare samtal i programmet

### Tonalitet
- Avslappnad, coachig, inte terapeutisk
- Pratar med atleten vid namn
- Refererar till deras specifika svar: *"Du nämnde att din apa brukar dyka upp inför stora matcher..."*

### Kunskapsgrund — "Coach-handboken"
En kompakt strukturerad systemdokument (~3–4 sidor) som definierar:
1. **Ramverk** — utgår enbart från ACT och MAC. Inga andra metoder, inga diagnoser, inga medicinska råd
2. **Terminologi** — "Apan", "kletiga tankar", "värderad riktning", "nyckelaktioner", "läktaraktioner", "tuffhetsmodellen"
3. **Tuffhetsmodellens struktur** — hur den byggs upp steg för steg
4. **Gränser** — hänvisar vidare vid kris, rekommenderar aldrig utanför ramverket
5. **Tonalitet** — konkreta riktlinjer för hur bollplanket formulerar sig

---

## 5. Tuffhetsmodellen (levande dokument)

En dedikerad vy i appen som visar atletens personliga modell. Byggs automatiskt från övningssvar.

| Modul | Vad läggs till i modellen |
|-------|--------------------------|
| 1 | Kartläggning: nuläge, mål, sport, ålderskategori |
| 2 | Värderad riktning |
| 3 | Hinder: Apan + kletiga tankar |
| 4 | Läktaraktioner + Nyckelaktioner |
| 5 | Våga-lista |
| 6 | Fokusrutiner |
| 7 | Gameplan (sammanfattning av hela modellen) |

Bollplanket kan alltid referera till innehållet i modellen.

---

## 6. Vimeo-videor (från gamla programmet)

21 befintliga videor med Anders och Henrik mappas till de nya modulerna:

| Modul | Videor |
|-------|--------|
| Intro | Axels intro (1100225761) |
| 1 | Anders välkomnar och berättar (455700750), Modul 1 (455422409) |
| 2 | Modul 2 (1097559806), Anders förklarar värderad riktning (1097563492) |
| 3 | Modul 3 (1097569313), Anders förklarar hjärnan (1097572332), Anders analyserar fotbollsspelaren (1097577445), Anders analyserar tankar (1097582005), Henrik fördjupar tankar (1097585782) |
| 4 | Modul 4 intro (1097598224), Apan och kletiga tankar (1100640318), Nyckelaktioner (1100443289), Momentum (1100604948) |
| 5 | Modul 5 intro (1097600603), Anders förklarar verktyg (1097603378), Henrik fördjupar acceptans (1097605377) |
| 6 | Modul 6 (1100677431), Anders instruerar fokus (1097612921), Henrik fördjupar fokus (1097615120) |
| 7 | Modul 7 Avslutning (1097617371) |

---

## 7. Skalning till fler sporter

Arkitekturen designas med sport som en dimension från dag ett:
- Programmet är knutet till en `sport`-tagg (börjar med "fotboll")
- Berättelser och exempel märks med sport — enkelt att byta ut
- Framtida sporter får egna versioner av texterna, men delar videor och AI-logik

---

## Nästa steg

Skapa implementationsplan för:
1. Uppdatera databasschema — 7 moduler, ny lektionsstruktur, tuffhetsmodell-tabell
2. Fylla i faktiskt innehåll i databasen (text, övningar, veckouppgifter)
3. Bygga tuffhetsmodell-vyn
4. SMS-scheduler med träningsschema-logik
5. Coach-handboken + AI-systemprompt
6. Uppdatera lektionskomponenter med nya blocktyper
