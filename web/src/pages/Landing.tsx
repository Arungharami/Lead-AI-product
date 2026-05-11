import { badges, categories } from '../data/mock';
import { Link } from 'react-router-dom';

export const Landing = () => (
  <div className='space-y-10'>
    <section className='glass rounded-3xl p-10'>
      <h1 className='text-4xl font-bold md:text-6xl'>Turn Visitors Into Customers With AI Automation</h1>
      <p className='mt-4 max-w-3xl text-lg text-slate-300'>Lead.AI helps businesses capture leads, qualify prospects, automate conversations, and deploy trustworthy AI agents across websites, WhatsApp, Instagram, and business workflows.</p>
      <div className='mt-6 flex flex-wrap gap-4'>
        <Link to='/pricing' className='rounded-xl bg-blue-500 px-5 py-3 font-semibold'>Start Free</Link>
        <Link to='/marketplace' className='rounded-xl border border-slate-600 px-5 py-3'>Explore AI Tools</Link>
      </div>
      <div className='mt-8 flex flex-wrap gap-3'>{badges.map((b) => <span key={b} className='rounded-full border border-blue-400/40 bg-blue-500/10 px-3 py-1 text-sm'>{b}</span>)}</div>
    </section>

    <section>
      <h2 className='mb-4 text-2xl font-semibold'>Core Product Categories</h2>
      <div className='grid gap-4 sm:grid-cols-2 lg:grid-cols-3'>{categories.map((c) => <div key={c} className='glass rounded-2xl p-4'>{c}</div>)}</div>
    </section>

    <section className='grid gap-4 md:grid-cols-3'>
      <Link to='/labs' className='glass rounded-2xl p-5'>Lead.AI Labs research and trustworthy AI roadmap</Link>
      <Link to='/hf-assets' className='glass rounded-2xl p-5'>Hugging Face model and dataset assets</Link>
      <a href='https://www.lead-ai.us' className='glass rounded-2xl p-5' target='_blank' rel='noreferrer'>Connect with primary domain: lead-ai.us</a>
    </section>
  </div>
);
