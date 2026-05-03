import { Link, Outlet } from 'react-router-dom';
import { nav } from '../data/mock';

export const Shell = () => (
  <div className='min-h-screen bg-gradient-to-b from-slate-950 via-slate-900 to-slate-950'>
    <header className='sticky top-0 z-20 border-b border-slate-800/70 bg-slate-950/80 backdrop-blur'>
      <div className='mx-auto flex max-w-7xl items-center justify-between p-4'>
        <Link to='/' className='text-xl font-bold text-blue-400'>Lead.AI</Link>
        <nav className='hidden gap-5 text-sm md:flex'>{nav.map(([to,label]) => <Link key={to} to={to} className='text-slate-300 hover:text-white'>{label}</Link>)}</nav>
      </div>
    </header>
    <main className='mx-auto max-w-7xl p-6'><Outlet/></main>
    <footer className='border-t border-slate-800 p-6 text-center text-sm text-slate-400'>© 2026 Lead.AI — Revenue Automation Platform</footer>
  </div>
);
