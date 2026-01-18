@echo off
REM ================================================
REM   SCRIPT 04: GENERADOR PRINCIPAL
REM   Orquesta la creación del proyecto
REM ================================================

setlocal enabledelayedexpansion
chcp 65001 >nul

color 0A

echo.
echo ╔════════════════════════════════════════════════════════════╗
echo ║                                                            ║
echo ║           Creando proyecto React...                      ║
echo ║                                                            ║
echo ╚════════════════════════════════════════════════════════════╝
echo.

REM Crear carpeta principal del proyecto
mkdir "!PROJECT_NAME!"
cd "!PROJECT_NAME!"

echo  Carpeta principal creada
echo.

REM Ejecutar script de creación de carpetas
echo  Creando estructura de carpetas...
call "%~dp0..\scripts\05_folders.bat"
if errorlevel 1 (
    color 0C
    echo  Error en creación de carpetas
    exit /b 1
)

echo.
echo  Generando archivos de configuración...
call "%~dp0..\scripts\06_files.bat"
if errorlevel 1 (
    color 0C
    echo  Error en generación de archivos
    exit /b 1
)

echo.
echo  Instalando dependencias...
call "%~dp0..\scripts\07_packages.bat"
if errorlevel 1 (
    color 0C
    echo  Error en instalación de paquetes
    exit /b 1
)

echo.
echo  Finalizando setup...
call "%~dp0..\scripts\08_finalize.bat"
if errorlevel 1 (
    color 0C
    echo  Error en finalización
    exit /b 1
)

exit /b 0
