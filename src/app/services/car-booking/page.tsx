import Navbar from '@/components/Navbar';
import Footer from '@/components/Footer';
import SectionHeader from '@/components/SectionHeader';
import { carTypes } from '@/lib/services';
import { generatePageMetadata } from '@/lib/seo';
import Link from 'next/link';

export const metadata = generatePageMetadata("Car Rental in Gwalior – Luxury Cars, Self-Drive, Chauffeur | Planet&Travel","Best car rental in Gwalior. Sedans, SUVs, tempo travellers. Local & outstation. Book now.","/services/car-booking");

export default function CarBookingPage() {
  const wa = "https://wa.me/916261031710?text=Hello%20Planet%26Travel!%20I%20need%20a%20car%20rental%20in%20Gwalior.";
  return (
    <>
      <Navbar />
      <main>
        {/* Hero */}
        <section className="hero-background hero-fallback-bg" style={{minHeight:'70vh'}}>
          <video autoPlay muted loop playsInline poster="/assets/car-rental/sedan.png">
            <source src="/assets/hero/car-rental-hero.webm" type="video/webm" />
            <source src="/assets/hero/car-rental-hero.mp4" type="video/mp4" />
          </video>
          <div className="hero-overlay" />
          <div className="hero-content" style={{minHeight:'70vh'}}>
            <div className="max-w-4xl px-4">
              <h1 className="text-4xl md:text-6xl font-heading font-bold mb-4"><span className="text-backdrop"><span className="text-gradient">Car Booking in Gwalior</span></span></h1>
              <p className="text-cream-100/60 text-lg"><span className="text-backdrop">From local errands to outstation trips – luxury cars, SUVs, tempo travellers.</span></p>
              <div className="flex gap-4 justify-center mt-6">
                <a href={wa} target="_blank" className="bg-green-600 text-white font-bold px-8 py-4 rounded-xl">Book via WhatsApp</a>
                <Link href="/concierge" className="border border-gold-400/30 text-gold-400 px-8 py-4 rounded-xl">Contact Concierge</Link>
              </div>
            </div>
          </div>
        </section>

        {/* Fleet */}
        <section className="py-20 bg-navy-950">
          <div className="max-w-7xl mx-auto px-4">
            <SectionHeader title="Our Fleet" />
            <div className="grid sm:grid-cols-2 lg:grid-cols-4 gap-6">
              {carTypes.map((car,i)=>(
                <div key={i} className="glass rounded-2xl overflow-hidden border border-gold-400/10 hover:border-gold-400/30 transition-all group">
                  <div className="h-48 overflow-hidden"><img src={car.img} alt={car.name} className="w-full h-full object-cover group-hover:scale-110 transition-transform" loading="lazy" /></div>
                  <div className="p-5"><h4 className="text-lg font-heading text-gold-400 mb-1">{car.name}</h4><p className="text-cream-100/50 text-sm">{car.desc}</p></div>
                </div>
              ))}
            </div>
          </div>
        </section>

        {/* Packages */}
        <section className="py-20 bg-navy-900/30">
          <div className="max-w-7xl mx-auto px-4">
            <SectionHeader title="Popular Packages" />
            <div className="grid sm:grid-cols-2 lg:grid-cols-3 gap-6">
              {[{ title:"Local City Ride", desc:"4 hours / 40km", img:"/assets/car-rental/local-city-ride.png" },{ title:"Outstation Trip", desc:"300km per day", img:"/assets/car-rental/outstation-trip.png" },{ title:"Airport Transfer", desc:"One‑way or round trip", img:"/assets/car-rental/airport-transfer.png" }].map((p,i)=>(
                <div key={i} className="glass rounded-2xl overflow-hidden border border-gold-400/10 hover:border-gold-400/30 transition-all">
                  <div className="h-40 overflow-hidden"><img src={p.img} alt={p.title} className="w-full h-full object-cover group-hover:scale-110 transition-transform" loading="lazy" /></div>
                  <div className="p-5"><h4 className="text-xl font-heading text-gold-400 mb-1">{p.title}</h4><p className="text-cream-100/50 text-sm">{p.desc}</p></div>
                </div>
              ))}
            </div>
          </div>
        </section>

        {/* CTA */}
        <section className="py-20 bg-gradient-to-br from-navy-900 to-navy-950 text-center">
          <div className="max-w-4xl mx-auto px-4">
            <SectionHeader title="Ready to Book?" />
            <a href={wa} target="_blank" className="bg-green-600 text-white font-bold px-10 py-4 rounded-xl text-lg">Chat on WhatsApp</a>
          </div>
        </section>
      </main>
      <Footer />
    </>
  );
}
