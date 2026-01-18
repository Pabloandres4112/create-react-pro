# Create React Pro - CLI

> CLI multiplataforma para generar proyectos React profesionales

## Instalación

```bash
npm install
npm run build
npm install -g .
```

## Uso

```bash
create-react-pro create [nombre] [opciones]
```

## Desarrollo

```bash
npm run dev create test-project
```

## Estructura

```
src/
├── commands/      # Comandos del CLI
├── generators/    # Generadores de código  
├── utils/         # Utilidades
├── types/         # Tipos TypeScript
└── index.ts       # Punto de entrada
```

Para más información, consulta el [README principal](../README.md).

##  Características

-  **Multiplataforma**: Funciona en Windows, macOS y Linux
-  **Vite por Defecto**: Desarrollo ultrarrápido con HMR
-  **Múltiples Gestores**: Soporte para npm, pnpm y yarn (con detección automática)
-  **Plantillas Modernas**: Landing Page, E-commerce y Dashboard
-  **Git Hooks Automáticos**: Husky + lint-staged + commitlint preconfigurados
-  **TypeScript**: Tipado fuerte para código más robusto
-  **Tailwind CSS**: Estilos utilitarios integrados
-  **ESLint & Prettier**: Calidad de código desde el primer commit

##  Requisitos

- Node.js 18.0.0 o superior
- npm, pnpm o yarn
- Git (opcional, para inicializar repositorio)

##  Instalación

### Instalación Global

\`\`\`bash
# Con npm
cd cli
npm install -g .

# Con pnpm (recomendado)
cd cli
pnpm install -g .

# Con yarn
cd cli
yarn global add .
\`\`\`

### Uso Directo (sin instalación)

\`\`\`bash
cd cli
npm install
npm run dev create mi-proyecto
\`\`\`

##  Uso

### Modo Interactivo (Recomendado)

\`\`\`bash
create-react-pro create
\`\`\`

El CLI te guiará a través de una serie de preguntas para configurar tu proyecto:

1. **Nombre del proyecto**: Debe ser un nombre válido (minúsculas, números, guiones)
2. **Descripción**: Breve descripción de tu proyecto
3. **Autor**: Tu nombre o el de tu equipo
4. **Plantilla**: Elige entre Landing, E-commerce o Dashboard
5. **Bundler**: Opción de usar Vite (recomendado) o CRA
6. **Gestor de paquetes**: npm, pnpm o yarn
7. **Git Hooks**: Configuración automática de calidad de código

### Modo con Argumentos

\`\`\`bash
# Crear proyecto con opciones específicas
create-react-pro create mi-app --template landing --vite --pm pnpm --git-hooks

# Ver todas las opciones
create-react-pro create --help
\`\`\`

### Opciones Disponibles

\`\`\`
-t, --template <template>   Tipo de plantilla (landing, ecommerce, dashboard)
--vite                      Usar Vite como bundler (recomendado)
--pm <manager>              Gestor de paquetes (npm, pnpm, yarn)
--git-hooks                 Configurar Husky + lint-staged + commitlint
--skip-install              No instalar dependencias automáticamente
\`\`\`

##  Plantillas Disponibles

###  Landing Page
- Hero section moderno
- Sección de características
- Diseño responsive
- Footer profesional
- Listo para personalizar

###  E-commerce
- Catálogo de productos
- Carrito de compras
- Sistema de gestión de estado
- UI moderna para tienda online

###  Dashboard
- Panel administrativo
- Sidebar navegación
- Cards de estadísticas
- Diseño para análisis de datos

##  Git Hooks Incluidos

Cuando activas la opción de Git Hooks, se configura automáticamente:

### Pre-commit
- **lint-staged**: Ejecuta ESLint y Prettier solo en archivos modificados
- Formatea el código automáticamente
- Verifica errores antes del commit

### Commit-msg
- **commitlint**: Valida que los mensajes de commit sigan Conventional Commits
- Formatos válidos: `feat:`, `fix:`, `docs:`, `style:`, `refactor:`, etc.

Ejemplo de commits válidos:
\`\`\`bash
git commit -m "feat: agregar componente de navegación"
git commit -m "fix: corregir bug en el carrito de compras"
git commit -m "docs: actualizar README con instrucciones"
\`\`\`

##  Gestores de Paquetes

### Detección Automática
El CLI detecta automáticamente qué gestores están instalados y te permite elegir:

- **npm**: Gestor por defecto de Node.js
- **pnpm**: Más rápido y eficiente en espacio (recomendado)
- **yarn**: Popular alternativa con características adicionales

### Ventajas de pnpm
-  Instalaciones hasta 2x más rápidas
-  Ahorra espacio en disco con hard links
-  Estructura de node_modules más segura

##  Desarrollo

### Estructura del CLI

\`\`\`
cli/
├── src/
│   ├── commands/         # Comandos del CLI
│   │   └── create.ts     # Comando principal de creación
│   ├── generators/       # Generadores de código
│   │   ├── project.ts    # Generador del proyecto
│   │   ├── vite.ts       # Generador con Vite
│   │   ├── templates.ts  # Aplicador de plantillas
│   │   └── git-hooks.ts  # Configurador de Git hooks
│   ├── types/            # Tipos TypeScript
│   ├── utils/            # Utilidades
│   │   ├── system.ts     # Funciones de sistema
│   │   ├── files.ts      # Manipulación de archivos
│   │   └── logger.ts     # Logger con colores
│   └── index.ts          # Punto de entrada
├── package.json
└── tsconfig.json
\`\`\`

### Compilar el CLI

\`\`\`bash
cd cli
npm run build
\`\`\`

### Modo Desarrollo

\`\`\`bash
cd cli
npm run dev create test-project
\`\`\`

##  Configuración Post-Instalación

Después de crear tu proyecto:

\`\`\`bash
cd mi-proyecto

# Si usaste --skip-install
pnpm install

# Iniciar servidor de desarrollo
pnpm dev

# Ejecutar linter
pnpm lint

# Formatear código
pnpm format

# Compilar para producción
pnpm build
\`\`\`

##  Scripts Disponibles en el Proyecto Generado

\`\`\`json
{
  "dev": "Inicia el servidor de desarrollo",
  "build": "Compila el proyecto para producción",
  "preview": "Vista previa del build de producción",
  "lint": "Ejecuta ESLint",
  "format": "Formatea el código con Prettier",
  "prepare": "Configura Husky (automático)"
}
\`\`\`

##  Ventajas sobre los Scripts .bat Originales

### Multiplataforma
-  Funciona en Windows, macOS y Linux
-  No requiere WSL en Windows
-  Un solo código base para todos los sistemas

### Experiencia de Usuario
-  Prompts interactivos modernos con colores
-  Spinners animados para feedback visual
-  Mensajes de error claros y descriptivos
-  Validación de entrada en tiempo real

### Funcionalidades Avanzadas
-  Detección automática de gestores de paquetes
-  Soporte para pnpm (más rápido)
-  Configuración automática de Git Hooks
-  Integración con Vite por defecto
-  Convenciones de commits automáticas

### Mantenibilidad
-  Código TypeScript tipado
-  Estructura modular y escalable
-  Fácil de extender con nuevas plantillas
-  Testing más sencillo

##  Roadmap Futuro

- [ ] Tests automatizados (Jest/Vitest)
- [ ] Más plantillas (Blog, Portfolio, SaaS)
- [ ] Integración con backends (Supabase, Firebase)
- [ ] Generador de componentes (`create-react-pro component`)
- [ ] Soporte para React Native
- [ ] Configuración de CI/CD
- [ ] Integración con Storybook

##  Contribuir

Las contribuciones son bienvenidas! Por favor:

1. Fork el repositorio
2. Crea una rama para tu feature (`git checkout -b feature/nueva-caracteristica`)
3. Commit tus cambios siguiendo Conventional Commits
4. Push a la rama (`git push origin feature/nueva-caracteristica`)
5. Abre un Pull Request

##  Licencia

MIT

##  Agradecimientos

- [Vite](https://vitejs.dev/) - Build tool ultrarrápido
- [Commander.js](https://github.com/tj/commander.js/) - CLI framework
- [Inquirer.js](https://github.com/SBoudrias/Inquirer.js/) - Interactive prompts
- [Ora](https://github.com/sindresorhus/ora) - Elegant terminal spinners
- [Chalk](https://github.com/chalk/chalk) - Terminal string styling

---

Hecho con  para la comunidad React
\`\`\`
