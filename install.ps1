# Script de Instalación PowerShell para Create React Pro CLI
# Funciona en: Windows PowerShell 5.1+ y PowerShell Core 7+

Write-Host ""
Write-Host "======================================"  -ForegroundColor Cyan
Write-Host " Instalando Create React Pro CLI"  -ForegroundColor Cyan
Write-Host "======================================"  -ForegroundColor Cyan
Write-Host ""

# Verificar Node.js
try {
    $nodeVersion = node --version
    Write-Host "[OK] Node.js detectado: $nodeVersion" -ForegroundColor Green
    
    # Verificar versión mínima
    $versionNumber = [int]($nodeVersion -replace 'v(\d+)\..*', '$1')
    if ($versionNumber -lt 18) {
        Write-Host "[ERROR] Se requiere Node.js 18 o superior" -ForegroundColor Red
        Write-Host "Version actual: $nodeVersion" -ForegroundColor Yellow
        Write-Host "Descarga desde: https://nodejs.org/" -ForegroundColor Yellow
        Read-Host "Presiona Enter para salir"
        exit 1
    }
} catch {
    Write-Host "[ERROR] Node.js no esta instalado" -ForegroundColor Red
    Write-Host "Descarga desde: https://nodejs.org/" -ForegroundColor Yellow
    Read-Host "Presiona Enter para salir"
    exit 1
}

Write-Host ""

# Navegar al directorio del CLI
$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location (Join-Path $scriptPath "cli")

# Instalar dependencias
Write-Host "[1/3] Instalando dependencias..." -ForegroundColor Yellow
npm install
if ($LASTEXITCODE -ne 0) {
    Write-Host "[ERROR] Fallo al instalar dependencias" -ForegroundColor Red
    Read-Host "Presiona Enter para salir"
    exit 1
}

Write-Host ""

# Compilar TypeScript
Write-Host "[2/3] Compilando TypeScript..." -ForegroundColor Yellow
npm run build
if ($LASTEXITCODE -ne 0) {
    Write-Host "[ERROR] Fallo al compilar" -ForegroundColor Red
    Read-Host "Presiona Enter para salir"
    exit 1
}

Write-Host ""

# Instalar globalmente
Write-Host "[3/3] Instalando CLI globalmente..." -ForegroundColor Yellow
npm install -g .
if ($LASTEXITCODE -ne 0) {
    Write-Host "[ERROR] Fallo al instalar globalmente" -ForegroundColor Red
    Write-Host "Intenta ejecutar PowerShell como Administrador" -ForegroundColor Yellow
    Read-Host "Presiona Enter para salir"
    exit 1
}

Write-Host ""
Write-Host "======================================"  -ForegroundColor Green
Write-Host " Instalacion completada!"  -ForegroundColor Green
Write-Host "======================================"  -ForegroundColor Green
Write-Host ""
Write-Host "Proximos pasos:" -ForegroundColor Cyan
Write-Host "  1. Ejecuta: create-react-pro create" -ForegroundColor White
Write-Host "  2. Sigue las instrucciones interactivas" -ForegroundColor White
Write-Host "  3. Comienza a desarrollar!" -ForegroundColor White
Write-Host ""
Write-Host "Ayuda: create-react-pro --help" -ForegroundColor Yellow
Write-Host "Documentacion: cli\README.md" -ForegroundColor Yellow
Write-Host ""

Read-Host "Presiona Enter para continuar"
