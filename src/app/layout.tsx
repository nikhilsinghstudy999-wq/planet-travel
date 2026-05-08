import type { Metadata } from "next";
import "./globals.css";
export const metadata: Metadata = {
  title: { default: "Planet&Travel — Luxury Travel Curator", template: "%s | Planet&Travel" },
  description: "Bespoke luxury journeys across India since 2000.",
};
export default function RootLayout({ children }: { children: React.ReactNode }) {
  return <html lang="en"><body className="bg-navy-950 text-cream-100 antialiased">{children}</body></html>;
}
