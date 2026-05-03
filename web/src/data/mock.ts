export type NavItem = { to: string; label: string };
export type Product = { id: string; name: string; category: string; summary: string; price: string; status: string };
export type PricePlan = { name: string; price: string; features: string[]; cta: string };

export const nav: NavItem[] = [
  { to: '/', label: 'Landing' },
  { to: '/marketplace', label: 'AI Marketplace' },
  { to: '/pricing', label: 'Pricing' },
  { to: '/dashboard', label: 'Dashboard' },
  { to: '/labs', label: 'Lead.AI Labs' },
  { to: '/admin', label: 'Admin' },
];

export const badges = ['Website AI Chatbots', 'WhatsApp AI Bots', 'Lead Qualification', 'Fraud Detection XAI', 'Customer Intelligence'];
export const categories = ['Website AI Chatbot', 'WhatsApp AI Bot', 'Instagram AI Assistant', 'Lead Qualification Agent', 'Booking Assistant', 'Customer Support AI', 'Knowledge Base AI', 'Document Q&A Assistant', 'Fraud Detection XAI', 'Customer Behavior Predictor', 'Enterprise AI Solutions'];

export const products: Product[] = [
  { id: 'website-chatbot', name: 'Website AI Chatbot', category: 'Engagement', summary: 'Captures, qualifies, and routes leads from website traffic in real time.', price: '$29/mo', status: 'Active' },
  { id: 'whatsapp-bot', name: 'WhatsApp AI Bot', category: 'Messaging', summary: 'Automates inbound WhatsApp conversations with conversion-first workflows.', price: '$99/mo', status: 'Popular' },
  { id: 'fraud-detection-xai', name: 'Fraud Detection XAI', category: 'Risk & Trust', summary: 'Explainable fraud predictions for fintech and high-risk transaction pipelines.', price: 'Custom', status: 'Enterprise' },
];

export const pricing: PricePlan[] = [
  { name: 'Starter', price: '$29/month', features: ['1 AI chatbot', '500 conversations/month', 'Basic lead capture', 'Email support'], cta: 'Start Starter' },
  { name: 'Growth', price: '$99/month', features: ['3 AI agents', '5,000 conversations/month', 'WhatsApp integration', 'Lead scoring', 'Analytics dashboard'], cta: 'Start Growth' },
  { name: 'Enterprise', price: 'Custom', features: ['Unlimited AI agents', 'Custom workflows', 'API access', 'Dedicated support', 'Trustworthy AI review'], cta: 'Book Enterprise Call' },
];

export const hfAssets = [
  { title: 'lead-ai-labs/fraud-detection-xai', url: 'https://huggingface.co/lead-ai-labs/fraud-detection-xai' },
  { title: 'lead-ai-labs/fraud-detection-sample-data', url: 'https://huggingface.co/datasets/lead-ai-labs/fraud-detection-sample-data' },
  { title: 'arun-gharami profile', url: 'https://huggingface.co/arun-gharami' },
  { title: 'lead-ai-labs organization', url: 'https://huggingface.co/lead-ai-labs' },
  { title: 'Lead.AI main website', url: 'https://www.lead-ai.us' },
];
