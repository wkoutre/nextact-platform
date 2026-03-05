import Link from "next/link";

const produktLinks = [
  { href: "/om-programmet", label: "Programmet" },
  { href: "/priser", label: "Priser" },
  { href: "/#ai-coachen", label: "AI-coachen" },
];

const infoLinks = [
  { href: "/om-oss", label: "Om oss" },
  { href: "/blogg", label: "Blogg" },
  { href: "/integritetspolicy", label: "Integritet" },
  { href: "/villkor", label: "Villkor" },
];

export function MarketingFooter() {
  return (
    <footer className="bg-off-white text-navy">
      <div className="mx-auto max-w-7xl px-6 py-20 lg:px-10 lg:py-28">
        {/* Main content — two columns */}
        <div className="flex flex-col gap-16 lg:flex-row lg:items-start lg:justify-between">
          {/* Left — Brand */}
          <div className="max-w-sm">
            <p className="font-heading text-4xl font-bold tracking-tight lg:text-5xl">
              Next Act
            </p>
            <p className="mt-4 text-base leading-relaxed text-charcoal">
              Evidensbaserad mental tr&auml;ning f&ouml;r idrottare som vill
              prestera n&auml;r det g&auml;ller.
            </p>
          </div>

          {/* Right — Link grid */}
          <div className="grid grid-cols-2 gap-x-16 gap-y-10">
            <div>
              <p className="mb-4 text-xs font-semibold uppercase tracking-widest text-light-gray">
                Produkt
              </p>
              <ul className="flex flex-col gap-3">
                {produktLinks.map((link) => (
                  <li key={link.href}>
                    <Link
                      href={link.href}
                      className="text-sm text-charcoal transition-colors duration-200 hover:text-navy"
                    >
                      {link.label}
                    </Link>
                  </li>
                ))}
              </ul>
            </div>
            <div>
              <p className="mb-4 text-xs font-semibold uppercase tracking-widest text-light-gray">
                Information
              </p>
              <ul className="flex flex-col gap-3">
                {infoLinks.map((link) => (
                  <li key={link.href}>
                    <Link
                      href={link.href}
                      className="text-sm text-charcoal transition-colors duration-200 hover:text-navy"
                    >
                      {link.label}
                    </Link>
                  </li>
                ))}
              </ul>
            </div>
          </div>
        </div>

        {/* Bottom bar */}
        <div className="mt-20 flex flex-col items-start justify-between gap-4 border-t border-navy/10 pt-8 md:flex-row md:items-center">
          <p className="text-xs text-light-gray">
            &copy; 2026 Next Act. Alla r&auml;ttigheter f&ouml;rbeh&aring;llna.
          </p>
          <div className="flex items-center gap-6">
            <a
              href="https://instagram.com"
              target="_blank"
              rel="noopener noreferrer"
              className="text-xs text-light-gray transition-colors duration-200 hover:text-navy"
            >
              Instagram
            </a>
            <a
              href="mailto:hej@nextact.se"
              className="text-xs text-light-gray transition-colors duration-200 hover:text-navy"
            >
              Kontakt
            </a>
          </div>
        </div>
      </div>
    </footer>
  );
}
