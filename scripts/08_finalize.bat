@echo off
REM ================================================
REM   SCRIPT 08: FINALIZACIÓN
REM   Últimos pasos y resumen
REM ================================================

setlocal enabledelayedexpansion
chcp 65001 >nul

color 0A

echo.
echo ╔════════════════════════════════════════════════════════════╗
echo ║                                                            ║
echo ║               ¡PROYECTO CREADO EXITOSAMENTE!           ║
echo ║                                                            ║
echo ╚════════════════════════════════════════════════════════════╝
echo.

REM Git init (opcional)
echo Inicializando repositorio Git...
git init >nul 2>&1

if errorlevel 1 (
    echo   Git no está disponible, saltando inicialización
) else (
    echo  Repositorio Git inicializado
)

echo.
echo ════════════════════════════════════════════════════════════
echo  RESUMEN DEL PROYECTO
echo ════════════════════════════════════════════════════════════
echo.
echo   Nombre:        !PROJECT_NAME!
echo   Descripción:   !PROJECT_DESC!
echo   Autor:         !AUTHOR_NAME!
echo   Ubicación:     %CD%
echo.
echo ════════════════════════════════════════════════════════════
echo  PRÓXIMOS PASOS
echo ════════════════════════════════════════════════════════════
echo.
echo   1. Abre VS Code:
echo      code .
echo.
echo   2. Inicia el servidor de desarrollo:
echo      npm run dev
echo.
echo   3. Comienza a editar src/App.tsx
echo.
echo ════════════════════════════════════════════════════════════
echo.

set /p OPEN_VSC="¿Abrir VS Code? [S/N]: "

if /i "!OPEN_VSC!"=="S" (
    code .
)

echo.
echo  ¡Listo! Tu proyecto React está preparado
echo.

exit /b 0
