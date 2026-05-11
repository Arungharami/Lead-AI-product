import { Navigate, Route, Routes } from 'react-router-dom';
import { Shell } from './layouts/Shell';
import { Landing } from './pages/Landing';
import { Admin, Billing, CustomAI, Dashboard, HFAssets, Labs, Marketplace, Orders, Pricing, ProductDetails, Settings, Usage } from './pages/GenericPages';

export const App = () => (
  <Routes>
    <Route element={<Shell/>}>
      <Route path='/' element={<Landing/>}/>
      <Route path='/marketplace' element={<Marketplace/>}/>
      <Route path='/product/:id' element={<ProductDetails/>}/>
      <Route path='/pricing' element={<Pricing/>}/>
      <Route path='/dashboard' element={<Dashboard/>}/>
      <Route path='/billing' element={<Billing/>}/>
      <Route path='/orders' element={<Orders/>}/>
      <Route path='/usage' element={<Usage/>}/>
      <Route path='/settings' element={<Settings/>}/>
      <Route path='/custom-ai' element={<CustomAI/>}/>
      <Route path='/labs' element={<Labs/>}/>
      <Route path='/hf-assets' element={<HFAssets/>}/>
      <Route path='/admin' element={<Admin/>}/>
      <Route path='*' element={<Navigate to='/' replace/>}/>
    </Route>
  </Routes>
);
