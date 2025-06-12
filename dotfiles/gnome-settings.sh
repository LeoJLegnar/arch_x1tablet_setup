
#!/bin/bash
# Aplicación de configuraciones GNOME vía gsettings

gsettings set org.gnome.desktop.interface gtk-theme 'Nordic'
gsettings set org.gnome.desktop.interface icon-theme 'Nordzy-dark'
gsettings set org.gnome.desktop.interface cursor-theme 'Adwaita'
gsettings set org.gnome.desktop.interface font-name 'Cantarell 11'
gsettings set org.gnome.desktop.interface enable-animations true
gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true
gsettings set org.gnome.desktop.interface scaling-factor 2
gsettings set org.gnome.desktop.wm.preferences button-layout 'appmenu:minimize,maximize,close'
