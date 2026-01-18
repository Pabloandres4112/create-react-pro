import chalk from 'chalk';

export function logError(message: string): void {
  console.log(chalk.red(`✖ ${message}`));
}

export function logSuccess(message: string): void {
  console.log(chalk.green(`✓ ${message}`));
}

export function logWarning(message: string): void {
  console.log(chalk.yellow(`⚠ ${message}`));
}

export function logInfo(message: string): void {
  console.log(chalk.cyan(`ℹ ${message}`));
}

export function logStep(message: string): void {
  console.log(chalk.blue(`→ ${message}`));
}
