#!/bin/sh

#
# Script para instalar Hyprland y dependencias
# 
# Nota: Por ahora solo esta soportado archlinux
#

HYPR_BASEDIR=$(dirname "$0")

LOCALE="LANG=es_ES.UTF-8"

WAYBAR_THEME="catpuccin-mocha.css"
ROFI_THEME="catppuccin-mocha.rasi"

echo " -- INSTALADOR HYPRLAND --"

# Comprobar la distro
if uname -a | grep arch > /dev/null 2>&1
then
  echo " + Arch linux detectado"
  DISTRO="Arch"
else
  echo "Este script no es compatible con tu distro."
  echo "Saliendo ..."
  exit 1
fi

printf "%s" "Instalar paquetes? (s/n): "
read install_packages

if test "$install_packages" = "s"
then
  echo " + Instalando paquetes ..."
  if test $DISTRO = "Arch"
  then
    DEPS="hyprland kitty hyprpaper rofi-wayland noto-fonts waybar gtk3 gvfs
          otf-font-awesome ttf-fantasque-nerd hyprlock hypridle pavucontrol
          xdg-desktop-portal-hyprland thunar pipewire wireplumber mako
          libnotify ttf-daddytime-mono-nerd hyprpolkitagent python-pillow
          highlight ttf-nerd-fonts-symbols wl-clipboard udiskie"
    AUR_DEPS="wlogout"

    sudo pacman -S --needed $DEPS

    if ! which yay > /dev/null 2>&1
    then
      sudo pacman -S --needed git base-devel
      git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si
      cd .. && rm -rf yay
    fi

    yay -S --needed $AUR_DEPS
  fi
fi

echo " + Copiando config ..."

# Locale
echo "$LOCALE" > "${HOME}/.config/locale.conf"

mkdir -p "${HOME}/.config/hypr/"
mkdir -p "${HOME}/.config/waybar/"
mkdir -p "${HOME}/.config/rofi/"
mkdir -p "${HOME}/.local/share/rofi/themes/"
mkdir -p "${HOME}/.config/wlogout/"
mkdir -p "${HOME}/.config/mako/"
mkdir -p "${HOME}/.config/ranger/"

# Hyprland
cp -f "$HYPR_BASEDIR/../config/hypr/hyprland.conf" "${HOME}/.config/hypr/hyprland.conf"
cp -f "$HYPR_BASEDIR/../config/hypr/hyprpaper.conf" "${HOME}/.config/hypr/hyprpaper.conf"
cp -f "$HYPR_BASEDIR/../config/hypr/hyprlock.conf" "${HOME}/.config/hypr/hyprlock.conf"
cp -f "$HYPR_BASEDIR/../config/hypr/hypridle.conf" "${HOME}/.config/hypr/hypridle.conf"
cp -f "$HYPR_BASEDIR/../config/hypr/theme.conf" "${HOME}/.config/hypr/theme.conf"

# Waybar
cp -f "$HYPR_BASEDIR/../config/waybar/config" "${HOME}/.config/waybar/config"
cp -f "$HYPR_BASEDIR/../config/waybar/style.css" "${HOME}/.config/waybar/style.css"
cp -f "$HYPR_BASEDIR/../config/waybar/$WAYBAR_THEME" "${HOME}/.config/waybar/colorscheme.css"

# Rofi
cp -f "$HYPR_BASEDIR/../config/rofi/config.rasi" "${HOME}/.config/rofi/config.rasi"
cp -f "$HYPR_BASEDIR/../local/share/rofi/themes/$ROFI_THEME" "${HOME}/.local/share/rofi/themes/$ROFI_THEME"

# Wlogout
cp -f "$HYPR_BASEDIR/../config/wlogout/style.css" "${HOME}/.config/wlogout/style.css"

# Mako notifications
cp -f "$HYPR_BASEDIR/../config/mako/config" "${HOME}/.config/mako/config"

# Ranger
cp -f "$HYPR_BASEDIR/../config/ranger/rc.conf" "${HOME}/.config/ranger/rc.conf"

if ! test -d "${HOME}/.config/ranger/plugins/ranger_devicons"
then
  git clone https://github.com/alexanderjeurissen/ranger_devicons ~/.config/ranger/plugins/ranger_devicons
fi
