import { execa } from 'execa';
import { existsSync } from 'fs';
import { join } from 'path';
import chalk from 'chalk';
import type { PackageManagerInfo } from '../types/index.js';

/**
 * Detecta qué gestores de paquetes están instalados en el sistema
 */
export async function detectPackageManagers(): Promise<PackageManagerInfo[]> {
  const managers: PackageManagerInfo[] = [
    { name: 'npm', lockFile: 'package-lock.json', installCommand: 'install', available: false },
    { name: 'pnpm', lockFile: 'pnpm-lock.yaml', installCommand: 'install', available: false },
    { name: 'yarn', lockFile: 'yarn.lock', installCommand: 'install', available: false },
  ];

  for (const manager of managers) {
    try {
      await execa(manager.name, ['--version']);
      manager.available = true;
    } catch {
      manager.available = false;
    }
  }

  return managers;
}

/**
 * Detecta el gestor de paquetes usado en un directorio específico
 */
export function detectPackageManagerInDirectory(directory: string): string | null {
  if (existsSync(join(directory, 'pnpm-lock.yaml'))) return 'pnpm';
  if (existsSync(join(directory, 'yarn.lock'))) return 'yarn';
  if (existsSync(join(directory, 'package-lock.json'))) return 'npm';
  return null;
}

/**
 * Verifica si un comando está disponible en el sistema
 */
export async function isCommandAvailable(command: string): Promise<boolean> {
  try {
    await execa(command, ['--version']);
    return true;
  } catch {
    return false;
  }
}

/**
 * Verifica que Node.js esté instalado y tenga la versión mínima requerida
 */
export async function checkNodeVersion(minVersion: number = 18): Promise<boolean> {
  try {
    const { stdout } = await execa('node', ['--version']);
    const version = parseInt(stdout.replace('v', '').split('.')[0]);
    
    if (version < minVersion) {
      console.log(chalk.red(`✖ Node.js ${minVersion}+ es requerido. Versión actual: ${stdout}`));
      return false;
    }
    
    return true;
  } catch {
    console.log(chalk.red('✖ Node.js no está instalado'));
    return false;
  }
}

/**
 * Valida el nombre del proyecto
 */
export function validateProjectName(name: string): { valid: boolean; message?: string } {
  if (!name || name.length === 0) {
    return { valid: false, message: 'El nombre del proyecto no puede estar vacío' };
  }

  if (!/^[a-z0-9-_]+$/.test(name)) {
    return { 
      valid: false, 
      message: 'El nombre solo puede contener letras minúsculas, números, guiones y guiones bajos' 
    };
  }

  if (name.startsWith('-') || name.startsWith('_')) {
    return { valid: false, message: 'El nombre no puede empezar con guión o guion bajo' };
  }

  return { valid: true };
}

/**
 * Instala dependencias usando el gestor de paquetes especificado
 */
export async function installDependencies(
  projectPath: string,
  packageManager: string,
  spinner: any
): Promise<void> {
  try {
    spinner.text = `Instalando dependencias con ${packageManager}...`;
    
    const installArgs = packageManager === 'yarn' ? [] : ['install'];
    
    await execa(packageManager, installArgs, {
      cwd: projectPath,
      stdio: 'pipe',
    });
    
    spinner.succeed(`Dependencias instaladas con ${packageManager}`);
  } catch (error) {
    spinner.fail(`Error al instalar dependencias`);
    throw error;
  }
}

/**
 * Inicializa un repositorio Git
 */
export async function initGitRepo(projectPath: string, spinner: any): Promise<void> {
  try {
    spinner.text = 'Inicializando repositorio Git...';
    
    await execa('git', ['init'], { cwd: projectPath });
    await execa('git', ['add', '.'], { cwd: projectPath });
    await execa('git', ['commit', '-m', 'chore: initial commit'], { cwd: projectPath });
    
    spinner.succeed('Repositorio Git inicializado');
  } catch (error) {
    spinner.warn('No se pudo inicializar el repositorio Git');
  }
}
