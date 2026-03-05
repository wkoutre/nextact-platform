import type { Metadata } from "next";
import Link from "next/link";

export const metadata: Metadata = {
  title: "Priser — Next Act",
  description:
    "Välj den plan som passar dig. Börja gratis och uppgradera när du är redo.",
};

const TIERS = [
  {
    name: "Gratis",
    price: "0",
    unit: "SEK",
    features: ["Introduktionsmoduler", "10 AI-coach meddelanden/vecka"],
    cta: "Kom igång",
    href: "/registrera",
    recommended: false,
  },
  {
    name: "Standard",
    price: "799",
    unit: "SEK/år inkl. moms",
    features: ["Alla 12 moduler", "50 AI-meddelanden/dag"],
    cta: "Välj Standard",
    href: "/registrera?plan=standard",
    recommended: true,
  },
  {
    name: "Premium",
    price: "2 499",
    unit: "SEK/år inkl. moms",
    features: ["Allt i Standard", "Psykologsessioner", "Obegränsad AI-coach"],
    cta: "Välj Premium",
    href: "/registrera?plan=premium",
    recommended: false,
  },
] as const;

const FAQ = [
  {
    question: "Kan jag byta plan när som helst?",
    answer:
      "Ja, du kan uppgradera eller nedgradera din plan när som helst. Ändringar träder i kraft direkt.",
  },
  {
    question: "Vad ingår i gratisplanen?",
    answer:
      "Gratisplanen ger dig tillgång till introduktionsmodulerna och 10 AI-coach meddelanden per vecka. Perfekt för att testa plattformen.",
  },
  {
    question: "Finns det någon bindningstid?",
    answer:
      "Nej, du kan avsluta din prenumeration när som helst. Du behåller tillgång till resten av din betalda period.",
  },
  {
    question: "Hur fungerar psykolog-sessionerna i Premium?",
    answer:
      "Premium-medlemmar får tillgång till digitala sessioner med licensierade psykologer specialiserade på idrottspsykologi.",
  },
] as const;

export default function PricingPage() {
  return (
    <>
      {/* Header */}
      <section className="bg-off-white pb-8 pt-24 md:pb-12 md:pt-32">
        <div className="mx-auto max-w-6xl px-6">
          <h1 className="font-heading text-4xl font-bold tracking-tight text-navy md:text-6xl lg:text-7xl">
            Priser
          </h1>
          <p className="mt-4 max-w-md text-lg text-charcoal md:text-xl">
            Välj den plan som passar dig.
          </p>
        </div>
      </section>

      {/* Tiers — horizontal rows */}
      <section className="bg-off-white pb-20 pt-8 md:pb-28 md:pt-12">
        <div className="mx-auto max-w-6xl px-6">
          <div className="divide-y divide-navy/10">
            {TIERS.map((tier) => (
              <div
                key={tier.name}
                className={[
                  "grid grid-cols-1 items-center gap-6 py-10 md:grid-cols-[1fr_auto_1fr_auto] md:gap-10 lg:py-12",
                  tier.recommended
                    ? "-mx-6 rounded-lg bg-navy px-6 md:-mx-8 md:px-8"
                    : "",
                ].join(" ")}
              >
                {/* Name */}
                <div>
                  <div className="flex items-center gap-3">
                    <h2
                      className={[
                        "font-heading text-2xl font-bold tracking-tight md:text-3xl",
                        tier.recommended ? "text-white" : "text-navy",
                      ].join(" ")}
                    >
                      {tier.name}
                    </h2>
                    {tier.recommended && (
                      <span className="rounded-lg bg-white/15 px-2.5 py-1 text-xs font-semibold uppercase tracking-widest text-white/80">
                        Rekommenderad
                      </span>
                    )}
                  </div>
                </div>

                {/* Price */}
                <div className="md:text-center">
                  <span
                    className={[
                      "font-heading text-3xl font-bold tabular-nums md:text-4xl",
                      tier.recommended ? "text-white" : "text-navy",
                    ].join(" ")}
                  >
                    {tier.price}
                  </span>
                  <span
                    className={[
                      "ml-2 text-sm",
                      tier.recommended ? "text-white/60" : "text-charcoal",
                    ].join(" ")}
                  >
                    {tier.unit}
                  </span>
                </div>

                {/* Features */}
                <ul className="flex flex-wrap gap-x-6 gap-y-1">
                  {tier.features.map((feature) => (
                    <li
                      key={feature}
                      className={[
                        "text-sm",
                        tier.recommended ? "text-white/70" : "text-charcoal",
                      ].join(" ")}
                    >
                      {feature}
                    </li>
                  ))}
                </ul>

                {/* CTA */}
                <div className="md:text-right">
                  <Link
                    href={tier.href}
                    className={[
                      "inline-flex items-center justify-center rounded-lg px-6 py-3 font-heading text-sm font-semibold uppercase tracking-wide transition-all duration-200",
                      tier.recommended
                        ? "bg-white text-navy hover:-translate-y-px hover:shadow-md"
                        : "bg-navy text-white hover:-translate-y-px hover:shadow-md hover:shadow-navy/15",
                    ].join(" ")}
                  >
                    {tier.cta}
                  </Link>
                </div>
              </div>
            ))}
          </div>

          <p className="mt-12 text-sm text-charcoal">
            Alla priser i svenska kronor, inklusive 25% moms. Betalning hanteras
            säkert via Stripe.
          </p>
        </div>
      </section>

      {/* FAQ */}
      <section className="bg-white py-20 md:py-28">
        <div className="mx-auto max-w-6xl px-6">
          <div className="grid grid-cols-1 gap-12 md:grid-cols-[280px_1fr] md:gap-16">
            {/* Left column — heading */}
            <div>
              <h2 className="font-heading text-2xl font-bold text-navy md:text-3xl">
                Vanliga frågor
              </h2>
            </div>

            {/* Right column — questions */}
            <div className="divide-y divide-navy/10">
              {FAQ.map((item) => (
                <details key={item.question} className="group py-6 first:pt-0">
                  <summary className="flex cursor-pointer list-none items-center justify-between font-heading text-base font-semibold text-navy [&::-webkit-details-marker]:hidden">
                    {item.question}
                    <span className="ml-4 shrink-0 text-charcoal transition-transform duration-200 group-open:rotate-45">
                      +
                    </span>
                  </summary>
                  <p className="mt-3 max-w-xl text-sm leading-relaxed text-charcoal">
                    {item.answer}
                  </p>
                </details>
              ))}
            </div>
          </div>
        </div>
      </section>

      {/* CTA */}
      <section className="border-t border-navy/10 bg-off-white py-20 md:py-28">
        <div className="mx-auto max-w-6xl px-6">
          <h2 className="font-heading text-2xl font-bold text-navy md:text-3xl">
            Redo att börja?
          </h2>
          <p className="mt-3 max-w-md text-charcoal">
            Skapa ett gratis konto på under en minut.
          </p>
          <Link
            href="/registrera"
            className="mt-8 inline-flex items-center justify-center rounded-lg bg-navy px-7 py-3 font-heading text-sm font-semibold uppercase tracking-wide text-white transition-all duration-200 hover:-translate-y-px hover:shadow-md hover:shadow-navy/15"
          >
            Kom igång gratis
          </Link>
        </div>
      </section>
    </>
  );
}
