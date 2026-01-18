export interface ProjectConfig {
  name: string;
  template: 'landing' | 'ecommerce' | 'dashboard';
  useVite: boolean;
  packageManager: 'npm' | 'pnpm' | 'yarn';
  setupGitHooks: boolean;
  skipInstall: boolean;
  description: string;
  author: string;
  targetPath: string;
}

export interface TemplateInfo {
  name: string;
  description: string;
  value: string;
}

export interface PackageManagerInfo {
  name: string;
  lockFile: string;
  installCommand: string;
  available: boolean;
}
