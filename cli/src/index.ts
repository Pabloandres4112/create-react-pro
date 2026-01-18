#!/usr/bin/env node

import { Command } from 'commander';
import chalk from 'chalk';
import { createProject } from './commands/create.js';
import { readFileSync } from 'fs';
import { fileURLToPath } from 'url';
import { dirname, join } from 'path';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

// Leer versión del package.json
const packageJson = JSON.parse(
  readFileSync(join(__dirname, '../package.json'), 'utf-8')
);

const program = new Command();

program
  .name('create-react-pro')
  .description(' CLI multiplataforma para generar proyectos React profesionales')
  .version(packageJson.version);

program
  .command('create [project-name]')
  .description('Crear un nuevo proyecto React con TypeScript y Tailwind CSS')
  .option('-t, --template <template>', 'Tipo de plantilla (landing, ecommerce, dashboard)')
  .option('--vite', 'Usar Vite como bundler (recomendado)')
  .option('--pm <manager>', 'Gestor de paquetes (npm, pnpm, yarn)')
  .option('--git-hooks', 'Configurar Husky + lint-staged + commitlint')
  .option('--skip-install', 'No instalar dependencias automáticamente')
  .action(createProject);

program
  .command('init')
  .description('Inicializar un proyecto en el directorio actual')
  .action(() => {
    console.log(chalk.yellow('⚠️  Funcionalidad en desarrollo...'));
  });

// Mostrar ayuda si no hay argumentos
if (!process.argv.slice(2).length) {
  program.outputHelp();
}

program.parse();
