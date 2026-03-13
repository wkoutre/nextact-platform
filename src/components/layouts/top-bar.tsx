"use client";

import Link from "next/link";
import { useState } from "react";
import { usePathname } from "next/navigation";

const NAV_ITEMS = [
  { href: "/learn", label: "Resa" },
  { href: "/profile", label: "Profil" },
];

interface TopBarProps {
  userName?: string | null;
}

export function TopBar({ userName }: TopBarProps) {
  const [menuOpen, setMenuOpen] = useState(false);
  const pathname = usePathname();

  return (
    <header className="fixed inset-x-0 top-0 z-40 border-b border-gray-200 bg-white">
      <div className="flex h-14 items-center justify-between px-4">
        {/* Left: hamburger */}
        <button
          type="button"
          onClick={() => setMenuOpen((prev) => !prev)}
          aria-label="Öppna meny"
          aria-expanded={menuOpen}
          className="flex h-9 w-9 items-center justify-center rounded-md text-gray-600 transition-colors hover:bg-gray-100"
        >
          <svg
            className="h-5 w-5"
            fill="none"
            viewBox="0 0 24 24"
            stroke="currentColor"
            strokeWidth={2}
          >
            {menuOpen ? (
              <path
                strokeLinecap="round"
                strokeLinejoin="round"
                d="M6 18 18 6M6 6l12 12"
              />
            ) : (
              <path
                strokeLinecap="round"
                strokeLinejoin="round"
                d="M3.75 6.75h16.5M3.75 12h16.5m-16.5 5.25h16.5"
              />
            )}
          </svg>
        </button>

        {/* Center: logo / brand */}
        <Link
          href="/learn"
          className="font-heading text-base font-bold text-navy"
        >
          Next Act
        </Link>

        {/* Right: profile link */}
        <Link
          href="/profile"
          aria-label="Profil"
          className="flex h-9 w-9 items-center justify-center rounded-full bg-primary/10 text-sm font-semibold text-primary transition-colors hover:bg-primary/20"
        >
          {userName ? userName[0].toUpperCase() : "?"}
        </Link>
      </div>

      {/* Dropdown menu */}
      {menuOpen && (
        <div className="border-t border-gray-100 bg-white shadow-lg">
          <nav aria-label="Huvudnavigering">
            {NAV_ITEMS.map((item) => {
              const isActive =
                pathname === item.href || pathname.startsWith(item.href + "/");
              return (
                <Link
                  key={item.href}
                  href={item.href}
                  onClick={() => setMenuOpen(false)}
                  aria-current={isActive ? "page" : undefined}
                  className={`flex items-center px-4 py-3 text-sm font-medium transition-colors ${
                    isActive
                      ? "bg-primary/5 text-primary"
                      : "text-gray-700 hover:bg-gray-50"
                  }`}
                >
                  {item.label}
                </Link>
              );
            })}
            {userName && (
              <div className="border-t border-gray-100 px-4 py-3 text-xs text-gray-400">
                Inloggad som {userName}
              </div>
            )}
          </nav>
        </div>
      )}
    </header>
  );
}
