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
