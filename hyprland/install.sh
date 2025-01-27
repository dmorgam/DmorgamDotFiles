#!/bin/sh

#
# Script para instalar Hyprland y dependencias
# 
# Nota: Por ahora solo esta soportado archlinux
#

HYPR_BASEDIR=$(dirname "$0")

WAYBAR_THEME="catpuccin-mocha.css"

echo " -- INSTALADOR HYPRLAND --"

# Comprobar la distro
if uname -a | grep archlinux > /dev/null 2>&1
then
  echo " + Arch linux detectado"
  DISTRO="Arch"
else
  echo "Este script no es compatible con tu distro."
  echo "Saliendo ..."
  exit 1
fi

echo " + Instalando paquetes ..."
if test $DISTRO = "Arch"
then
  DEPS="hyprland kitty hyprpaper rofi-wayland noto-fonts waybar gtk3 gtk4
        otf-font-awesome ttf-fantasque-nerd hyprlock hypridle pavucontrol
        xdg-desktop-portal-hyprland nautilus"
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

echo " + Copiando config ..."

mkdir -p "${HOME}/.config/hypr/"
mkdir -p "${HOME}/.config/waybar/"

cp -f "$HYPR_BASEDIR/hyprland.conf" "${HOME}/.config/hypr/hyprland.conf"
cp -f "$HYPR_BASEDIR/hyprpaper.conf" "${HOME}/.config/hypr/hyprpaper.conf"
cp -f "$HYPR_BASEDIR/hyprlock.conf" "${HOME}/.config/hypr/hyprlock.conf"
cp -f "$HYPR_BASEDIR/hypridle.conf" "${HOME}/.config/hypr/hypridle.conf"
cp -f "$HYPR_BASEDIR/waybar/config" "${HOME}/.config/waybar/config"
cp -f "$HYPR_BASEDIR/waybar/style.css" "${HOME}/.config/waybar/style.css"
cp -f "$HYPR_BASEDIR/waybar/$WAYBAR_THEME" "${HOME}/.config/waybar/colorscheme.css"
