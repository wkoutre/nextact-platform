import type { Metadata } from "next";
import Link from "next/link";

export const metadata: Metadata = {
  title: "Om Programmet — Next Act",
  description:
    "Lär dig mer om Next Acts evidensbaserade mentala träningsprogram byggt på ACT och MAC.",
};

const MODULES = [
  {
    number: 1,
    name: "Analys",
    description:
      "Kartlägg din nuvarande idrottssituation, identifiera mål och förstå dina förutsättningar för utveckling.",
  },
  {
    number: 2,
    name: "Värderad Riktning",
    description:
      "Utforska din värderade riktning och dess roll för din måluppfyllelse. Börja bygga din tuffhetsmodell.",
  },
  {
    number: 3,
    name: "Utforska Hinder",
    description:
      "Förstå hur hjärnan fungerar och hur tankar och känslor skapar prestationshinder.",
  },
  {
    number: 4,
    name: "Dina Beteenden",
    description:
      "Analysera dina beteenden i olika situationer och identifiera nyckelbeteenden att träna.",
  },
  {
    number: 5,
    name: "Våga Utmana",
    description:
      "Utforska mental styrka genom varierade situationer. Skapa din egen våga-lista.",
  },
  {
    number: 6,
    name: "Fokusera Mera",
    description:
      "Fördjupade fokusövningar av ökande svårighetsgrad för träning och tävling.",
  },
  {
    number: 7,
    name: "Målsättning & Utvärdering",
    description:
      "Effektiv målsättning och utvärdering. Sätt upp mål och mät din prestation.",
  },
  {
    number: 8,
    name: "Hitta Balansen",
    description:
      "Uppdatera tuffhetsmodellen med svårare situationer. Utforska balans mellan idrott och privatliv.",
  },
  {
    number: 9,
    name: "Återhämtning",
    description:
      "Balans mellan träning och vila. Hållbar träningsplanering, kost och sömn.",
  },
  {
    number: 10,
    name: "Din Inre Kritiker",
    description:
      "Utveckla medvetenhet om ditt inre självprat och skriv om din berättelse konstruktivt.",
  },
  {
    number: 11,
    name: "Hantera Motgångar",
    description:
      "Strategier för att hantera motgångar och omvandla dem till utvecklingsmöjligheter.",
  },
  {
    number: 12,
    name: "Utvärdering och Planering",
    description:
      "Sammanfatta din utveckling och skapa en plan för din framtida idrottskarriär.",
  },
];

const TEAM = [
  {
    name: "Dr. Anna Lindberg",
    role: "Idrottspsykolog",
    description:
      "Legitimerad psykolog med 15 års erfarenhet av att arbeta med elitidrottare. Specialiserad på ACT-baserade interventioner.",
  },
  {
    name: "Marcus Jönsson",
    role: "Idrottsvetare & f.d. elitidrottare",
    description:
      "Tidigare landslagsspelare med en masterexamen i idrottsvetenskap. Förstår både teorin och verkligheten bakom mental träning.",
  },
  {
    name: "Emma Svensson",
    role: "Beteendevetare & ACT-terapeut",
    description:
      "Certifierad ACT-terapeut med fokus på unga idrottare. Utvecklar programmets övningar och återkoppling.",
  },
];

export default function AboutPage() {
  return (
    <>
      {/* Header */}
      <section className="bg-off-white pb-8 pt-24 md:pb-12 md:pt-32">
        <div className="mx-auto max-w-6xl px-6">
          <p className="mb-4 font-heading text-xs font-semibold uppercase tracking-[0.2em] text-charcoal">
            Evidensbaserad metod
          </p>
          <h1 className="font-heading text-4xl font-bold tracking-tight text-navy md:text-6xl lg:text-7xl">
            Om Programmet
          </h1>
        </div>
      </section>

      {/* Pull-quote — typographic statement */}
      <section className="bg-off-white pb-20 pt-8 md:pb-28 md:pt-16">
        <div className="mx-auto max-w-6xl px-6">
          <div className="max-w-3xl">
            <p className="font-heading text-2xl font-medium leading-snug tracking-tight text-navy md:text-3xl lg:text-4xl">
              ACT är en evidensbaserad psykologisk metod som hjälper idrottare
              att utveckla psykologisk flexibilitet — förmågan att prestera
              under press, fokusera på det som spelar roll, och agera utifrån
              sina värderingar snarare än sina rädslor.
            </p>
            <p className="mt-8 max-w-xl text-base leading-relaxed text-charcoal md:text-lg">
              Next Act bygger på ACT (Acceptance and Commitment Therapy) och MAC
              (Mindfulness-Acceptance-Commitment) — två av de mest forskade
              metoderna inom idrottspsykologi. Forskning visar att MAC-baserade
              program ökar psykologisk flexibilitet, förbättrar prestation och
              minskar prestationsångest.
            </p>
          </div>
        </div>
      </section>

      {/* 12 Modules — typographic numbered list */}
      <section className="bg-white py-20 md:py-28">
        <div className="mx-auto max-w-6xl px-6">
          <div className="mb-16 max-w-md">
            <h2 className="font-heading text-2xl font-bold text-navy md:text-3xl">
              12 moduler
            </h2>
            <p className="mt-3 text-charcoal">
              Varje steg bygger på det förra och ger dig nya verktyg för mental
              styrka.
            </p>
          </div>

          <div className="divide-y divide-navy/10">
            {MODULES.map((mod) => (
              <div
                key={mod.number}
                className="grid grid-cols-1 gap-2 py-6 md:grid-cols-[80px_200px_1fr] md:items-baseline md:gap-8 lg:py-8"
              >
                <span className="font-heading text-4xl font-bold text-light-gray md:text-5xl">
                  {String(mod.number).padStart(2, "0")}
                </span>
                <h3 className="font-heading text-lg font-bold text-navy">
                  {mod.name}
                </h3>
                <p className="max-w-lg text-sm leading-relaxed text-charcoal">
                  {mod.description}
                </p>
              </div>
            ))}
          </div>
        </div>
      </section>

      {/* Team — text-only grid */}
      <section className="bg-off-white py-20 md:py-28">
        <div className="mx-auto max-w-6xl px-6">
          <h2 className="mb-16 font-heading text-2xl font-bold text-navy md:text-3xl">
            Teamet bakom Next Act
          </h2>

          <div className="grid grid-cols-1 gap-12 md:grid-cols-2 md:gap-16">
            {TEAM.map((member) => (
              <div key={member.name}>
                <h3 className="font-heading text-lg font-bold text-navy">
                  {member.name}
                </h3>
                <p className="mt-1 text-sm font-medium uppercase tracking-wide text-charcoal">
                  {member.role}
                </p>
                <p className="mt-4 max-w-sm text-sm leading-relaxed text-charcoal">
                  {member.description}
                </p>
              </div>
            ))}
          </div>
        </div>
      </section>

      {/* CTA */}
      <section className="border-t border-navy/10 bg-white py-20 md:py-28">
        <div className="mx-auto max-w-6xl px-6">
          <h2 className="font-heading text-2xl font-bold text-navy md:text-3xl">
            Redo att börja?
          </h2>
          <p className="mt-3 max-w-md text-charcoal">
            Se våra planer och kom igång idag.
          </p>
          <Link
            href="/priser"
            className="mt-8 inline-flex items-center justify-center rounded-lg bg-navy px-7 py-3 font-heading text-sm font-semibold uppercase tracking-wide text-white transition-all duration-200 hover:-translate-y-px hover:shadow-md hover:shadow-navy/15"
          >
            Se priser
          </Link>
        </div>
      </section>
    </>
  );
}
