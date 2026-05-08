import { Metadata } from "next";
export function generatePageMetadata(title:string, description:string, path:string): Metadata {
  const url = `https://planet-travel.vercel.app${path}`;
  return {
    title, description,
    alternates: { canonical: url },
    openGraph: { title, description, url, siteName: "Planet&Travel", locale: "en_IN", type: "website" },
    twitter: { card: "summary_large_image", title, description },
    robots: { index: true, follow: true },
  };
}
