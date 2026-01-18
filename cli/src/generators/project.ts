import ora from 'ora';
import chalk from 'chalk';
import { mkdirSync, writeFileSync, cpSync, existsSync, readFileSync } from 'fs';
import { join, dirname } from 'path';
import { execa } from 'execa';
import { fileURLToPath } from 'url';
import type { ProjectConfig } from '../types/index.js';
import { installDependencies, initGitRepo } from '../utils/system.js';
import { setupGitHooks } from './git-hooks.js';
import { generateViteProject } from './vite.js';
import { generateTemplateFiles } from './templates.js';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

export async function createProjectStructure(config: ProjectConfig): Promise<void> {
  const spinner = ora('Creando proyecto...').start();

  try {
    // Crear directorio del proyecto
    spinner.text = 'Creando estructura de directorios...';
    mkdirSync(config.targetPath, { recursive: true });

    // Generar proyecto base
    if (config.useVite) {
      await generateViteProject(config, spinner);
    } else {
      await generateCRAProject(config, spinner);
    }

    // Aplicar plantilla específica
    await generateTemplateFiles(config, spinner);

    // Configurar Tailwind CSS
    await setupTailwind(config, spinner);

    // Instalar dependencias
    if (!config.skipInstall) {
      await installDependencies(config.targetPath, config.packageManager, spinner);
    }

    // Configurar Git hooks
    if (config.setupGitHooks && !config.skipInstall) {
      await setupGitHooks(config, spinner);
    }

    // Inicializar Git
    await initGitRepo(config.targetPath, spinner);

    spinner.succeed(chalk.green('Proyecto creado exitosamente'));
  } catch (error: any) {
    spinner.fail('Error al crear el proyecto');
    console.error(chalk.red(error.message));
    process.exit(1);
  }
}

async function generateViteProject(config: ProjectConfig, spinner: any): Promise<void> {
  spinner.text = 'Generando proyecto con Vite...';

  try {
    // Crear proyecto Vite con React + TypeScript
    await execa('npm', ['create', 'vite@latest', config.name, '--', '--template', 'react-ts'], {
      cwd: dirname(config.targetPath),
      stdio: 'pipe'
    });

    // Actualizar package.json
    const packageJsonPath = join(config.targetPath, 'package.json');
    const packageJson = JSON.parse(readFileSync(packageJsonPath, 'utf-8'));
    
    packageJson.name = config.name;
    packageJson.description = config.description;
    packageJson.author = config.author;

    writeFileSync(packageJsonPath, JSON.stringify(packageJson, null, 2));

    spinner.text = 'Proyecto Vite generado';
  } catch (error) {
    throw new Error('Error al generar proyecto con Vite');
  }
}

async function generateCRAProject(config: ProjectConfig, spinner: any): Promise<void> {
  spinner.text = 'Generando proyecto con Create React App...';

  try {
    await execa('npx', [
      'create-react-app',
      config.name,
      '--template',
      'typescript'
    ], {
      cwd: dirname(config.targetPath),
      stdio: 'pipe'
    });

    // Actualizar package.json
    const packageJsonPath = join(config.targetPath, 'package.json');
    const packageJson = JSON.parse(readFileSync(packageJsonPath, 'utf-8'));
    
    packageJson.description = config.description;
    packageJson.author = config.author;

    writeFileSync(packageJsonPath, JSON.stringify(packageJson, null, 2));

    spinner.text = 'Proyecto CRA generado';
  } catch (error) {
    throw new Error('Error al generar proyecto con Create React App');
  }
}

async function setupTailwind(config: ProjectConfig, spinner: any): Promise<void> {
  spinner.text = 'Configurando Tailwind CSS...';

  try {
    const projectPath = config.targetPath;

    // Agregar dependencias de Tailwind al package.json
    const packageJsonPath = join(projectPath, 'package.json');
    const packageJson = JSON.parse(readFileSync(packageJsonPath, 'utf-8'));

    packageJson.devDependencies = {
      ...packageJson.devDependencies,
      'tailwindcss': '^3.4.1',
      'autoprefixer': '^10.4.17',
      'postcss': '^8.4.35'
    };

    writeFileSync(packageJsonPath, JSON.stringify(packageJson, null, 2));

    // Crear tailwind.config.js
    const tailwindConfig = `/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "./index.html",
    "./src/**/*.{js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {},
  },
  plugins: [],
}
`;
    writeFileSync(join(projectPath, 'tailwind.config.js'), tailwindConfig);

    // Crear postcss.config.js
    const postcssConfig = `export default {
  plugins: {
    tailwindcss: {},
    autoprefixer: {},
  },
}
`;
    writeFileSync(join(projectPath, 'postcss.config.js'), postcssConfig);

    // Actualizar o crear index.css
    const indexCss = `@tailwind base;
@tailwind components;
@tailwind utilities;
`;
    const cssPath = config.useVite 
      ? join(projectPath, 'src', 'index.css')
      : join(projectPath, 'src', 'index.css');
    
    writeFileSync(cssPath, indexCss);

    spinner.text = 'Tailwind CSS configurado';
  } catch (error) {
    throw new Error('Error al configurar Tailwind CSS');
  }
}
