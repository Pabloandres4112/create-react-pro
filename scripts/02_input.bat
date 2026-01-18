@echo off
REM ================================================
REM   SCRIPT 02: CAPTURA DE DATOS DEL USUARIO
REM   Solicita información del proyecto
REM ================================================

setlocal enabledelayedexpansion
chcp 65001 >nul

color 0A

echo.
echo ╔════════════════════════════════════════════════════════════╗
echo ║                                                            ║
echo ║          Información del proyecto                          ║
echo ║                                                            ║
echo ╚════════════════════════════════════════════════════════════╝
echo.

REM Solicitar nombre del proyecto
:get_project_name
set /p PROJECT_NAME=" Nombre del proyecto [mi-proyecto]: "
if "!PROJECT_NAME!"=="" (
    set PROJECT_NAME=mi-proyecto
)

REM Solicitar descripción
set /p PROJECT_DESC=" Descripción [Proyecto web con React]: "
if "!PROJECT_DESC!"=="" (
    set PROJECT_DESC=Proyecto web con React
)

REM Solicitar autor
set /p AUTHOR_NAME="Autor [%username%]: "
if "!AUTHOR_NAME!"=="" (
    set AUTHOR_NAME=%username%
)

REM Confirmar datos
echo.
echo ════════════════════════════════════════════════════════════
echo Resumen de configuración:
echo ════════════════════════════════════════════════════════════
echo.
echo   Nombre:        %PROJECT_NAME%
echo   Descripción:   %PROJECT_DESC%
echo   Autor:         %AUTHOR_NAME%
echo   Template:      %TEMPLATE_NAME%
echo.
echo ════════════════════════════════════════════════════════════
echo.

set /p CONFIRM="¿Es correcto? [S/N]: "

if /i "!CONFIRM!"=="N" (
    echo Reintentando...
    goto :get_project_name
)

if /i "!CONFIRM!"=="S" (
    echo  Datos confirmados
    echo.
    timeout /t 1 >nul
    endlocal & set PROJECT_NAME=%PROJECT_NAME%& set PROJECT_DESC=%PROJECT_DESC%& set AUTHOR_NAME=%AUTHOR_NAME%
    exit /b 0
)

echo  Respuesta inválida.
goto :get_project_name
