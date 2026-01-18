@echo off
REM ================================================
REM   UTILIDADES
REM   Funciones reutilizables
REM ================================================

setlocal enabledelayedexpansion

REM ===== FUNCIÓN: Validar si existe comando =====
REM Uso: call :is_installed "node"
:is_installed
where %~1 >nul 2>&1
if errorlevel 1 (
    exit /b 1
) else (
    exit /b 0
)

REM ===== FUNCIÓN: Crear archivo =====
REM Uso: call :create_file "ruta\archivo.txt" "contenido"
:create_file
(
    echo %~2
) > %~1
exit /b 0

REM ===== FUNCIÓN: Mostrar error =====
REM Uso: call :show_error "Mensaje de error"
:show_error
color 0C
echo  %~1
color 0A
exit /b 1

REM ===== FUNCIÓN: Mostrar éxito =====
REM Uso: call :show_success "Mensaje de éxito"
:show_success
echo  %~1
exit /b 0

REM ===== FUNCIÓN: Mostrar información =====
REM Uso: call :show_info "Mensaje informativo"
:show_info
echo   %~1
exit /b 0

exit /b 0
