import inquirer from 'inquirer';
import chalk from 'chalk';
import ora from 'ora';
import { existsSync } from 'fs';
import { join, resolve } from 'path';
import type { ProjectConfig, TemplateInfo } from '../types/index.js';
import { 
  detectPackageManagers, 
  validateProjectName, 
  checkNodeVersion,
  isCommandAvailable 
} from '../utils/system.js';
import { createProjectStructure } from '../generators/project.js';

const templates: TemplateInfo[] = [
  {
    name: ' Landing Page - Sitio web moderno y atractivo',
    description: 'Página de aterrizaje con secciones hero, features, testimonios y footer',
    value: 'landing'
  },
  {
    name: ' E-commerce - Tienda en línea completa',
    description: 'Sistema de comercio electrónico con carrito, productos y checkout',
    value: 'ecommerce'
  },
  {
    name: ' Dashboard - Panel administrativo',
    description: 'Panel de administración con gráficos, tablas y gestión de datos',
    value: 'dashboard'
  }
];

export async function createProject(
  projectName?: string,
  options?: any
): Promise<void> {
  console.log(chalk.cyan.bold('\n Create React Pro - Generador de Proyectos\n'));

  // Verificar prerequisitos
  const spinner = ora('Verificando prerequisitos...').start();
  
  const nodeOk = await checkNodeVersion();
  if (!nodeOk) {
    spinner.fail('Prerequisitos no cumplidos');
    process.exit(1);
  }
  
  spinner.succeed('Prerequisitos verificados');

  // Recopilar información del proyecto
  const config = await gatherProjectInfo(projectName, options);

  // Verificar que el directorio no exista
  if (existsSync(config.targetPath)) {
    console.log(chalk.red(`\n✖ El directorio "${config.name}" ya existe`));
    process.exit(1);
  }

  // Crear el proyecto
  await createProjectStructure(config);

  // Mostrar mensaje de éxito
  displaySuccessMessage(config);
}

async function gatherProjectInfo(
  projectName?: string,
  cmdOptions?: any
): Promise<ProjectConfig> {
  const answers: any = {};

  // Nombre del proyecto
  if (!projectName) {
    const { name } = await inquirer.prompt([
      {
        type: 'input',
        name: 'name',
        message: ' Nombre del proyecto:',
        default: 'my-react-app',
        validate: (input: string) => {
          const result = validateProjectName(input);
          return result.valid || result.message || false;
        }
      }
    ]);
    answers.name = name;
  } else {
    const validation = validateProjectName(projectName);
    if (!validation.valid) {
      console.log(chalk.red(`\n✖ ${validation.message}`));
      process.exit(1);
    }
    answers.name = projectName;
  }

  // Descripción y autor
  const { description, author } = await inquirer.prompt([
    {
      type: 'input',
      name: 'description',
      message: ' Descripción del proyecto:',
      default: 'Un proyecto React profesional'
    },
    {
      type: 'input',
      name: 'author',
      message: ' Autor:',
      default: ''
    }
  ]);
  answers.description = description;
  answers.author = author;

  // Plantilla
  if (!cmdOptions?.template) {
    const { template } = await inquirer.prompt([
      {
        type: 'list',
        name: 'template',
        message: ' Selecciona una plantilla:',
        choices: templates,
        pageSize: 10
      }
    ]);
    answers.template = template;
  } else {
    answers.template = cmdOptions.template;
  }

  // Vite
  if (cmdOptions?.vite === undefined) {
    const { useVite } = await inquirer.prompt([
      {
        type: 'confirm',
        name: 'useVite',
        message: ' ¿Usar Vite como bundler? (recomendado)',
        default: true
      }
    ]);
    answers.useVite = useVite;
  } else {
    answers.useVite = cmdOptions.vite;
  }

  // Gestor de paquetes
  if (!cmdOptions?.pm) {
    const availableManagers = await detectPackageManagers();
    const managerChoices = availableManagers
      .filter(m => m.available)
      .map(m => ({
        name: `${m.name}${m.name === 'pnpm' ? ' ( más rápido)' : ''}`,
        value: m.name
      }));

    if (managerChoices.length === 0) {
      console.log(chalk.red('\n✖ No se encontró ningún gestor de paquetes'));
      process.exit(1);
    }

    const { packageManager } = await inquirer.prompt([
      {
        type: 'list',
        name: 'packageManager',
        message: ' Gestor de paquetes:',
        choices: managerChoices,
        default: 'npm'
      }
    ]);
    answers.packageManager = packageManager;
  } else {
    answers.packageManager = cmdOptions.pm;
  }

  // Git hooks
  if (cmdOptions?.gitHooks === undefined) {
    const gitAvailable = await isCommandAvailable('git');
    
    if (gitAvailable) {
      const { setupGitHooks } = await inquirer.prompt([
        {
          type: 'confirm',
          name: 'setupGitHooks',
          message: ' ¿Configurar Git hooks (Husky + lint-staged + commitlint)?',
          default: true
        }
      ]);
      answers.setupGitHooks = setupGitHooks;
    } else {
      answers.setupGitHooks = false;
    }
  } else {
    answers.setupGitHooks = cmdOptions.gitHooks;
  }

  // Skip install
  answers.skipInstall = cmdOptions?.skipInstall || false;

  return {
    name: answers.name,
    template: answers.template,
    useVite: answers.useVite,
    packageManager: answers.packageManager,
    setupGitHooks: answers.setupGitHooks,
    skipInstall: answers.skipInstall,
    description: answers.description,
    author: answers.author,
    targetPath: resolve(process.cwd(), answers.name)
  };
}

function displaySuccessMessage(config: ProjectConfig): void {
  console.log(chalk.green.bold('\n ¡Proyecto creado exitosamente!\n'));
  console.log(chalk.cyan(' Ubicación:'), config.targetPath);
  console.log(chalk.cyan(' Plantilla:'), config.template);
  console.log(chalk.cyan(' Bundler:'), config.useVite ? 'Vite' : 'Create React App');
  console.log(chalk.cyan(' Gestor:'), config.packageManager);
  
  if (config.setupGitHooks) {
    console.log(chalk.cyan(' Git Hooks:'), 'Configurados');
  }

  console.log(chalk.yellow.bold('\n Próximos pasos:\n'));
  console.log(chalk.white(`  cd ${config.name}`));
  
  if (config.skipInstall) {
    console.log(chalk.white(`  ${config.packageManager} install`));
  }
  
  console.log(chalk.white(`  ${config.packageManager} ${config.packageManager === 'npm' ? 'run ' : ''}dev`));
  console.log(chalk.gray('\n¡Feliz desarrollo! \n'));
}
