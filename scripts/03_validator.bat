@echo off
REM ================================================
REM   SCRIPT 03: VALIDACIÓN DE DATOS
REM   Verifica que todo sea correcto
REM ================================================

chcp 65001 >nul

color 0A

echo.
echo ⏳ Validando datos...
echo.

REM Validar nombre del proyecto
if "%PROJECT_NAME%"=="" (
    color 0C
    echo  ERROR: El nombre del proyecto no puede estar vacío
    exit /b 1
)

REM Validar longitud mínima
set "NOMBRE_TEMP=%PROJECT_NAME%"
if "%NOMBRE_TEMP:~2,1%"=="" (
    color 0C
    echo  ERROR: El nombre debe tener al menos 3 caracteres
    exit /b 1
)

REM Validar que no comience con número
set "FIRST_CHAR=%PROJECT_NAME:~0,1%"
set "IS_NUMBER=0"
if "%FIRST_CHAR%"=="0" set "IS_NUMBER=1"
if "%FIRST_CHAR%"=="1" set "IS_NUMBER=1"
if "%FIRST_CHAR%"=="2" set "IS_NUMBER=1"
if "%FIRST_CHAR%"=="3" set "IS_NUMBER=1"
if "%FIRST_CHAR%"=="4" set "IS_NUMBER=1"
if "%FIRST_CHAR%"=="5" set "IS_NUMBER=1"
if "%FIRST_CHAR%"=="6" set "IS_NUMBER=1"
if "%FIRST_CHAR%"=="7" set "IS_NUMBER=1"
if "%FIRST_CHAR%"=="8" set "IS_NUMBER=1"
if "%FIRST_CHAR%"=="9" set "IS_NUMBER=1"

if "%IS_NUMBER%"=="1" (
    color 0C
    echo  ERROR: El nombre no puede comenzar con un número
    exit /b 1
)

REM Verificar si la carpeta ya existe
if exist "%PROJECT_NAME%" (
    color 0C
    echo  ERROR: La carpeta "%PROJECT_NAME%" ya existe
    echo          Elige otro nombre para el proyecto
    exit /b 1
)

REM Validar que Node.js esté instalado
where node >nul 2>&1
if errorlevel 1 (
    color 0C
    echo  ERROR: Node.js no está instalado
    echo          Por favor instala Node.js desde https://nodejs.org
    exit /b 1
)

REM Validar que npm esté instalado
where npm >nul 2>&1
if errorlevel 1 (
    color 0C
    echo  ERROR: npm no está instalado
    exit /b 1
)

color 0A
echo  VALIDACIÓN EXITOSA
echo.
echo Parámetros verificados:
echo   • Nombre:        %PROJECT_NAME% ✓
echo   • Descripción:   %PROJECT_DESC% ✓
echo   • Autor:         %AUTHOR_NAME% ✓
echo   • Template:      %TEMPLATE_NAME% ✓
echo   • Node.js:       INSTALADO ✓
echo   • npm:           INSTALADO ✓
echo.

timeout /t 2 >nul

exit /b 0
