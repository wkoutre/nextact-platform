"use client";

import { forwardRef, type ButtonHTMLAttributes } from "react";

type ButtonVariant = "primary" | "secondary" | "ghost";
type ButtonSize = "sm" | "md" | "lg";

interface ButtonProps extends ButtonHTMLAttributes<HTMLButtonElement> {
  variant?: ButtonVariant;
  size?: ButtonSize;
}

const variantStyles: Record<ButtonVariant, string> = {
  primary: [
    "bg-navy text-white",
    "hover:-translate-y-px hover:shadow-md hover:shadow-navy/15",
    "active:translate-y-0 active:shadow-sm",
  ].join(" "),
  secondary: [
    "border border-navy/20 text-navy bg-transparent",
    "hover:bg-navy hover:text-white hover:border-navy",
    "active:bg-navy/90",
  ].join(" "),
  ghost: [
    "text-navy bg-transparent",
    "hover:underline hover:underline-offset-4 hover:decoration-1",
    "active:text-navy/70",
  ].join(" "),
};

const sizeStyles: Record<ButtonSize, string> = {
  sm: "px-4 py-1.5 text-xs rounded-lg",
  md: "px-5 py-2.5 text-sm rounded-lg",
  lg: "px-7 py-3 text-sm rounded-lg",
};

const Button = forwardRef<HTMLButtonElement, ButtonProps>(
  (
    {
      variant = "primary",
      size = "md",
      className = "",
      disabled,
      children,
      ...props
    },
    ref
  ) => {
    return (
      <button
        ref={ref}
        disabled={disabled}
        className={`
          inline-flex items-center justify-center
          font-heading font-semibold tracking-wide uppercase
          transition-all duration-200 ease-out cursor-pointer
          focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-navy
          disabled:opacity-40 disabled:pointer-events-none
          ${variantStyles[variant]}
          ${sizeStyles[size]}
          ${className}
        `}
        {...props}
      >
        {children}
      </button>
    );
  }
);

Button.displayName = "Button";

export { Button };
export type { ButtonProps, ButtonVariant, ButtonSize };
