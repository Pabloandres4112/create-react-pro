@echo off
REM ================================================
REM   SCRIPT 07: INSTALACIÓN DE PAQUETES
REM   Ejecuta npm install
REM ================================================

setlocal enabledelayedexpansion
chcp 65001 >nul

color 0A

echo ⏳ Instalando dependencias con npm...
echo.
echo Esto puede tardar algunos minutos...
echo.

npm install

if errorlevel 1 (
    color 0C
    echo  Error durante la instalación
    exit /b 1
)

color 0A
echo.
echo  Dependencias instaladas correctamente
echo.

exit /b 0
