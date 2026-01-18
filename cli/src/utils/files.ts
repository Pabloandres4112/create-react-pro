import { readFileSync, writeFileSync } from 'fs';
import { join } from 'path';

export function updatePackageJson(
  projectPath: string,
  updates: Record<string, any>
): void {
  const packageJsonPath = join(projectPath, 'package.json');
  const packageJson = JSON.parse(readFileSync(packageJsonPath, 'utf-8'));

  const updatedPackageJson = {
    ...packageJson,
    ...updates,
    scripts: {
      ...packageJson.scripts,
      ...updates.scripts,
    },
    devDependencies: {
      ...packageJson.devDependencies,
      ...updates.devDependencies,
    },
    dependencies: {
      ...packageJson.dependencies,
      ...updates.dependencies,
    },
  };

  writeFileSync(
    packageJsonPath,
    JSON.stringify(updatedPackageJson, null, 2)
  );
}

export function addScriptToPackageJson(
  projectPath: string,
  scriptName: string,
  scriptCommand: string
): void {
  const packageJsonPath = join(projectPath, 'package.json');
  const packageJson = JSON.parse(readFileSync(packageJsonPath, 'utf-8'));

  packageJson.scripts = {
    ...packageJson.scripts,
    [scriptName]: scriptCommand,
  };

  writeFileSync(
    packageJsonPath,
    JSON.stringify(packageJson, null, 2)
  );
}
