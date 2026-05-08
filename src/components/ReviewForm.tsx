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
