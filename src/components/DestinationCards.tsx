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
