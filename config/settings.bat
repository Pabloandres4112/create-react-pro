@echo off
REM ================================================
REM   CONFIGURACIONES GLOBALES DEL SISTEMA
REM ================================================

REM Variables globales para toda la ejecución
set GENERATOR_VERSION=1.0
set GENERATOR_AUTHOR=Fenix Architecture
set GENERATOR_DATE=%date%

REM Colores y estilos
set SUCCESS=[92m
set ERROR=[91m
set INFO=[94m
set WARNING=[93m

REM Valores por defecto
set DEFAULT_AUTHOR=%username%

REM Validación de herramientas necesarias
where node >nul 2>&1
if errorlevel 1 (
    echo.
    echo  Node.js no está instalado o no está en PATH
    echo Descárgalo en https://nodejs.org
    echo.
    pause
    exit /b 1
)

where npm >nul 2>&1
if errorlevel 1 (
    echo.
    echo  npm no está instalado
    echo Instálalo junto con Node.js
    echo.
    pause
    exit /b 1
)

REM Verificar versiones (informativo)
for /f "tokens=*" %%i in ('node --version') do set NODE_VERSION=%%i
for /f "tokens=*" %%i in ('npm --version') do set NPM_VERSION=%%i

echo.
echo [INFO] Entorno detectado:
echo   └─ Node.js: %NODE_VERSION%
echo   └─ npm: %NPM_VERSION%
echo.

REM Crear variables de rutas
set TEMPLATES_PATH=%GENERATOR_PATH%templates
set SCRIPTS_PATH=%GENERATOR_PATH%scripts
set CONFIG_PATH=%GENERATOR_PATH%config

exit /b 0
