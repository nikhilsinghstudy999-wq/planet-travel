export default function WhyUsCard({ title, description }: { title:string; description:string }) {
  return (
    <div className="glass-light rounded-xl p-6 text-center border border-gold-400/10 hover:border-gold-400/30 transition-all">
      <h4 className="text-gold-400 font-heading text-lg mb-2">{title}</h4>
      <p className="text-cream-100/50 text-sm">{description}</p>
    </div>
  );
}
