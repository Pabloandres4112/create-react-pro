@echo off
REM ================================================
REM   SCRIPT 06: GENERACIÓN DE ARCHIVOS
REM   Crea package.json, tsconfig, vite, tailwind, etc
REM ================================================

setlocal enabledelayedexpansion
chcp 65001 >nul

REM ===== package.json =====
echo ├─ package.json

(
echo {
echo   "name": "!PROJECT_NAME!",
echo   "private": true,
echo   "version": "0.0.1",
echo   "type": "module",
echo   "description": "!PROJECT_DESC!",
echo   "author": "!AUTHOR_NAME!",
echo   "scripts": {
echo     "dev": "vite",
echo     "build": "tsc && vite build",
echo     "preview": "vite preview",
echo     "lint": "eslint . --ext ts,tsx --report-unused-disable-directives --max-warnings 0",
echo     "type-check": "tsc --noEmit"
echo   },
echo   "dependencies": {
echo     "react": "^18.2.0",
echo     "react-dom": "^18.2.0"
echo   },
echo   "devDependencies": {
echo     "@types/react": "^18.2.0",
echo     "@types/react-dom": "^18.2.0",
echo     "@vitejs/plugin-react": "^4.0.0",
echo     "autoprefixer": "^10.4.0",
echo     "postcss": "^8.4.0",
echo     "tailwindcss": "^3.4.0",
echo     "typescript": "^5.0.0",
echo     "vite": "^5.0.0"
echo   }
echo }
) > package.json

REM ===== tsconfig.json =====
echo ├─ tsconfig.json

(
echo {
echo   "compilerOptions": {
echo     "target": "ES2020",
echo     "useDefineForClassFields": true,
echo     "lib": ["ES2020", "DOM", "DOM.Iterable"],
echo     "module": "ESNext",
echo     "skipLibCheck": true,
echo     "esModuleInterop": true,
echo     "allowSyntheticDefaultImports": true,
echo     "strict": true,
echo     "noUnusedLocals": true,
echo     "noUnusedParameters": true,
echo     "noFallthroughCasesInSwitch": true,
echo     "jsx": "react-jsx",
echo     "resolveJsonModule": true,
echo     "moduleResolution": "bundler"
echo   },
echo   "include": ["src"],
echo   "references": [{ "path": "./tsconfig.node.json" }]
echo }
) > tsconfig.json

REM ===== tsconfig.node.json =====
echo ├─ tsconfig.node.json

(
echo {
echo   "compilerOptions": {
echo     "composite": true,
echo     "skipLibCheck": true,
echo     "module": "ESNext",
echo     "moduleResolution": "bundler",
echo     "allowSyntheticDefaultImports": true
echo   },
echo   "include": ["vite.config.ts"]
echo }
) > tsconfig.node.json

REM ===== vite.config.ts =====
echo ├─ vite.config.ts

(
echo import { defineConfig } from 'vite'
echo import react from '@vitejs/plugin-react'
echo.
echo export default defineConfig^({
echo   plugins: [react^(^)],
echo   server: {
echo     port: 5173,
echo     open: true
echo   }
echo }^)
) > vite.config.ts

REM ===== tailwind.config.js =====
echo ├─ tailwind.config.js

(
echo export default {
echo   content: [
echo     "./index.html",
echo     "./src/**/*.{js,ts,jsx,tsx}"
echo   ],
echo   theme: {
echo     extend: {}
echo   },
echo   plugins: []
echo }
) > tailwind.config.js

REM ===== postcss.config.js =====
echo ├─ postcss.config.js

(
echo export default {
echo   plugins: {
echo     tailwindcss: {},
echo     autoprefixer: {}
echo   }
echo }
) > postcss.config.js

REM ===== .gitignore =====
echo ├─ .gitignore

(
echo node_modules/
echo dist/
echo .env
echo .env.local
echo .env.*.local
echo *.log
echo .DS_Store
echo .vscode/
echo .idea/
) > .gitignore

REM ===== index.html =====
echo ├─ index.html

(
echo ^<!DOCTYPE html^>
echo ^<html lang="es"^>
echo   ^<head^>
echo     ^<meta charset="UTF-8" /^>
echo     ^<meta name="viewport" content="width=device-width, initial-scale=1.0" /^>
echo     ^<title^>!PROJECT_NAME!^</title^>
echo   ^</head^>
echo   ^<body^>
echo     ^<div id="root"^>^</div^>
echo     ^<script type="module" src="/src/main.tsx"^>^</script^>
echo   ^</body^>
echo ^</html^>
) > index.html

REM ===== src/main.tsx =====
echo ├─ src/main.tsx

(
echo import React from 'react'
echo import ReactDOM from 'react-dom/client'
echo import App from './App'
echo import './styles/globals.css'
echo.
echo ReactDOM.createRoot^(document.getElementById^('root'^)!^).render^(
echo   ^<React.StrictMode^>
echo     ^<App /^>
echo   ^</React.StrictMode^>
echo ^)
) > src\main.tsx

REM ===== src/App.tsx =====
echo ├─ src/App.tsx

REM Generar App.tsx según el tipo de plantilla
if /i "!TEMPLATE_TYPE!"=="landing" (
  call :generate_landing_app
) else if /i "!TEMPLATE_TYPE!"=="ecommerce" (
  call :generate_ecommerce_app
) else if /i "!TEMPLATE_TYPE!"=="dashboard" (
  call :generate_dashboard_app
) else (
  call :generate_default_app
)

REM ===== src/App.css =====
echo ├─ src/App.css

(
echo /* App Styles */
echo @import 'tailwindcss/base';
echo @import 'tailwindcss/components';
echo @import 'tailwindcss/utilities';
echo.
echo body {
echo   margin: 0;
echo   padding: 0;
echo   font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto,
echo     Oxygen, Ubuntu, Cantarell, 'Fira Sans', 'Droid Sans', 'Helvetica Neue',
echo     sans-serif;
echo   -webkit-font-smoothing: antialiased;
echo   -moz-osx-font-smoothing: grayscale;
echo }
) > src\App.css

REM ===== src/styles/globals.css =====
echo ├─ src/styles/globals.css

(
echo @tailwind base;
echo @tailwind components;
echo @tailwind utilities;
echo.
echo * {
echo   margin: 0;
echo   padding: 0;
echo   box-sizing: border-box;
echo }
) > src\styles\globals.css

REM ===== README.md =====
echo ├─ README.md

(
echo # !PROJECT_NAME!
echo.
echo ## Descripción
echo !PROJECT_DESC!
echo.
echo ## Autor
echo !AUTHOR_NAME!
echo.
echo ## Tecnologías
echo - React 18
echo - TypeScript 5
echo - Vite 5
echo - Tailwind CSS 3
echo.
echo ## Scripts disponibles
echo.
echo ### Desarrollo
echo ```bash
echo npm run dev
echo ```
echo Inicia el servidor de desarrollo en http://localhost:5173
echo.
echo ### Build
echo ```bash
echo npm run build
echo ```
echo Compila el proyecto para producción
echo.
echo ### Preview
echo ```bash
echo npm run preview
echo ```
echo Visualiza el build de producción localmente
echo.
echo ## Estructura del proyecto
echo.
echo ```
echo src/
echo ├── components/      Componentes React reutilizables
echo ├── pages/           Páginas de la aplicación
echo ├── assets/          Imágenes, fuentes e iconos
echo ├── hooks/           Custom React hooks
echo ├── contexts/        Context API
echo ├── services/        Servicios y APIs
echo ├── utils/           Funciones utilitarias
echo ├── types/           TypeScript types e interfaces
echo ├── styles/          Estilos CSS y Tailwind
echo ├── App.tsx          Componente raíz
echo └── main.tsx         Punto de entrada
echo ```
echo.
echo ## Instalación de dependencias
echo.
echo El proyecto ya incluye todas las dependencias necesarias instaladas.
echo Si necesitas instalar más dependencias, usa:
echo.
echo ```bash
echo npm install [nombre-paquete]
echo ```
) > README.md

REM ===== .vscode/extensions.json =====
echo ├─ .vscode/extensions.json

(
echo {
echo   "recommendations": [
echo     "ES7+React/Redux/React-Native snippets",
echo     "bradlc.vscode-tailwindcss",
echo     "dsznajder.es7-react-js-snippets"
echo   ]
echo }
) > .vscode\extensions.json

REM ===== Generar componentes según la plantilla =====
if /i "!TEMPLATE_TYPE!"=="landing" (
  call :create_landing_components
) else if /i "!TEMPLATE_TYPE!"=="ecommerce" (
  call :create_ecommerce_components
) else if /i "!TEMPLATE_TYPE!"=="dashboard" (
  call :create_dashboard_components
)

echo.
echo  Archivos de configuración generados
echo.

exit /b 0

REM =========================================
REM   FUNCIONES DE GENERACIÓN DE APP.TSX
REM =========================================

:generate_landing_app
(
echo import './App.css'
echo import Hero from './components/Hero'
echo import Features from './components/Features'
echo import CTA from './components/CTA'
echo.
echo function App^(^) {
echo   return ^(
echo     ^<div className="min-h-screen"^>
echo       ^<Hero /^>
echo       ^<Features /^>
echo       ^<CTA /^>
echo     ^</div^>
echo   ^)
echo }
echo.
echo export default App
) > src\App.tsx
goto :eof

:generate_ecommerce_app
(
echo import { useState } from 'react'
echo import './App.css'
echo import Header from './components/Header'
echo import ProductGrid from './components/ProductGrid'
echo import Cart from './features/Cart'
echo import type { Product } from './types'
echo.
echo function App^(^) {
echo   const [cartItems, setCartItems] = useState^<Product[]^>^([^]^)
echo.
echo   const addToCart = ^(product: Product^) =^> {
echo     setCartItems^([...cartItems, product]^)
echo   }
echo.
echo   return ^(
echo     ^<div className="min-h-screen bg-gray-50"^>
echo       ^<Header cartCount={cartItems.length} /^>
echo       ^<ProductGrid onAddToCart={addToCart} /^>
echo       ^<Cart items={cartItems} /^>
echo     ^</div^>
echo   ^)
echo }
echo.
echo export default App
) > src\App.tsx
goto :eof

:generate_dashboard_app
(
echo import './App.css'
echo import Sidebar from './components/Sidebar'
echo import DataTable from './components/DataTable'
echo import Analytics from './components/Analytics'
echo.
echo function App^(^) {
echo   return ^(
echo     ^<div className="flex min-h-screen bg-gray-100"^>
echo       ^<Sidebar /^>
echo       ^<main className="flex-1 p-6"^>
echo         ^<h1 className="text-3xl font-bold mb-6"^>Dashboard^</h1^>
echo         ^<Analytics /^>
echo         ^<DataTable /^>
echo       ^</main^>
echo     ^</div^>
echo   ^)
echo }
echo.
echo export default App
) > src\App.tsx
goto :eof

:generate_default_app
(
echo import './App.css'
echo.
echo function App^(^) {
echo   return ^(
echo     ^<div className="min-h-screen bg-gradient-to-br from-blue-600 to-purple-600"^>
echo       ^<main className="max-w-6xl mx-auto px-4 py-16"^>
echo         ^<h1 className="text-5xl font-bold text-white mb-4"^>
echo           ¡Bienvenido a !PROJECT_NAME!
echo         ^</h1^>
echo         ^<p className="text-xl text-white/90 mb-8"^>
echo           !PROJECT_DESC!
echo         ^</p^>
echo         ^<div className="bg-white/10 backdrop-blur-lg rounded-lg p-6 text-white"^>
echo           ^<p className="text-lg"^>Proyecto generado con React, TypeScript y Tailwind CSS ^</p^>
echo         ^</div^>
echo       ^</main^>
echo     ^</div^>
echo   ^)
echo }
echo.
echo export default App
) > src\App.tsx
goto :eof

REM =========================================
REM   COMPONENTES: LANDING PAGE
REM =========================================

:create_landing_components
echo ├─ src/components/Hero.tsx
(
echo import React from 'react'
echo.
echo interface HeroProps {
echo   title?: string
echo   subtitle?: string
echo }
echo.
echo const Hero: React.FC^<HeroProps^> = ^({ 
echo   title = '!PROJECT_NAME!',
echo   subtitle = '!PROJECT_DESC!'
echo }^) =^> {
echo   return ^(
echo     ^<section className="min-h-screen bg-gradient-to-br from-indigo-600 via-purple-600 to-pink-500 flex items-center justify-center"^>
echo       ^<div className="container mx-auto px-4 py-16 text-center"^>
echo         ^<h1 className="text-6xl md:text-7xl font-bold text-white mb-6 animate-fade-in"^>
echo           {title}
echo         ^</h1^>
echo         ^<p className="text-xl md:text-2xl text-white/90 mb-8 max-w-3xl mx-auto"^>
echo           {subtitle}
echo         ^</p^>
echo         ^<button className="bg-white text-purple-600 px-8 py-4 rounded-full font-semibold text-lg hover:bg-purple-50 transition-all hover:scale-105"^>
echo           Comenzar Ahora
echo         ^</button^>
echo       ^</div^>
echo     ^</section^>
echo   ^)
echo }
echo.
echo export default Hero
) > src\components\Hero.tsx

echo ├─ src/components/Features.tsx
(
echo import React from 'react'
echo.
echo interface Feature {
echo   icon: string
echo   title: string
echo   description: string
echo }
echo.
echo const features: Feature[] = [
echo   {
echo     icon: '',
echo     title: 'Rápido',
echo     description: 'Desarrollo ultra rápido con Vite y HMR'
echo   },
echo   {
echo     icon: '',
echo     title: 'Moderno',
echo     description: 'Diseño profesional con Tailwind CSS'
echo   },
echo   {
echo     icon: '',
echo     title: 'Tipo Seguro',
echo     description: 'TypeScript para código robusto y sin errores'
echo   }
echo ]
echo.
echo const Features: React.FC = ^(^) =^> {
echo   return ^(
echo     ^<section className="py-20 bg-white"^>
echo       ^<div className="container mx-auto px-4"^>
echo         ^<h2 className="text-4xl font-bold text-center mb-16 text-gray-800"^>
echo           Características Destacadas
echo         ^</h2^>
echo         ^<div className="grid md:grid-cols-3 gap-8"^>
echo           {features.map^(^(feature, index^) =^> ^(
echo             ^<div key={index} className="text-center p-6 rounded-lg hover:shadow-xl transition-shadow"^>
echo               ^<div className="text-5xl mb-4"^>{feature.icon}^</div^>
echo               ^<h3 className="text-2xl font-semibold mb-3 text-gray-800"^>{feature.title}^</h3^>
echo               ^<p className="text-gray-600"^>{feature.description}^</p^>
echo             ^</div^>
echo           ^)^)}
echo         ^</div^>
echo       ^</div^>
echo     ^</section^>
echo   ^)
echo }
echo.
echo export default Features
) > src\components\Features.tsx

echo ├─ src/components/CTA.tsx
(
echo import React from 'react'
echo.
echo const CTA: React.FC = ^(^) =^> {
echo   return ^(
echo     ^<section className="py-20 bg-gradient-to-r from-purple-600 to-indigo-600"^>
echo       ^<div className="container mx-auto px-4 text-center"^>
echo         ^<h2 className="text-4xl font-bold text-white mb-6"^>
echo           ¿Listo para comenzar?
echo         ^</h2^>
echo         ^<p className="text-xl text-white/90 mb-8 max-w-2xl mx-auto"^>
echo           Crea aplicaciones increíbles con la mejor tecnología del mercado
echo         ^</p^>
echo         ^<button className="bg-white text-purple-600 px-10 py-4 rounded-full font-semibold text-lg hover:bg-purple-50 transition-all hover:scale-105 shadow-lg"^>
echo           Empezar Gratis
echo         ^</button^>
echo       ^</div^>
echo     ^</section^>
echo   ^)
echo }
echo.
echo export default CTA
) > src\components\CTA.tsx
goto :eof

REM =========================================
REM   COMPONENTES: E-COMMERCE
REM =========================================

:create_ecommerce_components
echo ├─ src/types/index.ts
(
echo export interface Product {
echo   id: number
echo   name: string
echo   price: number
echo   image: string
echo   description: string
echo }
echo.
echo export interface CartItem extends Product {
echo   quantity: number
echo }
) > src\types\index.ts

echo ├─ src/components/Header.tsx
(
echo import React from 'react'
echo.
echo interface HeaderProps {
echo   cartCount: number
echo }
echo.
echo const Header: React.FC^<HeaderProps^> = ^({ cartCount }^) =^> {
echo   return ^(
echo     ^<header className="bg-white shadow-md sticky top-0 z-50"^>
echo       ^<div className="container mx-auto px-4 py-4 flex justify-between items-center"^>
echo         ^<h1 className="text-2xl font-bold text-gray-800"^>!PROJECT_NAME!^</h1^>
echo         ^<div className="flex items-center gap-6"^>
echo           ^<nav className="hidden md:flex gap-4"^>
echo             ^<a href="#" className="text-gray-600 hover:text-gray-800"^>Inicio^</a^>
echo             ^<a href="#" className="text-gray-600 hover:text-gray-800"^>Productos^</a^>
echo             ^<a href="#" className="text-gray-600 hover:text-gray-800"^>Contacto^</a^>
echo           ^</nav^>
echo           ^<button className="relative"^>
echo             ^<span className="text-2xl"^>^</span^>
echo             {cartCount ^> 0 ^&^& ^(
echo               ^<span className="absolute -top-2 -right-2 bg-red-500 text-white rounded-full w-5 h-5 flex items-center justify-center text-xs"^>
echo                 {cartCount}
echo               ^</span^>
echo             ^)}
echo           ^</button^>
echo         ^</div^>
echo       ^</div^>
echo     ^</header^>
echo   ^)
echo }
echo.
echo export default Header
) > src\components\Header.tsx

echo ├─ src/components/ProductGrid.tsx
(
echo import React from 'react'
echo import type { Product } from '../types'
echo.
echo interface ProductGridProps {
echo   onAddToCart: ^(product: Product^) =^> void
echo }
echo.
echo const mockProducts: Product[] = [
echo   { id: 1, name: 'Producto 1', price: 29.99, image: 'https://via.placeholder.com/300', description: 'Descripción del producto 1' },
echo   { id: 2, name: 'Producto 2', price: 49.99, image: 'https://via.placeholder.com/300', description: 'Descripción del producto 2' },
echo   { id: 3, name: 'Producto 3', price: 39.99, image: 'https://via.placeholder.com/300', description: 'Descripción del producto 3' }
echo ]
echo.
echo const ProductGrid: React.FC^<ProductGridProps^> = ^({ onAddToCart }^) =^> {
echo   return ^(
echo     ^<section className="container mx-auto px-4 py-12"^>
echo       ^<h2 className="text-3xl font-bold mb-8"^>Nuestros Productos^</h2^>
echo       ^<div className="grid md:grid-cols-3 gap-6"^>
echo         {mockProducts.map^(product =^> ^(
echo           ^<div key={product.id} className="bg-white rounded-lg shadow-lg overflow-hidden hover:shadow-xl transition-shadow"^>
echo             ^<img src={product.image} alt={product.name} className="w-full h-48 object-cover" /^>
echo             ^<div className="p-4"^>
echo               ^<h3 className="text-xl font-semibold mb-2"^>{product.name}^</h3^>
echo               ^<p className="text-gray-600 mb-4"^>{product.description}^</p^>
echo               ^<div className="flex justify-between items-center"^>
echo                 ^<span className="text-2xl font-bold text-green-600"^>${product.price}^</span^>
echo                 ^<button 
echo                   onClick={^(^) =^> onAddToCart^(product^)}
echo                   className="bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-700 transition-colors"
echo                 ^>
echo                   Agregar
echo                 ^</button^>
echo               ^</div^>
echo             ^</div^>
echo           ^</div^>
echo         ^)^)}
echo       ^</div^>
echo     ^</section^>
echo   ^)
echo }
echo.
echo export default ProductGrid
) > src\components\ProductGrid.tsx

echo ├─ src/features/Cart.tsx
(
echo import React from 'react'
echo import type { Product } from '../types'
echo.
echo interface CartProps {
echo   items: Product[]
echo }
echo.
echo const Cart: React.FC^<CartProps^> = ^({ items }^) =^> {
echo   const total = items.reduce^(^(sum, item^) =^> sum + item.price, 0^)
echo.
echo   if ^(items.length === 0^) return null
echo.
echo   return ^(
echo     ^<div className="fixed bottom-4 right-4 bg-white p-6 rounded-lg shadow-2xl max-w-md"^>
echo       ^<h3 className="text-xl font-bold mb-4"^>Carrito^</h3^>
echo       ^<div className="space-y-2 mb-4"^>
echo         {items.map^(^(item, index^) =^> ^(
echo           ^<div key={index} className="flex justify-between"^>
echo             ^<span^>{item.name}^</span^>
echo             ^<span className="font-semibold"^>${item.price}^</span^>
echo           ^</div^>
echo         ^)^)}
echo       ^</div^>
echo       ^<div className="border-t pt-4"^>
echo         ^<div className="flex justify-between text-xl font-bold"^>
echo           ^<span^>Total:^</span^>
echo           ^<span className="text-green-600"^>${total.toFixed^(2^)}^</span^>
echo         ^</div^>
echo         ^<button className="w-full mt-4 bg-green-600 text-white py-3 rounded hover:bg-green-700 transition-colors"^>
echo           Finalizar Compra
echo         ^</button^>
echo       ^</div^>
echo     ^</div^>
echo   ^)
echo }
echo.
echo export default Cart
) > src\features\Cart.tsx
goto :eof

REM =========================================
REM   COMPONENTES: DASHBOARD
REM =========================================

:create_dashboard_components
echo ├─ src/components/Sidebar.tsx
(
echo import React from 'react'
echo.
echo const Sidebar: React.FC = ^(^) =^> {
echo   return ^(
echo     ^<aside className="w-64 bg-gray-800 text-white p-6"^>
echo       ^<h2 className="text-2xl font-bold mb-8"^>!PROJECT_NAME!^</h2^>
echo       ^<nav className="space-y-2"^>
echo         ^<a href="#" className="block px-4 py-3 rounded hover:bg-gray-700 transition-colors"^>
echo            Dashboard
echo         ^</a^>
echo         ^<a href="#" className="block px-4 py-3 rounded hover:bg-gray-700 transition-colors"^>
echo           📈 Análisis
echo         ^</a^>
echo         ^<a href="#" className="block px-4 py-3 rounded hover:bg-gray-700 transition-colors"^>
echo           👥 Usuarios
echo         ^</a^>
echo         ^<a href="#" className="block px-4 py-3 rounded hover:bg-gray-700 transition-colors"^>
echo           ⚙️ Configuración
echo         ^</a^>
echo       ^</nav^>
echo     ^</aside^>
echo   ^)
echo }
echo.
echo export default Sidebar
) > src\components\Sidebar.tsx

echo ├─ src/components/Analytics.tsx
(
echo import React from 'react'
echo.
echo interface Stat {
echo   label: string
echo   value: string
echo   change: string
echo   isPositive: boolean
echo }
echo.
echo const stats: Stat[] = [
echo   { label: 'Usuarios Totales', value: '12,345', change: '+12%%', isPositive: true },
echo   { label: 'Ingresos', value: '$54,321', change: '+8%%', isPositive: true },
echo   { label: 'Conversión', value: '3.2%%', change: '-2%%', isPositive: false },
echo   { label: 'Satisfacción', value: '4.8/5', change: '+0.3', isPositive: true }
echo ]
echo.
echo const Analytics: React.FC = ^(^) =^> {
echo   return ^(
echo     ^<div className="grid md:grid-cols-4 gap-6 mb-8"^>
echo       {stats.map^(^(stat, index^) =^> ^(
echo         ^<div key={index} className="bg-white p-6 rounded-lg shadow"^>
echo           ^<p className="text-gray-500 text-sm mb-2"^>{stat.label}^</p^>
echo           ^<p className="text-3xl font-bold mb-2"^>{stat.value}^</p^>
echo           ^<p className={`text-sm ${stat.isPositive ? 'text-green-600' : 'text-red-600'}`}^>
echo             {stat.change} vs mes anterior
echo           ^</p^>
echo         ^</div^>
echo       ^)^)}
echo     ^</div^>
echo   ^)
echo }
echo.
echo export default Analytics
) > src\components\Analytics.tsx

echo ├─ src/components/DataTable.tsx
(
echo import React, { useState } from 'react'
echo.
echo interface User {
echo   id: number
echo   name: string
echo   email: string
echo   role: string
echo   status: 'active' ^| 'inactive'
echo }
echo.
echo const mockData: User[] = [
echo   { id: 1, name: 'Juan Pérez', email: 'juan@example.com', role: 'Admin', status: 'active' },
echo   { id: 2, name: 'María García', email: 'maria@example.com', role: 'Usuario', status: 'active' },
echo   { id: 3, name: 'Carlos López', email: 'carlos@example.com', role: 'Usuario', status: 'inactive' }
echo ]
echo.
echo const DataTable: React.FC = ^(^) =^> {
echo   const [data] = useState^<User[]^>^(mockData^)
echo.
echo   return ^(
echo     ^<div className="bg-white rounded-lg shadow overflow-hidden"^>
echo       ^<div className="p-6"^>
echo         ^<h2 className="text-2xl font-bold mb-4"^>Usuarios Recientes^</h2^>
echo       ^</div^>
echo       ^<table className="w-full"^>
echo         ^<thead className="bg-gray-50"^>
echo           ^<tr^>
echo             ^<th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase"^>Nombre^</th^>
echo             ^<th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase"^>Email^</th^>
echo             ^<th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase"^>Rol^</th^>
echo             ^<th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase"^>Estado^</th^>
echo           ^</tr^>
echo         ^</thead^>
echo         ^<tbody className="divide-y divide-gray-200"^>
echo           {data.map^(user =^> ^(
echo             ^<tr key={user.id}^>
echo               ^<td className="px-6 py-4"^>{user.name}^</td^>
echo               ^<td className="px-6 py-4 text-gray-500"^>{user.email}^</td^>
echo               ^<td className="px-6 py-4"^>{user.role}^</td^>
echo               ^<td className="px-6 py-4"^>
echo                 ^<span className={`px-2 py-1 rounded-full text-xs ${
echo                   user.status === 'active' ? 'bg-green-100 text-green-800' : 'bg-red-100 text-red-800'
echo                 }`}^>
echo                   {user.status}
echo                 ^</span^>
echo               ^</td^>
echo             ^</tr^>
echo           ^)^)}
echo         ^</tbody^>
echo       ^</table^>
echo     ^</div^>
echo   ^)
echo }
echo.
echo export default DataTable
) > src\components\DataTable.tsx
goto :eof