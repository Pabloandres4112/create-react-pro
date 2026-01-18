@echo off
REM ================================================
REM   SCRIPT 01: MENÚ INTERACTIVO
REM   Permite al usuario seleccionar tipo de proyecto
REM ================================================

setlocal enabledelayedexpansion
chcp 65001 >nul

cls
color 0A

echo.
echo ╔════════════════════════════════════════════════════════════╗
echo ║                                                            ║
echo ║          Selecciona el tipo de proyecto a crear:           ║
echo ║                                                            ║
echo ╚════════════════════════════════════════════════════════════╝
echo.
echo   1️⃣ Landing Page
echo      └─ Perfecto para presentación de servicios/productos
echo.
echo   2️⃣  E-commerce
echo      └─ Tienda completa con carrito y checkout
echo.
echo   3️⃣  Dashboard
echo      └─ Panel administrativo con gráficos y tablas
echo.
echo   4️⃣  Website Multi-página
echo      └─ Sitio web completo con varias secciones
echo.
echo   5️⃣  Personalizado
echo      └─ Estructura básica vacía para personalizar
echo.
echo   0️⃣  Salir
echo.
echo ════════════════════════════════════════════════════════════
echo.

set /p TEMPLATE_TYPE=" Selecciona una opción [1-5, 0 para salir]: "

if "%TEMPLATE_TYPE%"=="0" (
    echo.
    echo  Proceso cancelado por el usuario.
    exit /b 1
)

if "%TEMPLATE_TYPE%"=="1" (
    set TEMPLATE_TYPE=landing
    set TEMPLATE_NAME=Landing Page
    goto :validate
)

if "%TEMPLATE_TYPE%"=="2" (
    set TEMPLATE_TYPE=ecommerce
    set TEMPLATE_NAME=E-commerce
    goto :validate
)

if "%TEMPLATE_TYPE%"=="3" (
    set TEMPLATE_TYPE=dashboard
    set TEMPLATE_NAME=Dashboard
    goto :validate
)

if "%TEMPLATE_TYPE%"=="4" (
    set TEMPLATE_TYPE=website
    set TEMPLATE_NAME=Website Multi-página
    goto :validate
)

if "%TEMPLATE_TYPE%"=="5" (
    set TEMPLATE_TYPE=custom
    set TEMPLATE_NAME=Proyecto Personalizado
    goto :validate
)

echo  Opción inválida. Por favor selecciona entre 1-5 o 0.
timeout /t 2 >nul
call scripts\01_menu.bat
exit /b 0

:validate
echo.
echo  Seleccionado: %TEMPLATE_NAME%
echo.
timeout /t 1 >nul

endlocal & set TEMPLATE_TYPE=%TEMPLATE_TYPE%& set TEMPLATE_NAME=%TEMPLATE_NAME%
exit /b 0
