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

loading() {
    msg=$1
    echo -ne " ${YELLOW}${msg}${RESET}"
    for i in {1..3}; do echo -ne "."; sleep 0.4; done
    echo ""
    beep
}

typewriter() {
    text=$1
    for (( i=0; i<${#text}; i++ )); do
        echo -ne " ${CYAN}${text:$i:1}${RESET}"
        sleep 0.03
    done
    echo ""
}

progress_bar() {
    msg=$1
    echo -e "${MAGENTA}${msg}${RESET}\n"
    bar="===================="
    for i in $(seq 1 20); do
        echo -ne " [ ${GREEN}${bar:0:i}${WHITE}${bar:i}] $((i*5))% \r"
        sleep 0.08
    done
    echo -e "\n ${GREEN}✔ Completado${RESET}\n"
    beep
}

spinner() {
    msg=$1
    spin='⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏'
    i=0
    while kill -0 $! 2>/dev/null; do
        i=$(( (i+1) %10 ))
        printf "\r${PINK}${msg} ${spin:$i:1}${RESET}"
        sleep 0.1
    done
    echo ""
    beep
}

progress_gitpush() {
    echo -e "${ORANGE}⭐ Subiendo archivos a GitHub...${RESET}"
    git push -u origin main &> push.log &
    spinner "⏳ Enviando datos a GitHub..."
    wait
    if grep -q "fatal" push.log; then
        echo -e "\n${RED}❌ Error al subir a GitHub.${RESET}"
        echo -e "${YELLOW}⚠️ Verifica tu token o conexión a internet.${RESET}"
        grep "fatal" push.log
        rm -f push.log
        exit 1
    fi
    rm -f push.log
    echo -e "\n ${GREEN}✔ Push completado con éxito${RESET}"
    beep
}

banner() {
    clear
    echo -e "${PURPLE}"
    echo "╔═════════════════════════════════════════════╗"
    echo "║                                             ║"
    echo "║    ██████╗  ██╗████████╗ ██╗  ██╗ ██████╗   ║"
    echo "║   ██╔═══██╗ ██║╚══██╔══╝ ██║  ██║ ██╔══██╗  ║"
    echo "║   ██║   ██║ ██║   ██║    ███████║ ██████╔╝  ║"
    echo "║   ██║▄▄ ██║ ██║   ██║    ██╔══██║ ██╔═══╝   ║"
    echo "║   ╚██████╔╝ ██║   ██║    ██║  ██║ ██║       ║"
    echo "║    ╚══▀▀═╝  ╚═╝   ╚═╝    ╚═╝  ╚═╝ ╚═╝       ║"
    echo "║                                             ║"
    echo "║                   Shadow_xyz                     ║"
    echo "╚═════════════════════════════════════════════╝"
    echo -e "${RESET}"
    beep
}

separator() { echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"; }

epic_finish() {
    echo -e "${GREEN}"
    echo "╔═══════════════════════════════════════╗"
    echo "║   ✅ INSTALACIÓN FINALIZADA CON ÉXITO ║"
    echo "╠═══════════════════════════════════════╣"
    echo "║   🌍 Repositorio subido a GitHub 🚀   ║"
    echo "║   ✨ Gracias por usar Shadow.xyz ✨    ║"
    echo "╚═══════════════════════════════════════╝"
    echo -e "${RESET}"
    beep
    separator
    typewriter "🌟 Proyecto listo para la acción! 🌟"
    echo -e "${CYAN}👉 GitHub: https://github.com/Yuji-XDev/${RESET}"
    echo -e "${ORANGE}⚡ Shadow.xyz 💥${RESET}"
    separator
    beep
}

# ====== INICIO ======
banner
typewriter "✨ Bienvenido al instalador mágico de Shadow.xyz ✨"
loading "⚽ Preparando entorno"
sleep 0.5
echo ""

read -p "🍂 Ruta de la carpeta: " folder_path
read -p "🌱 URL del repositorio (https://github.com/usuario/repositorio.git): " repo_url

if [ ! -d "$folder_path" ]; then
  echo -e "${RED}❌ Error: Carpeta no encontrada.${RESET}"
  beep
  exit 1
fi

cd "$folder_path" || exit

# ====== CONFIGURAR GIT AUTOMÁTICAMENTE ======
user_name=$(git config --global user.name)
user_email=$(git config --global user.email)
cred_helper=$(git config --global credential.helper)

if [ -z "$user_name" ]; then
  read -p "🧑 Nombre de usuario de GitHub: " git_user
  git config --global user.name "$git_user"
else
  echo -e "${GREEN}✅ Usuario detectado: ${CYAN}$user_name${RESET}"
fi

if [ -z "$user_email" ]; then
  read -p "📧 Correo de GitHub: " git_email
  git config --global user.email "$git_email"
else
  echo -e "${GREEN}✅ Correo detectado: ${CYAN}$user_email${RESET}"
fi

if [ -z "$cred_helper" ]; then
  echo -e "${YELLOW}🔑 No hay credenciales guardadas. Se solicitará token...${RESET}"
  echo -e "${CYAN}👉 Crea uno aquí: https://github.com/settings/tokens${RESET}"
  read -p "🔐 Token de GitHub: " gh_token
  git config --global credential.helper store
  user_for_token=${git_user:-$user_name}
  echo "https://${user_for_token}:${gh_token}@github.com" > ~/.git-credentials
else
  echo -e "${GREEN}🔐 Credenciales ya configuradas.${RESET}"
fi

# ====== SUBIR A GITHUB ======
progress_bar "⚙️ Añadiendo directorio seguro"
git config --global --add safe.directory "$folder_path"

if [ ! -d ".git" ]; then
  progress_bar "📂 Inicializando repositorio"
  git init &>/dev/null
fi

progress_bar "📦 Agregando archivos"
git add . &>/dev/null

read -p "☘️ Mensaje del commit: " commit_message
progress_bar "📝 Realizando commit"
git commit -m "$commit_message" &>/dev/null

progress_bar "🌱 Configurando rama main"
git branch -M main &>/dev/null

progress_bar "🔗 Configurando remoto"
git remote remove origin &>/dev/null
git remote add origin "$repo_url" &>/dev/null

progress_gitpush
epic_finish