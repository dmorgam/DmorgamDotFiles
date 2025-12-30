#!/bin/sh

#
# Script para instalar Hyprland y dependencias
#
# Nota: Por ahora solo esta soportado archlinux
#

HYPR_BASEDIR=$(dirname "$0")
HYPR_INSTALL_YAML="${HYPR_BASEDIR}/install.yaml"

LOCALE="$(yq -r '.locale' "$HYPR_INSTALL_YAML" | xargs)"

WAYBAR_THEME="$(yq -r '.waybar_theme' "$HYPR_INSTALL_YAML" | xargs)"
ROFI_THEME="$(yq -r '.rofi_theme' "$HYPR_INSTALL_YAML" | xargs)"

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
    # Install yq to load yaml
    sudo pacman -S --needed yq

    DEPS="$(yq -r '.packages.arch.pacman[]' "$HYPR_INSTALL_YAML" | xargs)"
    AUR_DEPS="$(yq -r '.packages.arch.yay[]' "$HYPR_INSTALL_YAML" | xargs)"

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

# Xdg user dirs
cp -f "$HYPR_BASEDIR/../config/user-dirs.dirs" "${HOME}/.config/"
cp -f "$HYPR_BASEDIR/../config/user-dirs.locale" "${HOME}/.config/"

mkdir -p "${HOME}/.config/hypr/"
mkdir -p "${HOME}/.config/waybar/"
mkdir -p "${HOME}/.config/rofi/"
mkdir -p "${HOME}/.local/share/rofi/themes/"
mkdir -p "${HOME}/.config/wlogout/"
mkdir -p "${HOME}/.config/mako/"
mkdir -p "${HOME}/.config/ranger/"

# Hyprland
cp -r "$HYPR_BASEDIR/../config/hypr/" "${HOME}/.config/"

# Waybar
cp -r "$HYPR_BASEDIR/../config/waybar/" "${HOME}/.config/"

# Rofi
cp -r "$HYPR_BASEDIR/../config/rofi/" "${HOME}/.config/"
cp -f "$HYPR_BASEDIR/../local/share/rofi/themes/$ROFI_THEME" "${HOME}/.local/share/rofi/themes/$ROFI_THEME"

# Wlogout
cp -r "$HYPR_BASEDIR/../config/wlogout/" "${HOME}/.config/"

# Mako notifications
cp -r "$HYPR_BASEDIR/../config/mako/" "${HOME}/.config/"

# Ranger
cp -r "$HYPR_BASEDIR/../config/ranger/" "${HOME}/.config/"

if ! test -d "${HOME}/.config/ranger/plugins/ranger_devicons"
then
  git clone https://github.com/alexanderjeurissen/ranger_devicons ~/.config/ranger/plugins/ranger_devicons
fi
