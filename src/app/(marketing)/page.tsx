import type { Metadata } from "next";
import Link from "next/link";

export const metadata: Metadata = {
  title: "Next Act — Mental träning för idrottare",
  description:
    "Evidensbaserad mental träning byggt på ACT. Utveckla mental styrka, hantera press och prestera när det gäller.",
  openGraph: {
    title: "Next Act — Mental träning för idrottare",
    description: "Evidensbaserad mental träning byggt på ACT.",
    url: "https://nextact.se",
    siteName: "Next Act",
    locale: "sv_SE",
    type: "website",
  },
};

const modules = [
  {
    number: 1,
    name: "Analys",
    description:
      "Kartlägg din nuvarande idrottssituation och sätt dina utvecklingsmål.",
  },
  {
    number: 2,
    name: "Värderad Riktning",
    description:
      "Utforska din värderade riktning och börja bygga din tuffhetsmodell.",
  },
  {
    number: 3,
    name: "Utforska Hinder",
    description: "Förstå hur tankar och känslor skapar prestationshinder.",
  },
  {
    number: 4,
    name: "Dina Beteenden",
    description: "Analysera dina beteenden och identifiera nyckelbeteenden.",
  },
  {
    number: 5,
    name: "Våga Utmana",
    description: "Utmana dig själv i nya situationer och bygg mental styrka.",
  },
  {
    number: 6,
    name: "Fokusera Mera",
    description: "Fördjupade fokusövningar för träning och tävling.",
  },
  {
    number: 7,
    name: "Målsättning",
    description: "Effektiv målsättning och utvärdering av din prestation.",
  },
  {
    number: 8,
    name: "Hitta Balansen",
    description: "Balans mellan idrott och privatliv i en krävande vardag.",
  },
  {
    number: 9,
    name: "Återhämtning",
    description: "Hållbar träning med rätt vila, kost och sömn.",
  },
  {
    number: 10,
    name: "Din Inre Kritiker",
    description: "Skriv om ditt inre självprat från kritik till stöd.",
  },
  {
    number: 11,
    name: "Hantera Motgångar",
    description: "Vänd motgångar till utvecklingsmöjligheter.",
  },
  {
    number: 12,
    name: "Utvärdering",
    description:
      "Sammanfatta din utveckling och planera din framtid som idrottare.",
  },
];

const testimonials = [
  {
    quote: "Programmet hjälpte mig hantera pressen inför viktiga matcher.",
    name: "Sofia",
    sport: "fotbollsspelare",
  },
  {
    quote: "Jag har blivit bättre på att fokusera under träning och match.",
    name: "Erik",
    sport: "handbollsspelare",
  },
  {
    quote: "Den mentala träningen var det som saknades i min utveckling.",
    name: "Alma",
    sport: "friidrottare",
  },
];

const steps = [
  {
    number: "01",
    title: "Skapa konto",
    description:
      "Registrera dig på under en minut. Ingen kreditkortsinformation krävs.",
  },
  {
    number: "02",
    title: "Gör dagliga övningar",
    description: "Korta, evidensbaserade lektioner anpassade för idrottare.",
  },
  {
    number: "03",
    title: "Utvecklas med AI-coachen",
    description:
      "Få personlig vägledning och reflektera kring din mentala träning.",
  },
];

export default function HomePage() {
  return (
    <>
      {/* ───── Hero ───── */}
      <section className="min-h-screen bg-white">
        <div className="mx-auto max-w-7xl px-6 pt-40 pb-24 md:pt-48 md:pb-32 lg:pt-56">
          <div className="grid grid-cols-1 gap-16 lg:grid-cols-5 lg:items-end">
            {/* Left — 60% */}
            <div className="lg:col-span-3">
              <h1 className="font-heading text-5xl font-bold leading-[0.95] tracking-tight text-navy sm:text-6xl md:text-7xl lg:text-8xl">
                Mental
                <br />
                styrka
              </h1>
              <p className="mt-4 font-heading text-2xl font-light text-charcoal sm:text-3xl md:text-4xl">
                för idrottare
              </p>
              <p className="mt-8 max-w-md text-base leading-relaxed text-charcoal md:text-lg">
                Evidensbaserad mental träning byggt på ACT. Strukturerat
                program, personlig AI-coachning och verktyg som fungerar under
                press.
              </p>
              <div className="mt-10">
                <Link
                  href="/registrera"
                  className="inline-flex items-center rounded-none bg-navy px-8 py-4 font-heading text-base font-semibold tracking-wide text-white transition-colors hover:bg-charcoal"
                >
                  Kom igång
                </Link>
              </div>
            </div>

            {/* Right — 40%, editorial data element */}
            <div className="lg:col-span-2 lg:text-right">
              <p className="font-heading text-[8rem] font-bold leading-none tracking-tighter text-off-white-alt sm:text-[10rem] lg:text-[12rem]">
                12
              </p>
              <p className="mt-2 font-heading text-lg font-medium uppercase tracking-widest text-light-gray">
                moduler
              </p>
            </div>
          </div>
        </div>
      </section>

      {/* ───── Evidence Strip ───── */}
      <section className="border-y border-light-gray/40 bg-white">
        <div className="mx-auto flex max-w-7xl flex-col items-start justify-between gap-4 px-6 py-5 sm:flex-row sm:items-center">
          <span className="font-body text-xs font-medium uppercase tracking-[0.25em] text-charcoal">
            ACT-baserad metod
          </span>
          <span
            className="hidden h-px w-12 bg-light-gray sm:block"
            aria-hidden="true"
          />
          <span className="font-body text-xs font-medium uppercase tracking-[0.25em] text-charcoal">
            12 strukturerade moduler
          </span>
          <span
            className="hidden h-px w-12 bg-light-gray sm:block"
            aria-hidden="true"
          />
          <span className="font-body text-xs font-medium uppercase tracking-[0.25em] text-charcoal">
            Personlig AI-coachning
          </span>
        </div>
      </section>

      {/* ───── Program — 12 Steg ───── */}
      <section className="bg-off-white py-24 md:py-36">
        <div className="mx-auto max-w-5xl px-6">
          <h2 className="font-heading text-sm font-medium uppercase tracking-[0.3em] text-charcoal">
            Programmet
          </h2>

          <div className="mt-12 space-y-0">
            {modules.map((mod) => (
              <div
                key={mod.number}
                className="grid grid-cols-[3.5rem_1fr] items-baseline gap-x-4 border-b border-light-gray/30 py-5 md:grid-cols-[4rem_12rem_1fr] md:gap-x-8"
              >
                <span className="font-heading text-3xl font-bold leading-none text-light-gray md:text-4xl">
                  {String(mod.number).padStart(2, "0")}
                </span>
                <p className="font-heading text-lg font-semibold text-navy md:text-xl">
                  {mod.name}
                </p>
                <p className="col-start-2 mt-1 text-sm leading-relaxed text-charcoal md:col-start-3 md:mt-0">
                  {mod.description}
                </p>
              </div>
            ))}
          </div>
        </div>
      </section>

      {/* ───── Så fungerar det ───── */}
      <section className="bg-white py-24 md:py-36">
        <div className="mx-auto max-w-5xl px-6">
          <h2 className="font-heading text-sm font-medium uppercase tracking-[0.3em] text-charcoal">
            Så fungerar det
          </h2>

          <div className="mt-12">
            {steps.map((step, i) => (
              <div
                key={step.number}
                className={`grid grid-cols-1 gap-4 py-8 md:grid-cols-[4rem_12rem_1fr] md:items-baseline md:gap-x-8${
                  i < steps.length - 1 ? " border-b border-light-gray/30" : ""
                }`}
              >
                <span className="font-heading text-3xl font-bold leading-none text-primary md:text-4xl">
                  {step.number}
                </span>
                <h3 className="font-heading text-xl font-semibold text-navy">
                  {step.title}
                </h3>
                <p className="text-base leading-relaxed text-charcoal">
                  {step.description}
                </p>
              </div>
            ))}
          </div>
        </div>
      </section>

      {/* ───── Testimonials ───── */}
      <section className="bg-navy py-24 md:py-36">
        <div className="mx-auto max-w-5xl px-6">
          {/* Lead quote — large editorial scale */}
          <blockquote>
            <p className="max-w-3xl font-heading text-2xl font-light italic leading-snug text-white sm:text-3xl md:text-4xl">
              &ldquo;{testimonials[0].quote}&rdquo;
            </p>
            <footer className="mt-6">
              <span className="text-sm font-medium text-light-gray">
                {testimonials[0].name}, {testimonials[0].sport}
              </span>
            </footer>
          </blockquote>

          {/* Secondary quotes — smaller, stacked */}
          <div className="mt-16 grid grid-cols-1 gap-10 border-t border-white/10 pt-12 sm:grid-cols-2 sm:gap-16">
            {testimonials.slice(1).map((t) => (
              <blockquote key={t.name}>
                <p className="text-lg font-light italic leading-relaxed text-white/80">
                  &ldquo;{t.quote}&rdquo;
                </p>
                <footer className="mt-4">
                  <span className="text-xs font-medium uppercase tracking-widest text-light-gray">
                    {t.name}, {t.sport}
                  </span>
                </footer>
              </blockquote>
            ))}
          </div>
        </div>
      </section>

      {/* ───── Final CTA ───── */}
      <section className="bg-white py-32 md:py-44">
        <div className="mx-auto max-w-5xl px-6">
          <div className="flex flex-col gap-6 md:flex-row md:items-baseline md:justify-between">
            <div>
              <h2 className="font-heading text-6xl font-bold tracking-tight text-navy sm:text-7xl md:text-8xl">
                Redo?
              </h2>
              <p className="mt-4 text-lg text-charcoal">
                Börja din mentala träning idag.
              </p>
            </div>
            <div className="shrink-0">
              <Link
                href="/registrera"
                className="inline-flex items-center rounded-none bg-navy px-8 py-4 font-heading text-base font-semibold tracking-wide text-white transition-colors hover:bg-charcoal"
              >
                Kom igång
              </Link>
            </div>
          </div>
        </div>
      </section>
    </>
  );
}
