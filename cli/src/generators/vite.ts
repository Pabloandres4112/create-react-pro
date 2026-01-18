import { execa } from 'execa';
import type { ProjectConfig } from '../types/index.js';

export async function generateViteProject(config: ProjectConfig, spinner: any): Promise<void> {
  spinner.text = 'Creando proyecto con Vite + React + TypeScript...';

  try {
    // Crear proyecto Vite usando npm create
    await execa('npm', [
      'create',
      'vite@latest',
      config.name,
      '--',
      '--template',
      'react-ts'
    ], {
      cwd: process.cwd(),
      stdio: 'pipe'
    });

    spinner.text = 'Proyecto base con Vite creado';
  } catch (error: any) {
    throw new Error(`Error al crear proyecto con Vite: ${error.message}`);
  }
}
