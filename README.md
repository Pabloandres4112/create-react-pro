#  Create React Pro

> CLI multiplataforma profesional para generar proyectos React con TypeScript, Tailwind CSS y las mejores prácticas de desarrollo moderno.

[![Node.js](https://img.shields.io/badge/Node.js-18%2B-green.svg)](https://nodejs.org/)
[![TypeScript](https://img.shields.io/badge/TypeScript-5.0-blue.svg)](https://www.typescriptlang.org/)
[![License](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

##  Características

-  **Multiplataforma**: Funciona en Windows, macOS y Linux
-  **Vite por Defecto**: Desarrollo ultrarrápido con HMR instantáneo
-  **Múltiples Gestores**: Soporte para npm, pnpm y yarn (con detección automática)
-  **Plantillas Modernas**: Landing Page, E-commerce y Dashboard preconfiguradas
-  **Git Hooks Automáticos**: Husky + lint-staged + commitlint integrados
- 🎯 **TypeScript**: Tipado fuerte para código más robusto
- 💅 **Tailwind CSS**: Estilos utilitarios listos para usar
- 🔧 **ESLint & Prettier**: Calidad de código desde el primer commit

##  Requisitos

- Node.js 18.0.0 o superior
- npm, pnpm o yarn
- Git (opcional, para inicializar repositorio)

##  Instalación Rápida

### Instalación Automática (Recomendado)

**Windows CMD:**
```batch
install.bat
```

**Windows PowerShell:**
```powershell
.\install.ps1
```

**Linux / macOS / WSL:**
```bash
bash install.sh
```

### Instalación Manual

```bash
cd cli
npm install
npm run build
npm install -g .
```

##  Uso

### Modo Interactivo (Recomendado)

```bash
create-react-pro create
```

El CLI te guiará a través de preguntas interactivas para configurar tu proyecto.

### Modo con Argumentos

```bash
# Landing page moderna
create-react-pro create mi-landing --template landing --vite --pm pnpm --git-hooks

# Tienda e-commerce
create-react-pro create mi-tienda --template ecommerce --vite --pm yarn --git-hooks

# Dashboard administrativo
create-react-pro create mi-dashboard --template dashboard --vite --pm npm --git-hooks
```

### Opciones Disponibles

```
-t, --template <template>   Tipo de plantilla (landing, ecommerce, dashboard)
--vite                      Usar Vite como bundler (recomendado)
--pm <manager>              Gestor de paquetes (npm, pnpm, yarn)
--git-hooks                 Configurar Husky + lint-staged + commitlint
--skip-install              No instalar dependencias automáticamente
-h, --help                  Mostrar ayuda
```

##  Plantillas Incluidas

###  Landing Page
Página de aterrizaje moderna con:
- Hero section con gradientes
- Sección de características con cards
- Footer profesional
- Diseño completamente responsive

###  E-commerce
Sistema de comercio electrónico con:
- Catálogo de productos con grid
- Sistema de carrito funcional
- UI moderna para tienda online
- Gestión de estado básica

###  Dashboard
Panel administrativo profesional con:
- Sidebar fijo de navegación
- Cards de estadísticas
- Layout optimizado para datos
- Preparado para integrar gráficos

##  Git Hooks (Cuando se Activan con --git-hooks)

### Pre-commit Hook
Se ejecuta automáticamente antes de cada commit:
-  Ejecuta ESLint en archivos modificados
-  Formatea con Prettier automáticamente
-  Solo procesa archivos en staging
-  Previene commits con errores de sintaxis

### Commit-msg Hook
Valida el formato de tus mensajes usando Conventional Commits:

**Commits válidos:**
```bash
git commit -m "feat: agregar carrito de compras"
git commit -m "fix: corregir bug en navegación"
git commit -m "docs: actualizar README"
```

**Commits inválidos:**
```bash
git commit -m "cambios varios"        # 
git commit -m "fix bug"               # 
```

**Tipos permitidos:** `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `chore`, `revert`, `ci`

##  Gestores de Paquetes

### Detección Automática
El CLI detecta automáticamente qué gestores tienes instalados:

- **npm**: Gestor por defecto de Node.js
- **pnpm**: Más rápido y eficiente en espacio ( recomendado)
- **yarn**: Popular alternativa

### ¿Por qué pnpm?
```bash
# Instalar pnpm
npm install -g pnpm
```

Ventajas:
-  2-3x más rápido que npm
- 💾 Ahorra hasta 70% de espacio en disco
- 🔒 Más seguro con estructura estricta
-  Compatible 100% con package.json

## 🔧 Desarrollo del CLI

### Estructura del Proyecto

```
cli/
├── src/
│   ├── commands/         # Comandos del CLI
│   │   └── create.ts
│   ├── generators/       # Generadores de código
│   │   ├── project.ts
│   │   ├── vite.ts
│   │   ├── templates.ts
│   │   └── git-hooks.ts
│   ├── types/            # Tipos TypeScript
│   ├── utils/            # Utilidades
│   │   ├── system.ts
│   │   ├── files.ts
│   │   └── logger.ts
│   └── index.ts          # Punto de entrada
├── package.json
└── tsconfig.json
```

### Compilar el CLI

```bash
cd cli
npm run build
```

### Modo Desarrollo

```bash
cd cli
npm run dev create test-project
```

## 🆚 Comparación: Scripts .bat vs CLI Node.js

| Característica | Scripts .bat (Legacy) | CLI Node.js |
|----------------|----------------------|-------------|
| **Plataforma** |  Solo Windows |  Windows, macOS, Linux |
| **Interfaz** | ⚠️ Básica (texto plano) |  Moderna (colores, spinners) |
| **Validación** | ⚠️ Limitada |  Robusta y en tiempo real |
| **Gestores** |  Solo npm |  npm, pnpm, yarn |
| **Bundler** | ⚠️ Solo CRA |  Vite + CRA |
| **Git Hooks** |  No |  Husky + lint-staged |
| **Código** | ⚠️ Difícil mantener |  TypeScript modular |
| **Testing** |  No |  Fácil de testear |

##  Tecnologías Incluidas en Proyectos Generados

### Siempre Incluidas
-  React 18+
-  TypeScript 5+
-  Tailwind CSS 3.4+
-  PostCSS + Autoprefixer

### Con --vite (Recomendado)
-  Vite 5+
-  @vitejs/plugin-react
-  Hot Module Replacement

### Con --git-hooks
-  Husky 9+
-  lint-staged
-  @commitlint/cli
-  ESLint + Prettier

##  Scripts del Proyecto Generado

```bash
npm run dev      # Inicia servidor de desarrollo
npm run build    # Compila para producción  
npm run preview  # Vista previa del build
npm run lint     # Ejecuta ESLint
npm run format   # Formatea con Prettier
```

## 🐛 Solución de Problemas

### "Command not found: create-react-pro"
```bash
cd cli
npm install -g .
```

### "Permission denied" (Linux/macOS)
```bash
sudo npm install -g .
```

### "Node version too old"
```bash
# Verificar versión
node --version  # Debe ser >= 18.0.0

# Actualizar desde: https://nodejs.org/
```

## 🤝 Contribuir

Las contribuciones son bienvenidas! Por favor:

1. Fork el repositorio
2. Crea una rama: `git checkout -b feature/nueva-caracteristica`
3. Commit con Conventional Commits: `git commit -m "feat: agregar X"`
4. Push: `git push origin feature/nueva-caracteristica`
5. Abre un Pull Request

##  Licencia

MIT

## 🙏 Agradecimientos

- [Vite](https://vitejs.dev/) - Build tool ultrarrápido
- [Commander.js](https://github.com/tj/commander.js/) - CLI framework
- [Inquirer.js](https://github.com/SBoudrias/Inquirer.js/) - Interactive prompts
- [Ora](https://github.com/sindresorhus/ora) - Terminal spinners
- [Chalk](https://github.com/chalk/chalk) - Terminal styling

---

Hecho con ❤️ para la comunidad React
    ├→ 07_packages.bat (npm install)
    └→ 08_finalize.bat (Git init, VS Code)
    ↓
 Proyecto React Completamente Listo
```

---

##  Verificar Sistema

Antes de usar, puedes verificar que todo está bien:

```batch
verificar_sistema.bat
```

Esto comprueba:
-  Node.js instalado
-  npm instalado
-  Todos los scripts existen
-  Estructura correcta

---

##  Consejos

1. **Usa nombres descriptivos** para tus proyectos: `tienda-online`, `blog-personal`
2. **Mantén Node.js actualizado** para mejor compatibilidad
3. **Versiona con Git** desde el inicio (ya está inicializado)
4. **Instala extensiones** recomendadas en VS Code
5. **Lee el README.md** generado en tu proyecto

---

##  ¡Empieza Ahora!

**Instalación:**
```bash
# Windows
install.bat

# Linux/macOS
bash install.sh
```

**Uso:**
```bash
create-react-pro create
```

---

**Create React Pro** - CLI profesional para proyectos React modernos  
Desarrolla aplicaciones profesionales con las mejores prácticas desde el inicio.
