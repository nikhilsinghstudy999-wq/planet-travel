import Navbar from '@/components/Navbar';
import Footer from '@/components/Footer';
import SectionHeader from '@/components/SectionHeader';
import { generatePageMetadata } from '@/lib/seo';
import Link from 'next/link';
export const metadata = generatePageMetadata("Train Tracker — Golden Rail Conductor | Planet&Travel","Track Indian trains in real‑time. Search & book confirmed tickets.","/train");
export default function Page() {
  return (
    <>
      <Navbar />
      <main className="pt-20">
        <section className="hero-background hero-fallback-bg" style={{minHeight:'60vh'}}>
          <div className="hero-overlay" />
          <div className="hero-content" style={{minHeight:'60vh'}}>
            <div className="max-w-4xl px-4">
              <h1 className="text-4xl md:text-6xl font-heading text-gradient mb-4">Golden Rail Conductor</h1>
              <p className="text-cream-100/60 text-lg mb-6">Real‑time Indian Railways tracking. Accurate, free, and beautiful.</p>
              <Link href="/services/confirm-ticket" className="bg-gold-400 text-navy-950 font-bold px-10 py-4 rounded-xl text-lg">Search & Book Trains</Link>
            </div>
          </div>
        </section>
      </main>
      <Footer />
    </>
  );
}
