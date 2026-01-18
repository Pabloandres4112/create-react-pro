import { cpSync, existsSync, mkdirSync, writeFileSync } from 'fs';
import { join, dirname } from 'path';
import { fileURLToPath } from 'url';
import type { ProjectConfig } from '../types/index.js';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

export async function generateTemplateFiles(config: ProjectConfig, spinner: any): Promise<void> {
  spinner.text = `Aplicando plantilla ${config.template}...`;

  try {
    const templatesBasePath = join(__dirname, '../../templates');
    const templatePath = join(templatesBasePath, config.template);

    if (!existsSync(templatePath)) {
      spinner.warn(`Plantilla ${config.template} no encontrada, usando estructura base`);
      return;
    }

    // Copiar archivos de la plantilla
    const srcPath = join(config.targetPath, 'src');
    const templateSrcPath = join(templatePath, 'src');

    if (existsSync(templateSrcPath)) {
      // Crear directorios si no existen
      if (!existsSync(srcPath)) {
        mkdirSync(srcPath, { recursive: true });
      }

      // Copiar componentes
      if (existsSync(join(templateSrcPath, 'components'))) {
        cpSync(
          join(templateSrcPath, 'components'),
          join(srcPath, 'components'),
          { recursive: true }
        );
      }

      // Copiar páginas (si existen)
      if (existsSync(join(templateSrcPath, 'pages'))) {
        cpSync(
          join(templateSrcPath, 'pages'),
          join(srcPath, 'pages'),
          { recursive: true }
        );
      }

      // Copiar features (para ecommerce)
      if (existsSync(join(templateSrcPath, 'features'))) {
        cpSync(
          join(templateSrcPath, 'features'),
          join(srcPath, 'features'),
          { recursive: true }
        );
      }

      // Generar App.tsx según la plantilla
      generateAppFile(config);
    }

    spinner.text = `Plantilla ${config.template} aplicada`;
  } catch (error: any) {
    spinner.warn(`No se pudo aplicar la plantilla completamente: ${error.message}`);
  }
}

function generateAppFile(config: ProjectConfig): void {
  const appContent = getAppContentForTemplate(config.template);
  const appPath = join(config.targetPath, 'src', 'App.tsx');
  writeFileSync(appPath, appContent);
}

function getAppContentForTemplate(template: string): string {
  const templates: Record<string, string> = {
    landing: `import React from 'react';
import './App.css';

function App() {
  return (
    <div className="min-h-screen bg-gradient-to-br from-blue-50 to-indigo-100">
      {/* Header */}
      <header className="bg-white shadow-sm">
        <nav className="container mx-auto px-6 py-4">
          <div className="flex items-center justify-between">
            <div className="text-2xl font-bold text-indigo-600">Tu Logo</div>
            <div className="hidden md:flex space-x-8">
              <a href="#features" className="text-gray-700 hover:text-indigo-600">Características</a>
              <a href="#about" className="text-gray-700 hover:text-indigo-600">Acerca de</a>
              <a href="#contact" className="text-gray-700 hover:text-indigo-600">Contacto</a>
            </div>
            <button className="bg-indigo-600 text-white px-6 py-2 rounded-lg hover:bg-indigo-700 transition">
              Comenzar
            </button>
          </div>
        </nav>
      </header>

      {/* Hero Section */}
      <section className="container mx-auto px-6 py-20 text-center">
        <h1 className="text-5xl md:text-6xl font-bold text-gray-900 mb-6">
          Bienvenido a tu Landing Page
        </h1>
        <p className="text-xl text-gray-600 mb-8 max-w-2xl mx-auto">
          Crea experiencias increíbles con React, TypeScript y Tailwind CSS.
          Todo listo para que empieces a construir.
        </p>
        <div className="flex gap-4 justify-center">
          <button className="bg-indigo-600 text-white px-8 py-3 rounded-lg text-lg hover:bg-indigo-700 transition">
            Empezar Ahora
          </button>
          <button className="bg-white text-indigo-600 px-8 py-3 rounded-lg text-lg border-2 border-indigo-600 hover:bg-indigo-50 transition">
            Saber Más
          </button>
        </div>
      </section>

      {/* Features Section */}
      <section id="features" className="container mx-auto px-6 py-20">
        <h2 className="text-4xl font-bold text-center text-gray-900 mb-12">
          Características Principales
        </h2>
        <div className="grid md:grid-cols-3 gap-8">
          {[
            { title: ' Rápido', desc: 'Construido con Vite para desarrollo ultrarrápido' },
            { title: ' Moderno', desc: 'Diseñado con Tailwind CSS para un look profesional' },
            { title: '🔒 Seguro', desc: 'TypeScript para código más robusto y mantenible' },
          ].map((feature, i) => (
            <div key={i} className="bg-white p-8 rounded-xl shadow-md hover:shadow-lg transition">
              <h3 className="text-2xl font-bold mb-4">{feature.title}</h3>
              <p className="text-gray-600">{feature.desc}</p>
            </div>
          ))}
        </div>
      </section>

      {/* Footer */}
      <footer className="bg-gray-900 text-white py-12">
        <div className="container mx-auto px-6 text-center">
          <p>&copy; 2026 Tu Empresa. Todos los derechos reservados.</p>
        </div>
      </footer>
    </div>
  );
}

export default App;
`,
    ecommerce: `import React, { useState } from 'react';
import './App.css';

interface Product {
  id: number;
  name: string;
  price: number;
  image: string;
}

function App() {
  const [cart, setCart] = useState<Product[]>([]);

  const products: Product[] = [
    { id: 1, name: 'Producto 1', price: 99.99, image: '🎁' },
    { id: 2, name: 'Producto 2', price: 149.99, image: '' },
    { id: 3, name: 'Producto 3', price: 199.99, image: '' },
  ];

  const addToCart = (product: Product) => {
    setCart([...cart, product]);
  };

  return (
    <div className="min-h-screen bg-gray-50">
      {/* Header */}
      <header className="bg-white shadow-sm">
        <nav className="container mx-auto px-6 py-4">
          <div className="flex items-center justify-between">
            <div className="text-2xl font-bold text-indigo-600"> Mi Tienda</div>
            <div className="flex items-center gap-4">
              <span className="text-gray-700">Carrito: {cart.length}</span>
              <button className="bg-indigo-600 text-white px-4 py-2 rounded-lg">
                Ver Carrito
              </button>
            </div>
          </div>
        </nav>
      </header>

      {/* Products */}
      <main className="container mx-auto px-6 py-12">
        <h1 className="text-4xl font-bold mb-8">Nuestros Productos</h1>
        <div className="grid md:grid-cols-3 gap-8">
          {products.map((product) => (
            <div key={product.id} className="bg-white rounded-xl shadow-md overflow-hidden hover:shadow-lg transition">
              <div className="h-48 bg-gradient-to-br from-indigo-100 to-purple-100 flex items-center justify-center text-6xl">
                {product.image}
              </div>
              <div className="p-6">
                <h3 className="text-xl font-bold mb-2">{product.name}</h3>
                <p className="text-2xl text-indigo-600 font-bold mb-4">
                  ${product.price}
                </p>
                <button
                  onClick={() => addToCart(product)}
                  className="w-full bg-indigo-600 text-white py-2 rounded-lg hover:bg-indigo-700 transition"
                >
                  Agregar al Carrito
                </button>
              </div>
            </div>
          ))}
        </div>
      </main>
    </div>
  );
}

export default App;
`,
    dashboard: `import React, { useState } from 'react';
import './App.css';

function App() {
  const [activeTab, setActiveTab] = useState('overview');

  const stats = [
    { label: 'Usuarios', value: '1,234', change: '+12%', positive: true },
    { label: 'Ventas', value: '$12,345', change: '+8%', positive: true },
    { label: 'Órdenes', value: '456', change: '-3%', positive: false },
    { label: 'Conversión', value: '3.24%', change: '+0.5%', positive: true },
  ];

  return (
    <div className="min-h-screen bg-gray-100">
      {/* Sidebar */}
      <aside className="fixed left-0 top-0 h-full w-64 bg-gray-900 text-white">
        <div className="p-6">
          <h1 className="text-2xl font-bold"> Dashboard</h1>
        </div>
        <nav className="px-4">
          {['overview', 'analytics', 'users', 'settings'].map((tab) => (
            <button
              key={tab}
              onClick={() => setActiveTab(tab)}
              className={\`w-full text-left px-4 py-3 rounded-lg mb-2 transition \${
                activeTab === tab
                  ? 'bg-indigo-600'
                  : 'hover:bg-gray-800'
              }\`}
            >
              {tab.charAt(0).toUpperCase() + tab.slice(1)}
            </button>
          ))}
        </nav>
      </aside>

      {/* Main Content */}
      <main className="ml-64 p-8">
        <h2 className="text-3xl font-bold mb-8">Panel de Control</h2>
        
        {/* Stats Grid */}
        <div className="grid md:grid-cols-4 gap-6 mb-8">
          {stats.map((stat, i) => (
            <div key={i} className="bg-white rounded-xl shadow-md p-6">
              <p className="text-gray-600 text-sm mb-2">{stat.label}</p>
              <p className="text-3xl font-bold mb-2">{stat.value}</p>
              <p className={\`text-sm \${stat.positive ? 'text-green-600' : 'text-red-600'}\`}>
                {stat.change}
              </p>
            </div>
          ))}
        </div>

        {/* Chart Placeholder */}
        <div className="bg-white rounded-xl shadow-md p-8">
          <h3 className="text-xl font-bold mb-6">Estadísticas de Ventas</h3>
          <div className="h-64 bg-gradient-to-br from-indigo-50 to-purple-50 rounded-lg flex items-center justify-center">
            <p className="text-gray-500 text-lg">Gráfico aquí (integra Chart.js o Recharts)</p>
          </div>
        </div>
      </main>
    </div>
  );
}

export default App;
`,
  };

  return templates[template] || templates.landing;
}
