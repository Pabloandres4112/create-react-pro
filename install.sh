#!/bin/bash

# Script de instalación para Create React Pro CLI
# Funciona en: Linux, macOS, WSL, Git Bash

set -e  # Salir si hay error

echo " Instalando Create React Pro CLI..."
echo ""

# Verificar Node.js
if ! command -v node &> /dev/null; then
    echo " Error: Node.js no está instalado"
    echo " Instala Node.js desde: https://nodejs.org/"
    exit 1
fi

NODE_VERSION=$(node -v | cut -d'v' -f2 | cut -d'.' -f1)
if [ "$NODE_VERSION" -lt 18 ]; then
    echo " Error: Se requiere Node.js 18 o superior"
    echo " Versión actual: $(node -v)"
    echo " Actualiza desde: https://nodejs.org/"
    exit 1
fi

echo " Node.js $(node -v) detectado"
echo ""

# Navegar al directorio del CLI
cd "$(dirname "$0")/cli"

echo " Instalando dependencias..."
npm install

echo ""
echo " Compilando TypeScript..."
npm run build

echo ""
echo " Instalando CLI globalmente..."
npm install -g .

echo ""
echo " ¡Instalación completada!"
echo ""
echo " Próximos pasos:"
echo "  1. Ejecuta: create-react-pro create"
echo "  2. Sigue las instrucciones interactivas"
echo "  3. ¡Comienza a desarrollar!"
echo ""
echo " Ayuda: create-react-pro --help"
echo " Documentación: cli/README.md"
echo ""
