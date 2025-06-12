# Arch Linux Minimal Setup for ThinkPad X1 Tablet Gen 1

Este repositorio contiene una instalación automatizada, mínima y optimizada de Arch Linux con GNOME para la **ThinkPad X1 Tablet Gen 1**.

---

## 🧰 Contenido

- `install_arch_gnome_x1tablet.sh`: Script de instalación base de Arch + GNOME.
- `postinstall_gnome_x1tablet.sh`: Script postinstalación con software esencial, dotfiles y configuraciones.
- `dotfiles/`: Configuración de terminal (zsh + starship), tema visual GNOME (Nordic), y preferencias de interfaz.
- `README.md`: Este archivo 😉

---

## ⚙️ Requisitos

- ThinkPad X1 Tablet Gen 1  
- Conexión a internet  
- UEFI habilitado  
- Particiones manuales preparadas  
  (Recomendado: `/boot`, `/`, `swap` si deseas)

---

## 🧱 Instalación base (Arch + GNOME)

1. Arranca desde el medio de instalación de Arch.
2. Clona este repositorio:
   ```bash
   git clone https://github.com/LeoJLegnar/arch_x1tablet_setup.git
   cd arch_x1tablet_setup
   ```
3. Ejecuta el script de instalación:
   ```bash
   chmod +x install_arch_gnome_x1tablet.sh
   ./install_arch_gnome_x1tablet.sh
   ```

---

## 🚀 Postinstalación (software, tema, gestos, perfiles dock/tablet)

Después del primer reinicio e inicio de sesión:

```bash
cd ~/arch_x1tablet_setup
chmod +x postinstall_gnome_x1tablet.sh
./postinstall_gnome_x1tablet.sh
```

Este script:

- Instala: Krita, Flatpak, GNOME Tweaks, zsh, starship, extensiones GNOME, touchegg, etc.
- Aplica tema **Nordic** + íconos **Nordzy-dark**.
- Configura gestos multitáctiles (touchegg) y mejora el soporte para stylus.
- Aplica dotfiles y cambia el shell por `zsh`.
- Configura perfiles de energía:
  - **Modo Dock** = rendimiento.
  - **Modo Tablet** = ahorro de energía.
- Incluye detección automática vía `udev` y comandos manuales:
  ```bash
  switch-to-dock
  switch-to-tablet
  ```

---

## 🧩 Personalización

- Puedes modificar los archivos dentro de `dotfiles/` antes de ejecutar la postinstalación.
- El wallpaper no se incluye; puedes agregar el tuyo manualmente.
- El usuario por defecto es **leo**.

---

## 💡 Notas

- Compatible con pantalla principal 13" (2160x1440) y secundaria 42" 4K (modo dock).
- Si deseas soporte adicional o ajustes personalizados, edita el archivo `postinstall_gnome_x1tablet.sh`.

---

## 🐧 Licencia

MIT. Puedes copiar, modificar y compartir libremente.
