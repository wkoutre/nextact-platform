"use client";

import { useState, useEffect, useCallback } from "react";
import Link from "next/link";

const navLinks = [
  { href: "/om-programmet", label: "Programmet" },
  { href: "/priser", label: "Priser" },
  { href: "/blogg", label: "Blogg" },
];

export function MarketingHeader() {
  const [scrolled, setScrolled] = useState(false);
  const [menuOpen, setMenuOpen] = useState(false);

  useEffect(() => {
    function onScroll() {
      setScrolled(window.scrollY > 10);
    }
    window.addEventListener("scroll", onScroll, { passive: true });
    return () => window.removeEventListener("scroll", onScroll);
  }, []);

  // Lock body scroll when mobile menu is open
  useEffect(() => {
    if (menuOpen) {
      document.body.style.overflow = "hidden";
    } else {
      document.body.style.overflow = "";
    }
    return () => {
      document.body.style.overflow = "";
    };
  }, [menuOpen]);

  const closeMenu = useCallback(() => setMenuOpen(false), []);

  return (
    <>
      <header
        className={`
          fixed top-0 left-0 right-0 z-50
          transition-[background-color,border-color] duration-300 ease-out
          ${
            scrolled
              ? "bg-white/95 backdrop-blur-sm border-b border-navy/5"
              : "bg-transparent border-b border-transparent"
          }
        `}
      >
        <nav className="mx-auto flex max-w-7xl items-center justify-between px-6 py-5 lg:px-10">
          {/* Logo */}
          <Link
            href="/"
            className="font-heading text-2xl font-bold tracking-tight text-navy"
          >
            Next Act
          </Link>

          {/* Desktop nav — right-aligned cluster */}
          <div className="hidden items-center gap-10 md:flex">
            <ul className="flex items-center gap-8">
              {navLinks.map((link) => (
                <li key={link.href}>
                  <Link
                    href={link.href}
                    className="text-xs font-medium uppercase tracking-widest text-charcoal transition-colors duration-200 hover:text-navy"
                  >
                    {link.label}
                  </Link>
                </li>
              ))}
            </ul>

            <div className="flex items-center gap-6">
              <Link
                href="/logga-in"
                className="text-xs font-medium uppercase tracking-widest text-charcoal transition-colors duration-200 hover:text-navy"
              >
                Logga in
              </Link>
              <Link
                href="/registrera"
                className="inline-flex items-center rounded-lg bg-navy px-4 py-2 text-xs font-semibold uppercase tracking-wide text-white transition-all duration-200 hover:-translate-y-px hover:shadow-md hover:shadow-navy/15 font-heading"
              >
                Kom ig&aring;ng
              </Link>
            </div>
          </div>

          {/* Mobile menu button — two-line hamburger */}
          <button
            type="button"
            onClick={() => setMenuOpen((prev) => !prev)}
            className="relative flex h-8 w-8 flex-col items-center justify-center gap-[7px] md:hidden"
            aria-label={menuOpen ? "Stäng meny" : "Öppna meny"}
            aria-expanded={menuOpen}
          >
            <span
              className={`block h-[1.5px] w-5 bg-navy transition-all duration-300 ease-out ${
                menuOpen ? "translate-y-[4.25px] rotate-45" : ""
              }`}
            />
            <span
              className={`block h-[1.5px] w-5 bg-navy transition-all duration-300 ease-out ${
                menuOpen ? "-translate-y-[4.25px] -rotate-45" : ""
              }`}
            />
          </button>
        </nav>
      </header>

      {/* Mobile full-screen menu */}
      <div
        className={`
          fixed inset-0 z-40 bg-white
          transition-opacity duration-300 ease-out
          md:hidden
          ${menuOpen ? "opacity-100 pointer-events-auto" : "opacity-0 pointer-events-none"}
        `}
        aria-hidden={!menuOpen}
      >
        <div className="flex h-full flex-col justify-between px-6 pb-12 pt-24">
          <nav>
            <ul className="flex flex-col gap-6">
              {navLinks.map((link) => (
                <li key={link.href}>
                  <Link
                    href={link.href}
                    onClick={closeMenu}
                    className="block font-heading text-3xl font-bold tracking-tight text-navy transition-colors hover:text-charcoal"
                  >
                    {link.label}
                  </Link>
                </li>
              ))}
            </ul>
          </nav>

          <div className="flex flex-col gap-4">
            <Link
              href="/registrera"
              onClick={closeMenu}
              className="block rounded-lg bg-navy px-6 py-3.5 text-center text-sm font-semibold uppercase tracking-wide text-white transition-all duration-200 hover:shadow-md hover:shadow-navy/15 font-heading"
            >
              Kom ig&aring;ng
            </Link>
            <Link
              href="/logga-in"
              onClick={closeMenu}
              className="block text-center text-sm font-medium text-charcoal transition-colors hover:text-navy"
            >
              Logga in
            </Link>
          </div>
        </div>
      </div>
    </>
  );
}
