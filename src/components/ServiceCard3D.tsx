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
