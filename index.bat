@echo off
REM ================================================
REM    REACT.STRUCTURE - GENERADOR DE PROYECTOS
REM   Script principal - Orquestador
REM ================================================

setlocal enabledelayedexpansion
chcp 65001 >nul

cls
color 0A

echo.
echo ╔════════════════════════════════════════════════════════════╗
echo ║                                                            ║
echo ║    GENERADOR AUTOMATIZADO DE PROYECTOS REACT          ║
echo ║                 Professional Edition                       ║
echo ║                                                            ║
echo ╚════════════════════════════════════════════════════════════╝
echo.

REM Obtener directorio actual
set GENERATOR_PATH=%~dp0
cd /d "%GENERATOR_PATH%"

REM Cargar configuración global
call config\settings.bat
if errorlevel 1 goto :error

REM Ejecutar scripts en cadena
echo [1/5] Mostrando menú de opciones...
call scripts\01_menu.bat
if errorlevel 1 goto :error

echo [2/5] Capturando datos del proyecto...
call scripts\02_input.bat
if errorlevel 1 goto :error

echo [3/5] Validando información...
call scripts\03_validator.bat
if errorlevel 1 goto :error

echo [4/5] Generando estructura...
call scripts\04_generator.bat
if errorlevel 1 goto :error

echo [5/5] Finalizando...
call scripts\08_finalize.bat
if errorlevel 1 goto :error

goto :end

:error
echo.
echo  ERROR: La ejecución fue interrumpida.
echo El proyecto no se completó correctamente.
echo.
pause
exit /b 1

:end
echo.
echo ════════════════════════════════════════════════════════════
echo  ¡Proceso completado exitosamente!
echo ════════════════════════════════════════════════════════════
echo.
pause
endlocal
exit /b 0
