@echo off
REM ================================================
REM   SCRIPT 05: CREACIÓN DE ESTRUCTURA DE CARPETAS
REM   Crea todas las carpetas necesarias
REM ================================================

setlocal enabledelayedexpansion
chcp 65001 >nul

echo ├─ public/
mkdir public

echo ├─ src/
mkdir src
mkdir src\components
mkdir src\pages
mkdir src\assets
mkdir src\assets\images
mkdir src\assets\fonts
mkdir src\assets\icons
mkdir src\hooks
mkdir src\contexts
mkdir src\features
mkdir src\services
mkdir src\utils
mkdir src\types
mkdir src\styles

echo ├─ .vscode/
mkdir .vscode

echo.
echo  Estructura de carpetas creada
echo.

exit /b 0
