import { Link, useParams } from 'react-router-dom';
import { hfAssets, pricing, products } from '../data/mock';

export const Marketplace = () => (
  <div className='space-y-6'>
    <Section t='AI Marketplace / Explore Models' d='Production-grade AI agents and tools for lead capture, automation, support, and risk intelligence.' />
    <div className='grid gap-4 md:grid-cols-3'>
      {products.map((p) => (
        <div key={p.id} className='glass rounded-2xl p-5'>
          <p className='text-xs text-blue-300'>{p.category}</p>
          <h3 className='mt-1 text-xl font-semibold'>{p.name}</h3>
          <p className='mt-2 text-slate-300'>{p.summary}</p>
          <div className='mt-4 flex items-center justify-between'><span>{p.price}</span><span className='text-sm text-emerald-300'>{p.status}</span></div>
          <Link to={`/product/${p.id}`} className='mt-4 inline-block rounded-lg bg-blue-500 px-4 py-2'>View Details</Link>
        </div>
      ))}
    </div>
  </div>
);

export const ProductDetails = () => {
  const { id } = useParams();
  const product = products.find((p) => p.id === id) ?? products[0];
  return <Section t={product.name} d={`${product.summary} Includes security-focused deployment controls, analytics instrumentation, and enterprise support readiness.`} />;
};

export const Pricing = () => <div className='grid gap-4 md:grid-cols-3'>{pricing.map((p) => <div key={p.name} className='glass rounded-2xl p-5'><h3 className='text-xl font-semibold'>{p.name}</h3><p className='my-3 text-3xl font-bold'>{p.price}</p><ul className='space-y-1 text-slate-300'>{p.features.map((f) => <li key={f}>• {f}</li>)}</ul><button className='mt-4 rounded-lg bg-blue-500 px-4 py-2'>{p.cta}</button></div>)}</div>;

export const Dashboard = () => <div className='grid gap-4 md:grid-cols-4'>{['MRR: $48,700', 'New signups: 128', 'Churn rate: 2.1%', 'Active users: 3,942', 'Leads generated: 2,406', 'Demo bookings: 74', 'Conversion rate: 16.8%'].map((v) => <div key={v} className='glass rounded-xl p-4'>{v}</div>)}</div>;

export const Billing = () => <Section t='Billing' d='Current plan: Growth. Next invoice: $99 on June 1, 2026. Payment method: Visa •••• 4242. Auto-renew: Enabled.' />;
export const Orders = () => <Section t='Orders' d='Recent orders include WhatsApp AI Bot provisioning, model access approvals, and analytics add-on activation.' />;
export const Usage = () => <Section t='Usage Analytics' d='Monitor conversation volume, lead qualification rate, channel conversion, and model-level utilization by workspace.' />;
export const Settings = () => <Section t='Settings' d='Manage organization profile, workspace members, API tokens, channel integrations, and security controls.' />;
export const CustomAI = () => <Section t='Custom AI Solutions' d='Lead.AI provides bespoke agent orchestration, workflow automation, and trustworthy AI reviews for enterprise teams.' />;
export const Admin = () => <Section t='Admin Panel' d='Tenant-level controls for user management, billing overrides, model governance, and uptime monitoring.' />;

export const Labs = () => <div className='space-y-4'><Section t='Lead.AI Labs / Research' d='We focus on trustworthy AI, explainable machine learning, predictive analytics, fraud detection, customer intelligence, and AI automation systems.' /><div className='grid gap-4 md:grid-cols-2'>{hfAssets.map((a) => <a key={a.url} href={a.url} className='glass rounded-xl p-4 hover:border-blue-400' target='_blank' rel='noreferrer'>{a.title}</a>)}</div></div>;
export const HFAssets = () => <div className='space-y-4'><Section t='Hugging Face AI Assets' d='Explore Lead.AI public artifacts, demos, datasets, and model assets.' /><div className='grid gap-4 md:grid-cols-2'>{hfAssets.map((a) => <a key={a.url} href={a.url} className='glass rounded-xl p-4' target='_blank' rel='noreferrer'>{a.title}</a>)}</div></div>;

const Section = ({ t, d }: { t: string; d: string }) => <section className='glass rounded-2xl p-6'><h1 className='text-3xl font-bold'>{t}</h1><p className='mt-2 text-slate-300'>{d}</p></section>;
