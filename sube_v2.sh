#!/bin/bash

# ====== COLORES ======
RED="\033[1;31m"
GREEN="\033[1;32m"
YELLOW="\033[1;33m"
BLUE="\033[1;34m"
MAGENTA="\033[1;35m"
CYAN="\033[1;36m"
WHITE="\033[1;37m"
ORANGE="\033[38;5;208m"
PINK="\033[38;5;213m"
PURPLE="\033[38;5;93m"
RESET="\033[0m"

# ====== FUNCIONES ======
beep() { echo -ne "\007"; tput bel 2>/dev/null || true; }

typewriter() {
    text=$1
    for (( i=0; i<${#text}; i++ )); do
        echo -ne "${PINK}${text:$i:1}${RESET}"
        sleep 0.02
    done
    echo ""
}

progress() {
    msg=$1
    echo -ne "${CYAN}${msg}${RESET}"
    for i in {1..3}; do echo -ne "."; sleep 0.3; done
    echo ""
}

error_msg() { echo -e "${RED}❌ $1${RESET}"; beep; }
success_msg() { echo -e "${GREEN}✔ $1${RESET}"; beep; }

banner() {
    clear
    echo -e "${PURPLE}"
    echo "╔════════════════════════════════════════════╗"
    echo "║     🚀  SHADOW.XYZ - PUSH ASSISTANT V2     ║"
    echo "╚════════════════════════════════════════════╝"
    echo -e "${RESET}"
}

# ====== INICIO ======
banner
typewriter "✨ Bienvenido al asistente mejorado de subida a GitHub ✨"
echo ""

read -p "$(echo -e ${YELLOW}'📁 Ruta de la carpeta del proyecto: '${RESET})" folder_path
if [ ! -d "$folder_path" ]; then
    error_msg "La carpeta no existe. Revisa la ruta."
    exit 1
fi
cd "$folder_path" || exit

read -p "$(echo -e ${GREEN}'🌍 URL del repositorio (https://github.com/usuario/repo.git): '${RESET})" repo_url

if [ -z "$repo_url" ]; then
    error_msg "No se ingresó una URL de repositorio."
    exit 1
fi

progress "⚙️ Preparando entorno"
git config --global --add safe.directory "$folder_path"

if [ ! -d ".git" ]; then
    progress "📂 Inicializando repositorio Git"
    git init &>/dev/null
    success_msg "Repositorio inicializado."
fi

# Eliminar remoto antiguo si existe
if git remote get-url origin &>/dev/null; then
    echo -e "${YELLOW}🔄 Ya existe un remoto configurado. Reemplazando...${RESET}"
    git remote remove origin &>/dev/null
fi

git remote add origin "$repo_url" &>/dev/null
progress "🧩 Agregando archivos"
git add . &>/dev/null

read -p "$(echo -e ${PINK}'📝 Mensaje del commit: '${RESET})" commit_message
if [ -z "$commit_message" ]; then commit_message="Auto commit by Shadow v2"; fi

git commit -m "$commit_message" &>/dev/null || echo -e "${YELLOW}⚠ Nada nuevo para commitear.${RESET}"
git branch -M main &>/dev/null

# ===== PUSH CON MANEJO DE ERRORES =====
progress "🚀 Enviando a GitHub..."

if ! git push -u origin main 2>push_error.log; then
    echo ""
    error_msg "Error durante el push inicial."

    if grep -q "Authentication failed" push_error.log; then
        echo -e "${YELLOW}🔐 Parece que Git necesita autenticación.${RESET}"
        read -p "$(echo -e ${CYAN}'¿Deseas usar un token personal de GitHub? (s/n): '${RESET})" use_token
        if [[ "$use_token" =~ ^[sS]$ ]]; then
            read -p "$(echo -e ${MAGENTA}'🔑 Ingresa tu token PAT: '${RESET})" token
            read -p "$(echo -e ${GREEN}'👤 Usuario de GitHub: '${RESET})" user
            token_repo_url="${repo_url/https:\/\//https:\/\/$user:$token@}"
            progress "🔗 Reintentando push con token..."
            git remote set-url origin "$token_repo_url"
            if git push -u origin main; then
                success_msg "Push exitoso con autenticación por token."
            else
                error_msg "El push falló nuevamente. Verifica tu token o permisos."
                exit 1
            fi
        else
            error_msg "No se completó el push. Revisa tus credenciales de GitHub."
            exit 1
        fi
    else
        echo -e "${YELLOW}⚠ Revisa el archivo push_error.log para más detalles.${RESET}"
        exit 1
    fi
else
    success_msg "Proyecto subido correctamente 🎉"
fi

# ===== FINAL =====
echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
echo -e "${GREEN}✨ ¡Todo listo! Tu proyecto está en GitHub.${RESET}"
echo -e "${CYAN}👉 Sígueme en GitHub: ${YELLOW}https://github.com/Shadow-nex${RESET}"
echo -e "${ORANGE}⚡ Shadow.xyz - Powered Script v2 💥${RESET}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
beep