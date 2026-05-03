import { hfAssets, pricing } from '../data/mock';

export const Marketplace=()=> <Section t='AI Marketplace / Explore Models' d='Browse deploy-ready AI products and vertical agents for growth, support, automation, and risk intelligence.' />;
export const ProductDetails=()=> <Section t='Product Details' d='Detailed capabilities, integrations, SLAs, usage limits, and trust/safety details for each AI product.' />;
export const Billing=()=> <Section t='Billing' d='Manage invoices, payment methods, subscriptions, and billing status.' />;
export const Orders=()=> <Section t='Orders' d='Track purchases, provisioning state, and recent order activity.' />;
export const Usage=()=> <Section t='Usage Analytics' d='Monitor AI consumption, token trends, conversations, and conversion outcomes.' />;
export const Settings=()=> <Section t='Settings' d='Configure profile, team members, API keys, integrations, and workspace security.' />;
export const CustomAI=()=> <Section t='Custom AI Solutions' d='Enterprise AI architecture, workflow automation, model tuning, and trustworthy AI review engagements.' />;
export const Admin=()=> <Section t='Admin Panel' d='Tenant controls, user administration, model approvals, and operational monitoring.' />;
export const Labs=()=> <div className='space-y-4'><Section t='Lead.AI Labs / Research' d='Trustworthy AI, explainable ML, predictive analytics, fraud detection, customer intelligence, and AI automation systems.' /><div className='grid gap-4 md:grid-cols-2'>{hfAssets.map(a=><a key={a.url} href={a.url} className='glass rounded-xl p-4 hover:border-blue-400' target='_blank'>{a.title}</a>)}</div></div>;
export const HFAssets=()=> <div className='grid gap-4 md:grid-cols-2'>{hfAssets.map(a=><a key={a.url} href={a.url} className='glass rounded-xl p-4' target='_blank'>{a.title}</a>)}</div>;
export const Pricing=()=> <div className='grid gap-4 md:grid-cols-3'>{pricing.map(p=><div key={p.name} className='glass rounded-2xl p-5'><h3 className='text-xl font-semibold'>{p.name}</h3><p className='my-3 text-3xl font-bold'>{p.price}</p><ul className='space-y-1 text-slate-300'>{p.features.map(f=><li key={f}>• {f}</li>)}</ul></div>)}</div>;
export const Dashboard=()=> <div className='grid gap-4 md:grid-cols-4'>{['Active AI tools: 8','Monthly conversations: 4,280','Leads captured: 612','Conversion rate: 16.8%','AI usage: 72%','Billing status: Active','Recent orders: 14','Model/demo access: 6'].map(v=><div key={v} className='glass rounded-xl p-4'>{v}</div>)}</div>;

const Section=({t,d}:{t:string;d:string})=><section className='glass rounded-2xl p-6'><h1 className='text-3xl font-bold'>{t}</h1><p className='mt-2 text-slate-300'>{d}</p></section>;
