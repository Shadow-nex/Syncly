<div align="center">

<img src="https://i.postimg.cc/xTm4n2jK/banner-waifu-tech.png" width="100%" alt="Banner Shadow-nex Script"/>

# 🌸🚀 **Sᴄʀɪᴘᴛ ᴅᴇ Aᴜᴛᴏᴍᴀᴛɪᴢᴀᴄɪᴏ́ɴ ᴘᴀʀᴀ Rᴇᴘᴏsɪᴛᴏʀɪᴏs Gɪᴛ** 🚀🌸  
### 💻 *Automatiza tu flujo de trabajo con estilo y poder* ⚡  

<img src="https://i.postimg.cc/SKvxqSFn/waifu-git-hot.png" width="420" alt="Waifu git"/>

</div>

---

> Este **script en Bash** automatiza el proceso de configuración, inicialización y subida de proyectos a un repositorio de **GitHub**.  
Es ideal para simplificar tareas comunes al trabajar con **Git** ⚡.

> si no le funciona ya valió jajaja 😅 xD

---

## ✨ Características

- 🔒 Configura la carpeta como un directorio seguro para Git.  
- 🌀 Inicializa un repositorio si no existe.  
- 📝 Agrega todos los archivos y realiza un **commit personalizado**.  
- 🌳 Configura la rama principal (`main`).  
- ☁️ Conecta con un remoto y sube el proyecto a **GitHub**.  

---

## 🔧 Requisitos

- **Git** y **cURL** instalados en tu sistema.  
- Un **Token de Acceso Personal de GitHub (PAT)** para autenticarte.  


### Instalación de Git y cURL

🔋 En **Linux**, puedes instalarlos con los siguientes comandos:

```bash
# Instalar Git
sudo apt update && sudo apt install git -y

# Instalar cURL
sudo apt install curl -y
```

⭐ En **Termux** (Android):

```bash
# Actualizar paquetes
pkg update && pkg upgrade -y

# Instalar Git
pkg install git -y

# Instalar cURL
pkg install curl -y
```

## Generar un Token de Acceso Personal en GitHub

1. Ve a [GitHub](https://github.com) e inicia sesión.
2. Dirígete a **Configuración** > **Developer Settings** > **Personal Access Tokens** > **Tokens (classic)**.
3. Haz clic en **Generate new token** y selecciona las siguientes configuraciones:
   - **Scope**: Selecciona `repo` para acceso completo al repositorio.
   - Opcional: Incluye `workflow` si usas GitHub Actions.
4. Haz clic en **Generate Token** y copia el token generado. Este será necesario para autenticarte.

**Nota:** Guarda tu token en un lugar seguro, ya que no podrás verlo nuevamente.

## Uso del Script

Para descargar y ejecutar el script, usa el siguiente comando:

```bash
curl -sSL https://raw.githubusercontent.com/Shadow-nex/Syncly/main/sube.sh -o sube.sh && bash sube.sh
```

### script v2 xD

```bash
curl -sSL https://ghproxy.net/https://raw.githubusercontent.com/Shadow-nex/Syncly/main/sube_v2.sh -o sube_v2.sh && bash sube_v2.sh
```

El script te pedirá:

1. La ruta de la carpeta que contiene tu proyecto.
2. La URL del repositorio remoto (formato: `https://github.com/usuario/repositorio.git`).
3. Un mensaje para el commit inicial.

El proceso se completará automáticamente.

## Notas

- Asegúrate de autenticarte correctamente cuando se te solicite tu usuario y contraseña. Usa el **token de acceso personal** como contraseña.
- Si encuentras problemas, verifica que las dependencias necesarias están instaladas y que tienes permisos de escritura en la carpeta de destino.
- 
