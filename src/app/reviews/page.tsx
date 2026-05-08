import Navbar from '@/components/Navbar';
import Footer from '@/components/Footer';
import ReviewCarousel from '@/components/ReviewCarousel';
import ReviewForm from '@/components/ReviewForm';
import SectionHeader from '@/components/SectionHeader';
import { generatePageMetadata } from '@/lib/seo';
export const metadata = generatePageMetadata("Reviews — Real Traveller Experiences | Planet&Travel","50,000+ happy travellers. Share your experience.","/reviews");
export default function Page() {
  return (
    <>
      <Navbar />
      <main className="pt-20">
        <section className="py-20 bg-navy-950">
          <div className="max-w-7xl mx-auto px-4"><SectionHeader title="Traveller Stories" /><ReviewCarousel /></div>
        </section>
        <section className="py-16 bg-navy-900/30">
          <div className="max-w-3xl mx-auto px-4"><SectionHeader title="Share Your Experience" /><ReviewForm /></div>
        </section>
      </main>
      <Footer />
    </>
  );
}
