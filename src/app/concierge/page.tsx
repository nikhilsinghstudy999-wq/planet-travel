import Navbar from '@/components/Navbar';
import Footer from '@/components/Footer';
import ConciergeForm from '@/components/ConciergeForm';
import { generatePageMetadata } from '@/lib/seo';
export const metadata = generatePageMetadata("Contact Your Travel Architect | Planet&Travel","Reach Planet&Travel's luxury concierge. Platform 1, Gwalior Railway Station.","/concierge");
export default function Page() {
  return (
    <>
      <Navbar />
      <main className="pt-20">
        <section className="hero-background hero-fallback-bg" style={{minHeight:'60vh'}}>
          <div className="hero-overlay" />
          <div className="hero-content" style={{minHeight:'60vh'}}>
            <div className="max-w-xl px-4 w-full">
              <h1 className="text-4xl font-heading text-gradient mb-4">Your Personal Travel Architect</h1>
              <p className="text-cream-100/60 mb-6">Tell us your dream journey.</p>
              <ConciergeForm />
            </div>
          </div>
        </section>
      </main>
      <Footer />
    </>
  );
}
