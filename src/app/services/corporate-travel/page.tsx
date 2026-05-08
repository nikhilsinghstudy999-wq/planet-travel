import Navbar from '@/components/Navbar';
import Footer from '@/components/Footer';
import ServicePageSections from '@/components/ServicePageSections';
import { generatePageMetadata } from '@/lib/seo';

export const metadata = generatePageMetadata(
  "Corporate Travel — Luxury Travel Service | Planet&Travel",
  "Experience the finest Corporate Travel with Planet&Travel since 2000.",
  "/services/corporate-travel"
);

export default function Page() {
  return (
    <>
      <Navbar />
      <main className="pt-20">
        <ServicePageSections
          title="Corporate Travel"
          description="Discover luxury Corporate Travel — curated by Planet&Travel."
          icon="M12 2C8.13 2 5 5.13 5 9c0 5.25 7 13 7 13s7-7.75 7-13c0-3.87-3.13-7-7-7zm0 9.5c-1.38 0-2.5-1.12-2.5-2.5s1.12-2.5 2.5-2.5 2.5 1.12 2.5 2.5-1.12 2.5-2.5 2.5z"
          whatsappMessage="Hello Planet&Travel! I am interested in Corporate Travel."
        />
      </main>
      <Footer />
    </>
  );
}
