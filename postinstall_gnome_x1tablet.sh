#!/bin/bash
# Postinstalación Arch Linux para ThinkPad X1 Tablet Gen 1 + GNOME

set -e

echo "🔧 Actualizando el sistema..."
sudo pacman -Syu --noconfirm

echo "📦 Instalando paquetes esenciales..."
sudo pacman -S --noconfirm krita zsh starship touchegg gnome-tweaks git curl unzip flatpak xdg-desktop-portal-gnome     gnome-shell-extensions gnome-shell-extension-appindicator gnome-shell-extension-dash-to-dock     gnome-shell-extension-blur-my-shell power-profiles-daemon

echo "🧩 Activando touchegg..."
sudo systemctl enable touchegg.service
sudo systemctl start touchegg.service

echo "🎨 Aplicando tema y configuración GNOME..."
bash ./dotfiles/gnome-settings.sh

echo "⚙️ Instalando tema Nordic y Nordzy desde GNOME-Look..."
THEME_DIR="$HOME/.themes"
ICON_DIR="$HOME/.icons"
mkdir -p "$THEME_DIR" "$ICON_DIR"
cd /tmp

# Nordic theme
curl -LO https://github.com/EliverLara/Nordic/releases/download/v2.2.0/Nordic-darker-standard-buttons.tar.xz
tar -xf Nordic-darker-standard-buttons.tar.xz -C "$THEME_DIR"

# Nordzy icons
curl -LO https://github.com/alvatip/Nordzy-icon/releases/download/v2.2.0/Nordzy-dark.tar.xz
tar -xf Nordzy-dark.tar.xz -C "$ICON_DIR"

cd -

echo "🐚 Configurando terminal zsh + starship..."
cp dotfiles/.zshrc ~/
mkdir -p ~/.config
cp dotfiles/starship.toml ~/.config/starship.toml
chsh -s $(which zsh)

echo "🔌 Configurando detección de modo dock/tablet..."
mkdir -p ~/.local/bin
cat << EOF > ~/.local/bin/switch-to-dock
#!/bin/bash
echo "⚡ Cambiando a modo dock..."
powerprofilesctl set performance
EOF

cat << EOF > ~/.local/bin/switch-to-tablet
#!/bin/bash
echo "🔋 Cambiando a modo tablet..."
powerprofilesctl set power-saver
EOF

chmod +x ~/.local/bin/switch-to-*

echo "📦 Instalando servicio y regla para detección automática del dock..."
sudo tee /etc/udev/rules.d/99-x1tablet-dock.rules > /dev/null << 'EOF'
SUBSYSTEM=="usb", ATTR{idVendor}=="17ef", ATTR{idProduct}=="6047", ACTION=="add", RUN+="/usr/local/bin/dock_mode.sh dock"
SUBSYSTEM=="usb", ATTR{idVendor}=="17ef", ATTR{idProduct}=="6047", ACTION=="remove", RUN+="/usr/local/bin/dock_mode.sh tablet"
EOF

sudo tee /usr/local/bin/dock_mode.sh > /dev/null << 'EOF'
#!/bin/bash
export DISPLAY=:0
export XDG_RUNTIME_DIR=/run/user/1000
if [ "$1" = "dock" ]; then
    sudo -u leo /home/leo/.local/bin/switch-to-dock
else
    sudo -u leo /home/leo/.local/bin/switch-to-tablet
fi
EOF
sudo chmod +x /usr/local/bin/dock_mode.sh
sudo udevadm control --reload-rules

echo "✅ Postinstalación completa. Reinicia para aplicar todos los cambios."
