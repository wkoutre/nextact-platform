import type { Metadata } from "next";
import Link from "next/link";

export const metadata: Metadata = {
  title: "Om Programmet \u2014 Next Act",
  description:
    "L\u00e4r dig mer om Next Acts evidensbaserade mentala tr\u00e4ningsprogram byggt p\u00e5 ACT och MAC.",
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
      "Legitimerad psykolog med 15 \u00e5rs erfarenhet av att arbeta med elitidrottare. Specialiserad p\u00e5 ACT-baserade interventioner.",
  },
  {
    name: "Marcus J\u00f6nsson",
    role: "Idrottsvetare & f.d. elitidrottare",
    description:
      "Tidigare landslagsspelare med en masterexamen i idrottsvetenskap. F\u00f6rst\u00e5r b\u00e5de teorin och verkligheten bakom mental tr\u00e4ning.",
  },
  {
    name: "Emma Svensson",
    role: "Beteendevetare & ACT-terapeut",
    description:
      "Certifierad ACT-terapeut med fokus p\u00e5 unga idrottare. Utvecklar programmets \u00f6vningar och \u00e5terkoppling.",
  },
];

export default function AboutPage() {
  return (
    <>
      {/* Hero */}
      <section className="bg-navy py-20 md:py-28">
        <div className="mx-auto max-w-4xl px-6 text-center">
          <p className="mb-4 text-sm font-semibold uppercase tracking-widest text-cyan font-heading">
            Evidensbaserad metod
          </p>
          <h1 className="font-heading text-3xl font-bold tracking-tight text-white md:text-5xl">
            Mental tr\u00e4ning byggt p\u00e5 vetenskap
          </h1>
          <p className="mt-4 text-lg text-white/60">
            Next Act bygger p\u00e5 ACT (Acceptance and Commitment Therapy) och
            MAC (Mindfulness-Acceptance-Commitment) \u2014 tv\u00e5 av de mest
            forskade metoderna inom idrottspsykologi.
          </p>
        </div>
      </section>

      {/* What is ACT */}
      <section className="bg-off-white py-20 md:py-28">
        <div className="mx-auto max-w-4xl px-6">
          <h2 className="font-heading text-2xl font-bold text-navy md:text-3xl">
            Vad \u00e4r ACT?
          </h2>
          <div className="mt-6 space-y-4 text-charcoal leading-relaxed">
            <p>
              Acceptance and Commitment Therapy (ACT) \u00e4r en evidensbaserad
              psykologisk metod som hj\u00e4lper m\u00e4nniskor att leva ett
              rikt och meningsfullt liv \u2014 \u00e4ven n\u00e4r det \u00e4r
              sv\u00e5rt. Ist\u00e4llet f\u00f6r att f\u00f6rs\u00f6ka eliminera
              negativa tankar och k\u00e4nslor, l\u00e4r ACT dig att hantera dem
              p\u00e5 ett mer flexibelt s\u00e4tt.
            </p>
            <p>
              F\u00f6r idrottare inneb\u00e4r detta att kunna prestera under
              press utan att k\u00e4mpa emot nervositeten, att fokusera p\u00e5
              det som spelar roll \u00e4ven n\u00e4r tankarna sp\u00e5rar, och
              att agera utifr\u00e5n dina v\u00e4rderingar snarare \u00e4n dina
              r\u00e4dslor.
            </p>
            <p>
              MAC-modellen (Mindfulness-Acceptance-Commitment) anpassar ACT
              specifikt f\u00f6r idrott och prestation. Forskning visar att
              MAC-baserade program \u00f6kar psykologisk flexibilitet,
              f\u00f6rb\u00e4ttrar prestation och minskar
              prestations\u00e5ngest.
            </p>
          </div>
        </div>
      </section>

      {/* 12 modules */}
      <section className="bg-white py-20 md:py-28">
        <div className="mx-auto max-w-5xl px-6">
          <div className="mx-auto max-w-2xl text-center">
            <h2 className="font-heading text-2xl font-bold text-navy md:text-3xl">
              Steg för steg till mental styrka
            </h2>
            <p className="mt-4 text-charcoal">
              Programmet är uppbyggt kring 12 moduler. Varje steg bygger på det
              förra och ger dig nya verktyg.
            </p>
          </div>

          <div className="mt-12 space-y-6">
            {MODULES.map((mod) => (
              <div
                key={mod.number}
                className="flex gap-5 rounded-2xl bg-off-white p-6"
              >
                <span className="flex h-10 w-10 shrink-0 items-center justify-center rounded-xl bg-primary/10 font-heading text-sm font-bold text-primary">
                  {mod.number}
                </span>
                <div>
                  <h3 className="font-heading text-lg font-semibold text-navy">
                    {mod.name}
                  </h3>
                  <p className="mt-1 text-sm leading-relaxed text-charcoal">
                    {mod.description}
                  </p>
                </div>
              </div>
            ))}
          </div>
        </div>
      </section>

      {/* Team */}
      <section className="bg-off-white py-20 md:py-28">
        <div className="mx-auto max-w-5xl px-6">
          <h2 className="text-center font-heading text-2xl font-bold text-navy md:text-3xl">
            Teamet bakom Next Act
          </h2>
          <p className="mt-4 text-center text-charcoal">
            Programmet \u00e4r utvecklat av experter inom idrottspsykologi,
            beteendevetenskap och elitidrottserfarenhet.
          </p>

          <div className="mt-12 grid gap-6 md:grid-cols-3">
            {TEAM.map((member) => (
              <div key={member.name} className="rounded-2xl bg-white p-6">
                <div className="flex h-14 w-14 items-center justify-center rounded-full bg-primary/10 font-heading text-lg font-bold text-primary">
                  {member.name[0]}
                </div>
                <h3 className="mt-4 font-heading text-base font-semibold text-navy">
                  {member.name}
                </h3>
                <p className="text-sm font-medium text-primary">
                  {member.role}
                </p>
                <p className="mt-2 text-sm leading-relaxed text-charcoal">
                  {member.description}
                </p>
              </div>
            ))}
          </div>
        </div>
      </section>

      {/* CTA */}
      <section className="bg-navy py-20">
        <div className="mx-auto max-w-2xl px-6 text-center">
          <h2 className="font-heading text-2xl font-bold text-white md:text-3xl">
            Redo att b\u00f6rja din resa?
          </h2>
          <p className="mt-3 text-white/60">
            Se v\u00e5ra planer och kom ig\u00e5ng idag.
          </p>
          <Link
            href="/priser"
            className="mt-8 inline-flex items-center rounded-[3rem] bg-primary px-8 py-4 text-lg font-semibold text-white shadow-lg shadow-primary/25 transition-all hover:bg-primary-hover font-heading"
          >
            Se priser
          </Link>
        </div>
      </section>
    </>
  );
}
