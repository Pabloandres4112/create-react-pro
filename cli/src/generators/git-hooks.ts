import { execa } from 'execa';
import { writeFileSync, readFileSync } from 'fs';
import { join } from 'path';
import chalk from 'chalk';
import type { ProjectConfig } from '../types/index.js';

export async function setupGitHooks(config: ProjectConfig, spinner: any): Promise<void> {
  spinner.text = 'Configurando Git hooks (Husky + lint-staged + commitlint)...';

  try {
    const projectPath = config.targetPath;
    const pm = config.packageManager;

    // Agregar dependencias al package.json
    const packageJsonPath = join(projectPath, 'package.json');
    const packageJson = JSON.parse(readFileSync(packageJsonPath, 'utf-8'));

    packageJson.devDependencies = {
      ...packageJson.devDependencies,
      'husky': '^9.0.10',
      'lint-staged': '^15.2.2',
      '@commitlint/cli': '^18.6.1',
      '@commitlint/config-conventional': '^18.6.2',
      'eslint': '^8.56.0',
      'prettier': '^3.2.5',
      '@typescript-eslint/eslint-plugin': '^6.21.0',
      '@typescript-eslint/parser': '^6.21.0'
    };

    // Agregar scripts de Husky
    packageJson.scripts = {
      ...packageJson.scripts,
      'prepare': 'husky',
      'lint': 'eslint . --ext .ts,.tsx',
      'format': 'prettier --write "src/**/*.{ts,tsx,css}"'
    };

    // Configurar lint-staged
    packageJson['lint-staged'] = {
      '*.{ts,tsx}': [
        'eslint --fix',
        'prettier --write'
      ],
      '*.{css,md,json}': [
        'prettier --write'
      ]
    };

    writeFileSync(packageJsonPath, JSON.stringify(packageJson, null, 2));

    // Instalar Husky y dependencias si no se saltó la instalación
    if (!config.skipInstall) {
      spinner.text = 'Instalando dependencias de Git hooks...';
      
      const installArgs = pm === 'yarn' ? ['add', '-D'] : ['install', '-D'];
      const deps = [
        'husky',
        'lint-staged',
        '@commitlint/cli',
        '@commitlint/config-conventional',
        'prettier'
      ];

      await execa(pm, [...installArgs, ...deps], {
        cwd: projectPath,
        stdio: 'pipe'
      });

      // Inicializar Husky
      await execa(pm, pm === 'npm' ? ['run', 'prepare'] : ['prepare'], {
        cwd: projectPath,
        stdio: 'pipe'
      });
    }

    // Crear archivo de configuración de commitlint
    const commitlintConfig = `export default {
  extends: ['@commitlint/config-conventional'],
  rules: {
    'type-enum': [
      2,
      'always',
      [
        'feat',     // Nueva característica
        'fix',      // Corrección de bug
        'docs',     // Cambios en documentación
        'style',    // Cambios de formato (sin afectar código)
        'refactor', // Refactorización
        'perf',     // Mejora de rendimiento
        'test',     // Agregar o modificar tests
        'chore',    // Cambios en build, herramientas, etc.
        'revert',   // Revertir un commit anterior
        'ci',       // Cambios en CI/CD
      ],
    ],
    'subject-case': [0], // Permitir cualquier caso en el subject
  },
};
`;
    writeFileSync(join(projectPath, 'commitlint.config.js'), commitlintConfig);

    // Crear .husky/pre-commit
    const preCommitHook = `#!/usr/bin/env sh
. "$(dirname -- "$0")/_/husky.sh"

npx lint-staged
`;
    writeFileSync(join(projectPath, '.husky', 'pre-commit'), preCommitHook);

    // Crear .husky/commit-msg
    const commitMsgHook = `#!/usr/bin/env sh
. "$(dirname -- "$0")/_/husky.sh"

npx --no -- commitlint --edit \${1}
`;
    writeFileSync(join(projectPath, '.husky', 'commit-msg'), commitMsgHook);

    // Crear .prettierrc
    const prettierConfig = {
      semi: true,
      trailingComma: 'es5',
      singleQuote: true,
      printWidth: 100,
      tabWidth: 2,
      useTabs: false
    };
    writeFileSync(
      join(projectPath, '.prettierrc'),
      JSON.stringify(prettierConfig, null, 2)
    );

    // Crear .eslintrc.cjs
    const eslintConfig = `module.exports = {
  root: true,
  env: { browser: true, es2020: true },
  extends: [
    'eslint:recommended',
    'plugin:@typescript-eslint/recommended',
    'plugin:react-hooks/recommended',
  ],
  ignorePatterns: ['dist', '.eslintrc.cjs'],
  parser: '@typescript-eslint/parser',
  plugins: ['react-refresh'],
  rules: {
    'react-refresh/only-export-components': [
      'warn',
      { allowConstantExport: true },
    ],
    '@typescript-eslint/no-unused-vars': ['warn', { argsIgnorePattern: '^_' }],
  },
}
`;
    writeFileSync(join(projectPath, '.eslintrc.cjs'), eslintConfig);

    spinner.succeed('Git hooks configurados correctamente');
  } catch (error: any) {
    spinner.warn('No se pudieron configurar los Git hooks completamente');
    console.log(chalk.yellow(`Advertencia: ${error.message}`));
  }
}
