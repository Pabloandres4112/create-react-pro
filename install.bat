@echo off
REM Script de instalacion para Create React Pro CLI
REM Funciona en: Windows (CMD y PowerShell)

echo.
echo ======================================
echo  Instalando Create React Pro CLI
echo ======================================
echo.

REM Verificar Node.js
where node >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Node.js no esta instalado
    echo.
    echo Instala Node.js desde: https://nodejs.org/
    pause
    exit /b 1
)

echo [OK] Node.js detectado
node --version
echo.

REM Navegar al directorio del CLI
cd /d "%~dp0cli"

echo [1/3] Instalando dependencias...
call npm install
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Fallo al instalar dependencias
    pause
    exit /b 1
)

echo.
echo [2/3] Compilando TypeScript...
call npm run build
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Fallo al compilar
    pause
    exit /b 1
)

echo.
echo [3/3] Instalando CLI globalmente...
call npm install -g .
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Fallo al instalar globalmente
    echo Intenta ejecutar como Administrador
    pause
    exit /b 1
)

echo.
echo ======================================
echo  Instalacion completada!
echo ======================================
echo.
echo Proximos pasos:
echo   1. Ejecuta: create-react-pro create
echo   2. Sigue las instrucciones interactivas
echo   3. Comienza a desarrollar!
echo.
echo Ayuda: create-react-pro --help
echo Documentacion: cli\README.md
echo.
pause
