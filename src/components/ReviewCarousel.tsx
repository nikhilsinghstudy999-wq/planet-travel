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
