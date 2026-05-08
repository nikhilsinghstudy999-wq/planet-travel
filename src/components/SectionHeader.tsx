export default function SectionHeader({ title, subtitle }: { title: string; subtitle?: string }) {
  return (
    <div className="text-center mb-12">
      <h2 className="text-3xl md:text-5xl font-heading text-gradient mb-4">{title}</h2>
      {subtitle && <p className="text-cream-100/60 text-lg max-w-2xl mx-auto">{subtitle}</p>}
      <div className="w-24 h-1 bg-gradient-to-r from-transparent via-gold-400 to-transparent mx-auto mt-4" />
    </div>
  );
}
