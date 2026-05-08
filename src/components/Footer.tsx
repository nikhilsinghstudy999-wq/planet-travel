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
