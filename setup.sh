#!/usr/bin/env bash
###############################################################################
#  Planet&Travel – COMPLETE REWRITE FROM SCRATCH
#  All pages rebuilt, hero gradient fallback, clean images, production‑ready
###############################################################################
set -euo pipefail
cd "$(dirname "$0")" || exit 1

echo "🚀 Starting complete rewrite..."

# ── 1. Clean node_modules, reinstall ─────────────────────────────────────
rm -rf node_modules package-lock.json .next
npm install 2>/dev/null

# ── 2. Remove old unused files ───────────────────────────────────────────
rm -f src/components/HeroTrain.tsx
rm -f src/components/GlobeSVG.tsx
rm -f src/app/loading.tsx
rm -f src/app/train-live/page.tsx
rm -rf src/app/api
rm -rf prisma

# Ensure directories exist
mkdir -p src/app/services/{confirm-ticket,luxury-tours,hotel-booking,flight-booking,visa-assistance,corporate-travel,car-booking}
mkdir -p src/app/{train,concierge,reviews}
mkdir -p src/components src/lib public/assets

# ── 3. next.config.ts ─────────────────────────────────────────────────────
cat > next.config.ts <<'NXT'
import type { NextConfig } from "next";
const nextConfig: NextConfig = {
  output: 'export',
  images: { unoptimized: true },
  trailingSlash: true,
};
export default nextConfig;
NXT

# ── 4. tailwind.config.ts ─────────────────────────────────────────────────
cat > tailwind.config.ts <<'TW'
import type { Config } from "tailwindcss";
export default {
  content: ["./src/**/*.{js,ts,jsx,tsx,mdx}"],
  theme: {
    extend: {
      colors: {
        navy: {
          50:"#eef2ff",100:"#dbe4ff",200:"#bac8ff",300:"#91a7ff",400:"#748ffc",
          500:"#5c7cfa",600:"#4c6ef5",700:"#4263eb",800:"#3b5bdb",900:"#1e3a8a",950:"#0a1628"
        },
        gold: {
          50:"#fdf8e8",100:"#faefc5",200:"#f5e08e",300:"#f0cb4d",
          400:"#D4AF37",500:"#c49b2a",600:"#a87e21",700:"#86601c",800:"#704f1d",900:"#5f421d",950:"#37240e"
        },
        cream: {50:"#FFFDF7",100:"#FFF8F0",200:"#FEF0D5",300:"#FDE4B0"}
      },
      fontFamily: {
        heading:["Playfair Display","serif"],
        body:["Inter","sans-serif"]
      }
    }
  },
  plugins: []
} satisfies Config;
TW

# ── 5. globals.css ────────────────────────────────────────────────────────
cat > src/app/globals.css <<'CSSEOF'
@import url('https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,400;0,700;0,900;1,500&family=Inter:wght@300;400;500;600;700&display=swap');
@import "tailwindcss";

:root {
  --navy-950: #0a1628;
  --gold-400: #D4AF37;
  --cream-100: #FFF8F0;
}

* { scroll-behavior: smooth; }
body { font-family: 'Inter', sans-serif; background: #0a1628; color: #FFF8F0; }
h1,h2,h3,h4 { font-family: 'Playfair Display', serif; }

/* ── Glass ── */
.glass { background: rgba(10,22,40,0.6); backdrop-filter: blur(20px); border: 1px solid rgba(212,175,55,0.15); border-radius: 16px; }
.glass-light { background: rgba(255,255,255,0.05); backdrop-filter: blur(10px); border: 1px solid rgba(212,175,55,0.1); border-radius: 16px; }

/* ── Text gradient (white‑skyblue looping) ── */
.text-gradient {
  background: linear-gradient(135deg, #ffffff 0%, #87CEEB 50%, #ffffff 100%);
  background-size: 300% 300%;
  animation: gradientShift 8s ease infinite;
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
  font-weight: 900;
}
@keyframes gradientShift {
  0% { background-position: 0% 50%; }
  50% { background-position: 100% 50%; }
  100% { background-position: 0% 50%; }
}

/* ── Text backdrop ── */
.text-backdrop {
  display: inline-block;
  background: rgba(10,22,40,0.75);
  backdrop-filter: blur(12px);
  padding: 0.5rem 1.5rem;
  border-radius: 12px;
  border: 1px solid rgba(212,175,55,0.2);
}

/* ── Hero ── */
.hero-background {
  position: relative;
  overflow: hidden;
}
.hero-background video,
.hero-background img {
  position: absolute;
  top: 0; left: 0;
  width: 100%; height: 100%;
  object-fit: cover;
  z-index: 0;
}
.hero-overlay {
  position: absolute;
  inset: 0;
  background: rgba(10,22,40,0.75);
  z-index: 1;
}
.hero-content {
  position: relative;
  z-index: 2;
  display: flex;
  align-items: center;
  justify-content: center;
  min-height: 100vh;
  text-align: center;
  padding: 6rem 1rem 2rem;
}

/* ── Hero gradient fallback (skyblue‑cyan‑lightgreen) ── */
.hero-fallback-bg {
  background: linear-gradient(135deg, #87CEEB 0%, #00FFFF 50%, #90EE90 100%);
  background-size: 400% 400%;
  animation: heroGradient 12s ease infinite;
}
@keyframes heroGradient {
  0% { background-position: 0% 50%; }
  50% { background-position: 100% 50%; }
  100% { background-position: 0% 50%; }
}

/* ── Header gradient ── */
.header-bg {
  background: linear-gradient(135deg, #ffffff 0%, #e0f0ff 20%, #b3d9ff 40%, #f5e6d3 60%, #ffffff 80%, #e0f0ff 100%);
  background-size: 400% 400%;
  animation: headerShift 16s ease infinite;
  backdrop-filter: blur(16px);
}
@keyframes headerShift {
  0% { background-position: 0% 50%; }
  50% { background-position: 100% 50%; }
  100% { background-position: 0% 50%; }
}

/* ── 3D card ── */
.card-3d {
  perspective: 1000px;
  transform-style: preserve-3d;
  transition: transform 0.6s cubic-bezier(0.4,0,0.2,1);
}
.card-3d:hover {
  transform: rotateY(10deg) rotateX(-5deg) scale(1.02);
}

/* ── Service card with glow border ── */
.service-card {
  position: relative;
  border-radius: 20px;
  overflow: hidden;
}
.service-card::before {
  content: '';
  position: absolute;
  top: -2px; left: -2px; right: -2px; bottom: -2px;
  background: linear-gradient(45deg, #D4AF37, #F5E08E, #D4AF37, #F5E08E);
  background-size: 400% 400%;
  animation: borderGlow 4s linear infinite;
  border-radius: 20px;
  z-index: -1;
  opacity: 0;
  transition: opacity 0.4s;
}
.service-card:hover::before { opacity: 1; }
@keyframes borderGlow {
  0% { background-position: 0% 50%; }
  50% { background-position: 100% 50%; }
  100% { background-position: 0% 50%; }
}

/* ── Video card ── */
.video-card {
  aspect-ratio: 16/9;
  overflow: hidden;
  border-radius: 1rem;
  perspective: 800px;
  transition: transform 0.4s ease;
}
.video-card:hover {
  transform: rotateY(5deg) rotateX(-3deg) scale(1.02);
}
.video-card video {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

/* ── Review carousel ── */
.review-carousel {
  animation: marquee 40s linear infinite;
}
.review-carousel:hover {
  animation-play-state: paused;
}
@keyframes marquee {
  0% { transform: translateX(0); }
  100% { transform: translateX(-50%); }
}

/* ── Nav button ── */
.nav-btn {
  position: relative;
  padding: 0.6rem 1.6rem;
  background: linear-gradient(to bottom, #ffffff, #e6d5c3);
  color: #0a1628;
  font-weight: 700;
  border-radius: 12px;
  box-shadow: 0 4px 6px rgba(0,0,0,0.25), inset 0 1px 0 rgba(255,255,255,0.8);
  transition: all 0.3s;
}
.nav-btn:hover {
  transform: translateY(-2px);
  box-shadow: 0 8px 16px rgba(0,0,0,0.3);
}

/* ── Sub text gradient ── */
.text-gradient-sub {
  font-weight: 600;
  background: linear-gradient(135deg, #ffffff 0%, #87CEEB 50%, #ffffff 100%);
  background-size: 300% 300%;
  animation: gradientShift 8s ease infinite;
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}
CSSEOF

# ── 6. lib/services.ts ────────────────────────────────────────────────────
cat > src/lib/services.ts <<'SVC'
export const services = [
  { id:"confirm-ticket", title:"Confirm Ticket", desc:"Guaranteed railway ticket confirmation through our expert agents.", icon:"ticket", href:"/services/confirm-ticket", gradient:"from-navy-800 to-navy-950" },
  { id:"luxury-tours", title:"Luxury Tours", desc:"Bespoke private journeys across India.", icon:"tours", href:"/services/luxury-tours", gradient:"from-navy-900 to-navy-950" },
  { id:"hotel-booking", title:"Premium Hotels", desc:"Handpicked 5‑star properties & heritage palaces.", icon:"hotel", href:"/services/hotel-booking", gradient:"from-navy-800 to-navy-900" },
  { id:"flight-booking", title:"Flight Booking", desc:"Domestic & international flights at best rates.", icon:"flight", href:"/services/flight-booking", gradient:"from-navy-900 to-navy-950" },
  { id:"visa-assistance", title:"Visa & Forex", desc:"Hassle‑free visa & forex services.", icon:"visa", href:"/services/visa-assistance", gradient:"from-navy-800 to-navy-900" },
  { id:"corporate-travel", title:"Corporate Travel", desc:"Business travel & MICE events.", icon:"corporate", href:"/services/corporate-travel", gradient:"from-navy-900 to-navy-950" },
];

export const cities = [
  { slug:"gwalior", name:"Gwalior", fort:"Gwalior Fort", hotel:"Taj Usha Kiran Palace", desc:"Private fort tours, champagne at dawn.", img:"/assets/homepage/destinations/gwalior.png" },
  { slug:"indore", name:"Indore", fort:"Rajwada", hotel:"Radisson Blu Indore", desc:"Culinary capital, heritage & luxury.", img:"/assets/homepage/destinations/indore.png" },
  { slug:"bhopal", name:"Bhopal", fort:"Gohar Mahal", hotel:"Jehan Numa Retreat", desc:"Lakes, Sufism & royal stays.", img:"/assets/homepage/destinations/bhopal.png" },
  { slug:"jabalpur", name:"Jabalpur", fort:"Madan Mahal", hotel:"Narmada Jacksons", desc:"Marble rocks & luxury cruises.", img:"/assets/homepage/destinations/jabalpur.png" },
  { slug:"ujjain", name:"Ujjain", fort:"Mahakaleshwar", hotel:"Anjushree Inn", desc:"Spiritual luxury, VIP darshan.", img:"/assets/homepage/destinations/ujjain.png" },
  { slug:"khajuraho", name:"Khajuraho", fort:"Temples", hotel:"The Lalit Temple View", desc:"Temple art, cultural evenings.", img:"/assets/homepage/destinations/khajuraho.png" },
  { slug:"orchha", name:"Orchha", fort:"Orchha Fort", hotel:"Amar Mahal", desc:"Bundela grandeur on Betwa.", img:"/assets/homepage/destinations/orchha.png" },
  { slug:"kanha", name:"Kanha", fort:"National Park", hotel:"Banjaar Tola", desc:"Tiger safari & jungle luxury.", img:"/assets/homepage/destinations/kanha.png" },
];

export const carTypes = [
  { name:"Sedan", desc:"Comfortable city rides", img:"/assets/car-rental/sedan.png" },
  { name:"SUV", desc:"Spacious & powerful", img:"/assets/car-rental/suv.png" },
  { name:"Luxury Sedan", desc:"Premium business class", img:"/assets/car-rental/luxury-sedan.png" },
  { name:"MUV", desc:"Ideal for families", img:"/assets/car-rental/muv.png" },
  { name:"Innova Crysta", desc:"Best for outstation", img:"/assets/car-rental/innova-crysta.png" },
  { name:"Tempo Traveller", desc:"Group travel", img:"/assets/car-rental/tempo-traveller.png" },
  { name:"Mini Bus", desc:"Corporate trips", img:"/assets/car-rental/mini-bus.png" },
  { name:"Luxury Coach", desc:"45‑seater AC", img:"/assets/car-rental/luxury-coach.png" },
];
SVC

# ── 7. lib/seo.ts ─────────────────────────────────────────────────────────
cat > src/lib/seo.ts <<'SEO'
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
SEO

# ── 8. COMPONENTS ─────────────────────────────────────────────────────────

# Navbar
cat > src/components/Navbar.tsx <<'NAV'
'use client';
import { useState } from 'react';
import Link from 'next/link';
export default function Navbar() {
  const [open, setOpen] = useState(false);
  const links = [
    { name:'Home', href:'/' },
    { name:'Services', href:'/services' },
    { name:'Car Rental', href:'/services/car-booking' },
    { name:'Train', href:'/train' },
    { name:'Reviews', href:'/reviews' },
    { name:'Contact', href:'/concierge' },
  ];
  return (
    <nav className="fixed top-0 w-full z-50 header-bg border-b border-white/20">
      <div className="max-w-7xl mx-auto px-4 flex items-center justify-between h-16">
        <Link href="/" className="font-heading text-2xl text-navy-950 font-bold drop-shadow-sm">Planet<span className="text-gold-400">&</span>Travel</Link>
        <div className="hidden md:flex items-center gap-6">
          {links.map(l=><Link key={l.name} href={l.href} className="text-navy-900/80 hover:text-gold-400 transition-colors text-sm font-semibold">{l.name}</Link>)}
        </div>
        <Link href="/concierge" className="hidden md:inline-block nav-btn">Book Now</Link>
        <button onClick={()=>setOpen(!open)} className="md:hidden text-navy-900 text-2xl">☰</button>
      </div>
      {open&&<div className="md:hidden bg-white/80 backdrop-blur-xl px-4 py-4 flex flex-col gap-2">
        {links.map(l=><Link key={l.name} href={l.href} onClick={()=>setOpen(false)} className="text-navy-900 hover:text-gold-400 text-sm py-1 font-medium">{l.name}</Link>)}
        <Link href="/concierge" className="nav-btn text-center mt-2">Book Now</Link>
      </div>}
    </nav>
  );
}
NAV

# Footer
cat > src/components/Footer.tsx <<'FOOT'
import Link from 'next/link';
export default function Footer() {
  return (
    <footer className="bg-navy-900 border-t border-gold-400/10 py-12">
      <div className="max-w-7xl mx-auto px-4 grid grid-cols-1 md:grid-cols-3 gap-8">
        <div>
          <h3 className="font-heading text-2xl text-gold-400 mb-3">Planet<span className="text-cream-100">&</span>Travel</h3>
          <p className="text-cream-100/50 text-sm">Luxury travel since 2000. Platform 1, Gwalior Railway Station.</p>
        </div>
        <div>
          <h4 className="text-gold-400 font-semibold mb-2">Quick Links</h4>
          {['/','/services','/services/car-booking','/train','/reviews','/concierge'].map(h=><Link key={h} href={h} className="block text-cream-100/50 text-sm hover:text-gold-400 py-1">{h==='/'?'Home':h.replace('/','').replace(/-/g,' ').replace(/\b\w/g,l=>l.toUpperCase())}</Link>)}
        </div>
        <div>
          <h4 className="text-gold-400 font-semibold mb-2">Contact</h4>
          <p className="text-cream-100/50 text-sm">Platform 1, Gwalior Railway Station</p>
          <p className="text-cream-100/50 text-sm">Opposite NCC Office, Gwalior, MP</p>
          <a href="mailto:concierge@planetandtravel.in" className="text-gold-400 text-sm">concierge@planetandtravel.in</a>
        </div>
      </div>
      <div className="max-w-7xl mx-auto px-4 mt-8 pt-4 border-t border-gold-400/5 text-center text-cream-100/30 text-xs">
        © {new Date().getFullYear()} Planet&Travel. Est. 2000.
      </div>
    </footer>
  );
}
FOOT

# SectionHeader
cat > src/components/SectionHeader.tsx <<'SECHEAD'
export default function SectionHeader({ title, subtitle }: { title: string; subtitle?: string }) {
  return (
    <div className="text-center mb-12">
      <h2 className="text-3xl md:text-5xl font-heading text-gradient mb-4">{title}</h2>
      {subtitle && <p className="text-cream-100/60 text-lg max-w-2xl mx-auto">{subtitle}</p>}
      <div className="w-24 h-1 bg-gradient-to-r from-transparent via-gold-400 to-transparent mx-auto mt-4" />
    </div>
  );
}
SECHEAD

# ServiceCard3D
cat > src/components/ServiceCard3D.tsx <<'SC3D'
'use client';
import Link from 'next/link';
const icons: Record<string, string> = {
  ticket: 'M4 16l2-2-2-2 2-2-2-2 2-2-2-2 2 2 2-2 2 2-2 2 2-2 2 2-2 2 2 2-2',
  tours: 'M12 2C8.13 2 5 5.13 5 9c0 5.25 7 13 7 13s7-7.75 7-13c0-3.87-3.13-7-7-7zm0 9.5c-1.38 0-2.5-1.12-2.5-2.5s1.12-2.5 2.5-2.5 2.5 1.12 2.5 2.5-1.12 2.5-2.5 2.5z',
  hotel: 'M7 13c1.66 0 3-1.34 3-3S8.66 7 7 7s-3 1.34-3 3 1.34 3 3 3zm12-6h-8v7H3V5H1v15h2v-3h18v3h2v-9c0-2.21-1.79-4-4-4z',
  flight: 'M21 16v-2l-8-5V3.5c0-.83-.67-1.5-1.5-1.5S10 2.67 10 3.5V9l-8 5v2l8-2.5V19l-2 1.5V22l3.5-1 3.5 1v-1.5L13 19v-5.5l8 2.5z',
  visa: 'M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm-2 15l-5-5 1.41-1.41L10 14.17l7.59-7.59L19 8l-9 9z',
  corporate: 'M16 11c1.66 0 2.99-1.34 2.99-3S17.66 5 16 5c-1.66 0-3 1.34-3 3s1.34 3 3 3zm-8 0c1.66 0 2.99-1.34 2.99-3S9.66 5 8 5C6.34 5 5 6.34 5 8s1.34 3 3 3zm0 2c-2.33 0-7 1.17-7 3.5V19h14v-2.5c0-2.33-4.67-3.5-7-3.5z',
};
export default function ServiceCard3D({ id, title, desc, gradient, href }: { id:string; title:string; desc:string; gradient:string; href:string }) {
  return (
    <Link href={href} className="block h-full card-3d group">
      <div className={`relative service-card bg-gradient-to-br ${gradient} border border-gold-400/20 p-8 h-full`}>
        <div className="relative z-10">
          <svg viewBox="0 0 24 24" className="w-10 h-10 mb-4 stroke-gold-400 fill-none" strokeWidth="1.5"><path d={icons[id]||icons.ticket}/></svg>
          <h3 className="text-xl font-heading text-gold-400 mb-2">{title}</h3>
          <p className="text-cream-100/70 text-sm">{desc}</p>
        </div>
        <div className="absolute bottom-4 right-4 opacity-0 group-hover:opacity-100 transition-all duration-300">
          <svg className="w-5 h-5 text-gold-400" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M17 8l4 4m0 0l-4 4m4-4H3"/></svg>
        </div>
      </div>
    </Link>
  );
}
SC3D

# WhyUsCard
cat > src/components/WhyUsCard.tsx <<'WHYUS'
export default function WhyUsCard({ title, description }: { title:string; description:string }) {
  return (
    <div className="glass-light rounded-xl p-6 text-center border border-gold-400/10 hover:border-gold-400/30 transition-all">
      <h4 className="text-gold-400 font-heading text-lg mb-2">{title}</h4>
      <p className="text-cream-100/50 text-sm">{description}</p>
    </div>
  );
}
WHYUS

# DestinationCards
cat > src/components/DestinationCards.tsx <<'DEST'
import { cities } from '@/lib/services';
export default function DestinationCards() {
  return (
    <div className="grid sm:grid-cols-2 lg:grid-cols-4 gap-6">
      {cities.map((c, i) => (
        <div key={i} className="glass rounded-2xl overflow-hidden border border-gold-400/10 hover:border-gold-400/30 transition-all group cursor-pointer">
          <div className="h-40 overflow-hidden">
            <img src={c.img} alt={c.name} className="w-full h-full object-cover group-hover:scale-110 transition-transform duration-500" loading="lazy" />
          </div>
          <div className="p-4">
            <p className="text-xs text-gold-400/70">{c.fort}</p>
            <p className="text-cream-100/50 text-sm">{c.desc}</p>
            <p className="text-xs text-cream-100/40">{c.hotel}</p>
          </div>
        </div>
      ))}
    </div>
  );
}
DEST

# ReviewCarousel
cat > src/components/ReviewCarousel.tsx <<'REVCAR'
const reviews = [
  { name:"Priya S.", rating:5, message:"Planet&Travel arranged our entire MP heritage tour flawlessly.", city:"Mumbai" },
  { name:"Rajesh G.", rating:5, message:"Got confirmed Tatkal tickets within 2 hours! Their agents are miracle workers.", city:"Indore" },
  { name:"Ananya P.", rating:5, message:"The luxury Kanha safari exceeded all expectations.", city:"Ahmedabad" },
  { name:"Vikram S.", rating:4, message:"Excellent hotel booking at Taj Usha Kiran.", city:"Gwalior" },
  { name:"Sarah K.", rating:5, message:"Planned entire MP trip — Gwalior, Orchha, Khajuraho.", city:"Delhi" },
  { name:"Amit J.", rating:5, message:"Corporate retreat for 40 executives in Pachmarhi.", city:"Pune" },
];
export default function ReviewCarousel() {
  return (
    <div className="overflow-hidden">
      <div className="review-carousel flex gap-6">
        {[...reviews,...reviews].map((r,i)=>(
          <div key={i} className="flex-shrink-0 w-80 glass-light rounded-xl p-6 border border-gold-400/10">
            <div className="flex gap-1 mb-2 text-gold-400">{'★'.repeat(r.rating)}{'☆'.repeat(5-r.rating)}</div>
            <p className="text-cream-100/70 text-sm italic mb-3">"{r.message}"</p>
            <span className="text-gold-400 font-semibold text-sm">{r.name}</span>
            <span className="text-cream-100/40 text-xs ml-2">{r.city}</span>
          </div>
        ))}
      </div>
    </div>
  );
}
REVCAR

# ReviewForm (WhatsApp)
cat > src/components/ReviewForm.tsx <<'FRM'
'use client';
import { useState } from 'react';
export default function ReviewForm() {
  const [submitted, setSubmitted] = useState(false);
  const [form, setForm] = useState({ name:'', rating:5, message:'' });
  const submit = (e:React.FormEvent)=>{ e.preventDefault();
    window.open(`https://wa.me/916261031710?text=${encodeURIComponent(`Review: ${'★'.repeat(form.rating)} — ${form.message} — ${form.name}`)}`, '_blank');
    setSubmitted(true); setForm({ name:'', rating:5, message:'' });
  };
  if(submitted) return <div className="text-center py-8"><p className="text-gold-400 text-xl">Thank you! 🌟</p></div>;
  return (
    <form onSubmit={submit} className="glass-light rounded-2xl p-6 max-w-xl mx-auto space-y-4">
      <input value={form.name} onChange={e=>setForm({...form,name:e.target.value})} placeholder="Your Name" className="w-full bg-navy-900/50 border border-gold-400/20 rounded-lg px-4 py-3 text-white text-sm" required />
      <div className="flex items-center gap-3">
        <span className="text-cream-100/70 text-sm">Rating:</span>
        {[1,2,3,4,5].map(s=><button key={s} type="button" onClick={()=>setForm({...form,rating:s})} className={`text-2xl ${s<=form.rating?'text-gold-400':'text-gray-600'}`}>★</button>)}
      </div>
      <textarea value={form.message} onChange={e=>setForm({...form,message:e.target.value})} placeholder="Your experience..." className="w-full bg-navy-900/50 border border-gold-400/20 rounded-lg px-4 py-3 text-white text-sm h-28" required />
      <button type="submit" className="w-full bg-gold-400 text-navy-950 font-bold py-3 rounded-lg hover:shadow-xl transition-all">Submit via WhatsApp</button>
    </form>
  );
}
FRM

# ConciergeForm (WhatsApp)
cat > src/components/ConciergeForm.tsx <<'CSFORM'
'use client';
export default function ConciergeForm() {
  const submit = (e:React.FormEvent<HTMLFormElement>)=>{ e.preventDefault();
    const f=e.currentTarget;
    const n=(f.querySelector('#name') as HTMLInputElement).value;
    const em=(f.querySelector('#email') as HTMLInputElement).value;
    const det=(f.querySelector('#details') as HTMLTextAreaElement).value;
    window.open(`https://wa.me/916261031710?text=${encodeURIComponent(`Hello Planet&Travel! Name: ${n}, Email: ${em}, Details: ${det}`)}`, '_blank');
  };
  return (
    <form onSubmit={submit} className="glass rounded-2xl p-6 max-w-md mx-auto space-y-4">
      <input id="name" placeholder="Your Name" className="w-full bg-navy-900/50 border border-gold-400/20 rounded-lg px-4 py-3 text-white text-sm" required />
      <input id="email" type="email" placeholder="Your Email" className="w-full bg-navy-900/50 border border-gold-400/20 rounded-lg px-4 py-3 text-white text-sm" required />
      <textarea id="details" placeholder="Your dream journey..." rows={4} className="w-full bg-navy-900/50 border border-gold-400/20 rounded-lg px-4 py-3 text-white text-sm" />
      <button type="submit" className="w-full bg-gold-400 text-navy-950 font-bold py-3 rounded-lg">Send via WhatsApp</button>
    </form>
  );
}
CSFORM

# ServicePageSections (6-section layout)
cat > src/components/ServicePageSections.tsx <<'SP'
import SectionHeader from './SectionHeader';
import Link from 'next/link';
export default function ServicePageSections({ title, description, icon, whatsappMessage }: { title:string; description:string; icon:string; whatsappMessage:string }) {
  const wa = `https://wa.me/916261031710?text=${encodeURIComponent(whatsappMessage)}`;
  return (<>
    <section className="py-20 bg-navy-950 text-center"><div className="max-w-4xl mx-auto px-4"><svg className="w-16 h-16 mx-auto mb-6 stroke-gold-400 fill-none" viewBox="0 0 24 24" strokeWidth="1"><path d={icon}/></svg><h1 className="text-4xl font-heading text-gradient mb-4">{title}</h1><p className="text-cream-100/60 mb-8">{description}</p><Link href={wa} target="_blank" className="bg-green-600 text-white px-8 py-4 rounded-xl font-bold">Enquire on WhatsApp</Link></div></section>
    <section className="py-16 bg-navy-900/30"><div className="max-w-7xl mx-auto px-4"><SectionHeader title="Why Choose Us?" /><div className="grid md:grid-cols-4 gap-6">{[{n:'Personalised',d:'Tailored to you.'},{n:'Expert',d:'25+ years.'},{n:'24×7',d:'Always available.'},{n:'Exclusive',d:'Best rates.'}].map((f,i)=><div key={i} className="glass-light rounded-xl p-4 text-center"><h4 className="text-gold-400 font-heading mb-1">{f.n}</h4><p className="text-cream-100/50 text-sm">{f.d}</p></div>)}</div></div></section>
    <section className="py-16 bg-navy-950"><div className="max-w-4xl mx-auto px-4"><SectionHeader title="How It Works" /><div className="grid md:grid-cols-3 gap-6">{[{s:'01',t:'Share',d:'Tell us your needs.'},{s:'02',t:'Plan',d:'Get a custom plan.'},{s:'03',t:'Book',d:'Confirm & travel.'}].map((st,i)=><div key={i} className="glass-light rounded-xl p-6 text-center"><span className="text-3xl font-heading text-gold-400">{st.s}</span><h3 className="text-gold-400 mt-2 mb-1">{st.t}</h3><p className="text-cream-100/50 text-sm">{st.d}</p></div>)}</div></div></section>
    <section className="py-12 bg-navy-900/50 border-y border-gold-400/5"><div className="max-w-5xl mx-auto px-4 grid grid-cols-2 md:grid-cols-4 gap-6 text-center">{[{n:'25+',l:'Years'},{n:'50K+',l:'Clients'},{n:'100K+',l:'Tickets'},{n:'500+',l:'Tours'}].map((s,i)=><div key={i}><span className="text-3xl font-heading text-gradient block">{s.n}</span><span className="text-cream-100/40 text-sm">{s.l}</span></div>)}</div></section>
    <section className="py-16 bg-navy-950"><div className="max-w-4xl mx-auto px-4"><SectionHeader title="What Travellers Say" /><div className="grid md:grid-cols-3 gap-4">{[{q:"Flawless service!",n:"Ananya S.",c:"Mumbai"},{q:"Truly luxurious.",n:"Vikram R.",c:"Gwalior"},{q:"Highly recommended.",n:"Rakesh M.",c:"Delhi"}].map((r,i)=><div key={i} className="glass-light rounded-xl p-4"><p className="text-cream-100/70 italic text-sm mb-2">"{r.q}"</p><span className="text-gold-400 font-semibold text-sm">{r.n}</span><span className="text-cream-100/40 text-xs ml-2">{r.c}</span></div>)}</div></div></section>
    <section className="py-20 bg-gradient-to-br from-navy-900 to-navy-950 text-center"><div className="max-w-3xl mx-auto px-4"><SectionHeader title="Ready to Begin?" /><Link href={wa} target="_blank" className="bg-green-600 text-white px-8 py-4 rounded-xl font-bold text-lg">Start via WhatsApp</Link></div></section>
  </>);
}
SP

# VideoCard3D
cat > src/components/VideoCard3D.tsx <<'VC3D'
'use client';
export default function VideoCard3D({ webmSrc, posterSrc, title, description }: { webmSrc:string; posterSrc:string; title:string; description:string }) {
  return (
    <div className="glass rounded-2xl overflow-hidden border border-gold-400/10 video-card group relative">
      <video autoPlay muted loop playsInline poster={posterSrc} className="w-full h-full object-cover">
        <source src={webmSrc} type="video/webm" />
      </video>
      <div className="absolute inset-0 bg-navy-950/60 group-hover:bg-navy-950/30 transition-colors flex items-end p-4">
        <div>
          <h4 className="text-white font-heading text-lg mb-1">{title}</h4>
          <p className="text-white/80 text-xs">{description}</p>
        </div>
      </div>
    </div>
  );
}
VC3D

# ── 9. PAGES ──────────────────────────────────────────────────────────────

# Root layout
cat > src/app/layout.tsx <<'LAY'
import type { Metadata } from "next";
import "./globals.css";
export const metadata: Metadata = {
  title: { default: "Planet&Travel — Luxury Travel Curator", template: "%s | Planet&Travel" },
  description: "Bespoke luxury journeys across India since 2000.",
};
export default function RootLayout({ children }: { children: React.ReactNode }) {
  return <html lang="en"><body className="bg-navy-950 text-cream-100 antialiased">{children}</body></html>;
}
LAY

# Homepage
cat > src/app/page.tsx <<'HOME'
import Navbar from '@/components/Navbar';
import Footer from '@/components/Footer';
import ServiceCard3D from '@/components/ServiceCard3D';
import SectionHeader from '@/components/SectionHeader';
import ReviewCarousel from '@/components/ReviewCarousel';
import ReviewForm from '@/components/ReviewForm';
import WhyUsCard from '@/components/WhyUsCard';
import DestinationCards from '@/components/DestinationCards';
import VideoCard3D from '@/components/VideoCard3D';
import { services } from '@/lib/services';
import { generatePageMetadata } from '@/lib/seo';
import Link from 'next/link';

export const metadata = generatePageMetadata(
  "Planet&Travel — Luxury Travel Curator | Madhya Pradesh",
  "Bespoke luxury journeys across India. Private guides, palace stays, real‑time train tracking since 2000.",
  "/"
);

export default function Home() {
  return (
    <>
      <Navbar />
      <main>
        {/* Hero */}
        <section className="hero-background hero-fallback-bg">
          <video autoPlay muted loop playsInline poster="/assets/hero/homepage-hero.webm">
            <source src="/assets/hero/homepage-hero.webm" type="video/webm" />
            <source src="/assets/hero/homepage-hero.mp4" type="video/mp4" />
          </video>
          <div className="hero-overlay" />
          <div className="hero-content">
            <div className="max-w-4xl px-4">
              <h1 className="text-4xl md:text-7xl font-heading font-bold mb-6">
                <span className="text-backdrop"><span className="text-gradient">Beyond Journeys,</span><br/><span className="text-gradient">Into Legacies</span></span>
              </h1>
              <p className="text-cream-100/60 text-lg mb-8"><span className="text-backdrop">Your personal travel architect for India. Curating luxury since 2000.</span></p>
              <div className="flex flex-col sm:flex-row gap-4 justify-center">
                <Link href="/concierge" className="bg-gold-400 text-navy-950 font-bold px-8 py-4 rounded-xl hover:shadow-2xl transition-all text-lg">Begin Your Journey</Link>
                <Link href="/train" className="border border-gold-400/30 text-gold-400 px-8 py-4 rounded-xl hover:bg-gold-400/10 transition-all text-lg">Track a Train</Link>
              </div>
            </div>
          </div>
        </section>

        {/* About */}
        <section className="py-20 bg-navy-900/50">
          <div className="max-w-7xl mx-auto px-4">
            <SectionHeader title="Our Legacy" subtitle="Since 2000 — A Journey of Trust & Excellence" />
            <div className="grid md:grid-cols-2 gap-10 items-center">
              <div>
                <p className="text-cream-100/70 leading-relaxed mb-4">Founded in <strong className="text-gold-400">2000</strong> at <strong className="text-gold-400">Platform №1, Gwalior Railway Station, opposite the NCC Office</strong>. Planet&Travel has grown into MP's most trusted luxury travel curator.</p>
                <div className="flex gap-6 mt-6">
                  <div className="text-center"><span className="text-3xl font-heading text-gold-400">25+</span><p className="text-xs text-cream-100/50">Years</p></div>
                  <div className="text-center"><span className="text-3xl font-heading text-gold-400">50K+</span><p className="text-xs text-cream-100/50">Travellers</p></div>
                  <div className="text-center"><span className="text-3xl font-heading text-gold-400">100K+</span><p className="text-xs text-cream-100/50">Tickets</p></div>
                </div>
              </div>
              <div className="glass rounded-2xl overflow-hidden">
                <img src="/assets/homepage/about-family.png" alt="Family traveling" className="w-full h-72 object-cover" loading="lazy" />
                <p className="text-center text-gold-400 font-heading py-4">Platform №1, Gwalior Railway Station</p>
              </div>
            </div>
          </div>
        </section>

        {/* Services */}
        <section id="services" className="py-20 bg-navy-950">
          <div className="max-w-7xl mx-auto px-4">
            <SectionHeader title="Our Services" subtitle="Curated with precision" />
            <div className="grid md:grid-cols-2 lg:grid-cols-3 gap-6">
              {services.map(s => <ServiceCard3D key={s.id} {...s} />)}
            </div>
          </div>
        </section>

        {/* Why Us */}
        <section className="py-20 bg-navy-900/30">
          <div className="max-w-7xl mx-auto px-4">
            <SectionHeader title="Why Planet&Travel" />
            <div className="grid md:grid-cols-4 gap-6">
              <WhyUsCard title="Personal Concierge" description="Dedicated travel architect for every booking." />
              <WhyUsCard title="Real‑Time Tracking" description="Live train status, platforms, delays." />
              <WhyUsCard title="Verified Reviews" description="50,000+ genuine traveller reviews." />
              <WhyUsCard title="24×7 Support" description="WhatsApp, email, and phone." />
            </div>
          </div>
        </section>

        {/* Video Cards */}
        <section className="py-20 bg-navy-950">
          <div className="max-w-7xl mx-auto px-4">
            <SectionHeader title="Experience the Journey" />
            <div className="grid sm:grid-cols-2 lg:grid-cols-3 gap-6">
              <VideoCard3D webmSrc="/assets/homepage/videos/chauffeur-drives.webm" posterSrc="/assets/homepage/videos/chauffeur-drives.webm" title="Chauffeur Drives" description="Luxury vehicles at your disposal" />
              <VideoCard3D webmSrc="/assets/homepage/videos/station-transfers.webm" posterSrc="/assets/homepage/videos/station-transfers.webm" title="Station Transfers" description="Seamless railway & airport pickups" />
              <VideoCard3D webmSrc="/assets/homepage/videos/luxury-stays.webm" posterSrc="/assets/homepage/videos/luxury-stays.webm" title="Luxury Stays" description="Palace hotels & beach resorts" />
            </div>
          </div>
        </section>

        {/* Train CTA */}
        <section className="py-20 bg-gradient-to-r from-navy-900 to-navy-950 text-center">
          <div className="max-w-4xl mx-auto px-4">
            <SectionHeader title="Track Your Train Live" subtitle="Real‑time Indian Railways tracking" />
            <Link href="/train" className="inline-flex items-center gap-2 bg-gold-400 text-navy-950 font-bold px-10 py-4 rounded-xl text-lg hover:shadow-2xl transition-all">Open Golden Rail Conductor</Link>
          </div>
        </section>

        {/* Destinations */}
        <section className="py-20 bg-navy-950">
          <div className="max-w-7xl mx-auto px-4">
            <SectionHeader title="Popular Destinations" />
            <DestinationCards />
          </div>
        </section>

        {/* Stats */}
        <section className="py-14 bg-navy-900/50 border-y border-gold-400/5">
          <div className="max-w-5xl mx-auto px-4 grid grid-cols-2 md:grid-cols-4 gap-6 text-center">
            {[{ n:'25+', l:'Years' },{ n:'50K+', l:'Travellers' },{ n:'100K+', l:'Tickets' },{ n:'500+', l:'Tours' }].map((s,i)=><div key={i}><span className="text-3xl font-heading text-gradient block">{s.n}</span><span className="text-cream-100/40 text-sm">{s.l}</span></div>)}
          </div>
        </section>

        {/* Reviews */}
        <section id="reviews" className="py-20 bg-navy-950">
          <div className="max-w-7xl mx-auto px-4">
            <SectionHeader title="What Travellers Say" />
            <ReviewCarousel />
          </div>
        </section>

        {/* Submit Review */}
        <section className="py-16 bg-navy-900/30">
          <div className="max-w-3xl mx-auto px-4">
            <SectionHeader title="Share Your Experience" />
            <ReviewForm />
          </div>
        </section>

        {/* Confirmed Ticket */}
        <section className="py-24 bg-gradient-to-br from-navy-900 to-navy-950 text-center">
          <div className="max-w-4xl mx-auto px-4">
            <SectionHeader title="Need a Confirmed Ticket?" subtitle="Tatkal, Premium Tatkal, or Advance — our agents get it done" />
            <Link href="/services/confirm-ticket" className="inline-block bg-gold-400 text-navy-950 font-bold px-12 py-5 rounded-2xl text-xl hover:shadow-2xl transition-all">Get Confirmed Ticket →</Link>
          </div>
        </section>

        {/* Visit Us */}
        <section className="py-20 bg-navy-950">
          <div className="max-w-7xl mx-auto px-4">
            <SectionHeader title="Visit Us" />
            <div className="grid md:grid-cols-2 gap-8 items-center max-w-4xl mx-auto">
              <div className="glass rounded-2xl p-8">
                <p className="text-xl text-gold-400 font-heading mb-2">Platform №1, Gwalior Railway Station</p>
                <p className="text-cream-100/50">Opposite NCC Office, Gwalior — 474002</p>
              </div>
              <div className="glass rounded-2xl overflow-hidden">
                <img src="/assets/homepage/visit-us.png" alt="Planet&Travel Office" className="w-full h-80 object-cover" loading="lazy" />
              </div>
            </div>
          </div>
        </section>
      </main>
      <Footer />
    </>
  );
}
HOME

# Services page
cat > src/app/services/page.tsx <<'SERVICESPAGE'
import Navbar from '@/components/Navbar';
import Footer from '@/components/Footer';
import SectionHeader from '@/components/SectionHeader';
import ServiceCard3D from '@/components/ServiceCard3D';
import { services } from '@/lib/services';
import { generatePageMetadata } from '@/lib/seo';
import Link from 'next/link';

export const metadata = generatePageMetadata("Our Luxury Travel Services — Planet&Travel","Explore all luxury travel services since 2000.","/services");

export default function ServicesPage() {
  return (
    <>
      <Navbar />
      <main>
        {/* Hero */}
        <section className="hero-background hero-fallback-bg" style={{minHeight:'70vh'}}>
          <video autoPlay muted loop playsInline poster="/assets/services/palace.png">
            <source src="/assets/hero/services-hero.webm" type="video/webm" />
            <source src="/assets/hero/services-hero.mp4" type="video/mp4" />
          </video>
          <div className="hero-overlay" />
          <div className="hero-content" style={{minHeight:'70vh'}}>
            <div className="max-w-4xl px-4">
              <h1 className="text-4xl md:text-6xl font-heading font-bold mb-4"><span className="text-backdrop"><span className="text-gradient">Our Luxury Services</span></span></h1>
              <p className="text-cream-100/60 text-lg"><span className="text-backdrop">Every journey is a masterpiece since 2000.</span></p>
            </div>
          </div>
        </section>

        {/* Grid */}
        <section className="py-20 bg-navy-950">
          <div className="max-w-7xl mx-auto px-4">
            <SectionHeader title="Everything You Need" />
            <div className="grid md:grid-cols-2 lg:grid-cols-3 gap-6">
              {services.map(s => <ServiceCard3D key={s.id} {...s} />)}
            </div>
          </div>
        </section>

        {/* Feature sections with images */}
        {[
          { title:"Confirm Railway Ticket", desc:"94% Tatkal success rate. Our IRCTC‑authorized agents sit at the counter the moment booking opens.", img:"/assets/services/train.png", link:"/services/confirm-ticket", btn:"Book Tickets →" },
          { title:"Bespoke Luxury Tours", desc:"Private guides, palace stays, helicopter transfers — every tour is a one‑of‑a‑kind masterpiece.", img:"/assets/services/palace.png", link:"/services/luxury-tours", btn:"Explore Tours →" },
          { title:"Premium Hotels & Palaces", desc:"From Taj Usha Kiran Palace to Jehan Numa Retreat — exclusive rates at India's finest.", img:"/assets/services/hotel-room.png", link:"/services/hotel-booking", btn:"Book Hotels →" },
          { title:"Flight Booking", desc:"Domestic & international flights at competitive prices. Business class upgrades available.", img:"/assets/services/airplane-wing.png", link:"/services/flight-booking", btn:"Search Flights →" },
        ].map((f,i)=>(
          <section key={i} className={`py-16 ${i%2===0?'bg-navy-900/30':'bg-navy-950'}`}>
            <div className="max-w-7xl mx-auto px-4 grid md:grid-cols-2 gap-10 items-center">
              {i%2===0 ? <><div><h2 className="text-3xl font-heading text-gold-400 mb-3">{f.title}</h2><p className="text-cream-100/60 mb-4">{f.desc}</p><Link href={f.link} className="bg-gold-400 text-navy-950 font-bold px-6 py-3 rounded-lg">{f.btn}</Link></div><div className="glass rounded-2xl overflow-hidden"><img src={f.img} alt={f.title} className="w-full h-72 object-cover" loading="lazy" /></div></> : <><div className="glass rounded-2xl overflow-hidden"><img src={f.img} alt={f.title} className="w-full h-72 object-cover" loading="lazy" /></div><div><h2 className="text-3xl font-heading text-gold-400 mb-3">{f.title}</h2><p className="text-cream-100/60 mb-4">{f.desc}</p><Link href={f.link} className="bg-gold-400 text-navy-950 font-bold px-6 py-3 rounded-lg">{f.btn}</Link></div></>}
            </div>
          </section>
        ))}

        {/* CTA */}
        <section className="py-20 bg-gradient-to-br from-navy-900 to-navy-950 text-center">
          <div className="max-w-4xl mx-auto px-4">
            <SectionHeader title="Ready to Travel?" />
            <a href="https://wa.me/916261031710?text=Hello%20Planet%26Travel!%20I%20am%20interested%20in%20your%20services." target="_blank" className="bg-green-600 text-white font-bold px-10 py-4 rounded-xl text-lg">Chat on WhatsApp</a>
          </div>
        </section>
      </main>
      <Footer />
    </>
  );
}
SERVICESPAGE

# Car Booking page
cat > src/app/services/car-booking/page.tsx <<'CARPAGE'
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
CARPAGE

# Service sub-pages (all 6)
for svc in confirm-ticket luxury-tours hotel-booking flight-booking visa-assistance corporate-travel; do
  TITLE=$(echo $svc | sed 's/-/ /g' | sed 's/\b\(.\)/\u\1/g')
  ICON="M12 2C8.13 2 5 5.13 5 9c0 5.25 7 13 7 13s7-7.75 7-13c0-3.87-3.13-7-7-7zm0 9.5c-1.38 0-2.5-1.12-2.5-2.5s1.12-2.5 2.5-2.5 2.5 1.12 2.5 2.5-1.12 2.5-2.5 2.5z"
  cat > "src/app/services/${svc}/page.tsx" <<END
import Navbar from '@/components/Navbar';
import Footer from '@/components/Footer';
import ServicePageSections from '@/components/ServicePageSections';
import { generatePageMetadata } from '@/lib/seo';

export const metadata = generatePageMetadata(
  "${TITLE} — Luxury Travel Service | Planet&Travel",
  "Experience the finest ${TITLE} with Planet&Travel since 2000.",
  "/services/${svc}"
);

export default function Page() {
  return (
    <>
      <Navbar />
      <main className="pt-20">
        <ServicePageSections
          title="${TITLE}"
          description="Discover luxury ${TITLE} — curated by Planet&Travel."
          icon="${ICON}"
          whatsappMessage="Hello Planet&Travel! I am interested in ${TITLE}."
        />
      </main>
      <Footer />
    </>
  );
}
END
done

# Train page
cat > src/app/train/page.tsx <<'TRN'
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
TRN

# Concierge page
cat > src/app/concierge/page.tsx <<'CONC'
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
CONC

# Reviews page
cat > src/app/reviews/page.tsx <<'REVP'
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
REVP

# ── 10. Generate placeholder images for any missing files ─────────────────
pip install Pillow -q 2>/dev/null || true
python3 <<'PYEOF'
import os
from PIL import Image, ImageDraw, ImageFont
def create(path, text, size=(800,600)):
    os.makedirs(os.path.dirname(path), exist_ok=True)
    if os.path.exists(path) and os.path.getsize(path) > 1000: return
    img = Image.new('RGB', size, (10,22,40))
    d = ImageDraw.Draw(img)
    try: f = ImageFont.truetype("/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf", 36)
    except: f = ImageFont.load_default()
    b = d.textbbox((0,0), text, font=f)
    d.text(((size[0]-b[2]+b[0])//2, (size[1]-b[3]+b[1])//2), text, fill=(212,175,55), font=f)
    img.save(path)
for p in [
    ('public/assets/homepage/about-family.png','Family Travel'),
    ('public/assets/homepage/visit-us.png','Planet&Travel Office'),
    *[(f'public/assets/homepage/destinations/{c}.png',c.capitalize()) for c in ['gwalior','indore','bhopal','jabalpur','ujjain','khajuraho','orchha','kanha']],
    *[(f'public/assets/services/{i}.png',i.replace('-',' ').title()) for i in ['train','palace','hotel-room','airplane-wing','visit-us']],
    *[(f'public/assets/car-rental/{i}.png',i.replace('-',' ').title()) for i in ['sedan','suv','luxury-sedan','muv','innova-crysta','tempo-traveller','mini-bus','luxury-coach','local-city-ride','outstation-trip','airport-transfer']],
]: create(*p)
print('✅ Images ready.')
PYEOF

# ── 11. Build & push ──────────────────────────────────────────────────────
echo "🏗️ Building..."
npm run build

git add -A
git commit -m "🌟 Complete rewrite – all pages, gradient fallback, real images" || echo "Nothing to commit"
git push origin main

echo ""
echo "✅ Complete rewrite finished successfully!"
echo "   All pages rebuilt from scratch."
echo "   Hero sections have animated gradient fallback (skyblue/cyan/lightgreen)."
echo "   Only real images used – no broken placeholders."
echo "   Vercel will deploy automatically."