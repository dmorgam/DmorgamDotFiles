#!/bin/sh

#
# Script para configurar opciones del sistema.
# 
# - /etc/issue
# - Custom vtcolors

# ----------------------------------------------

BASEDIR=$(dirname "$0")

# Seleccionar el tema VT deseado
VT_COLORS_THEME="base16-rose-pine.hex"


# ----------------------------------------------

echo "Instando configuración de VT ... "

# Copy vt colors theme
sudo cp "${BASEDIR}/${VT_COLORS_THEME}" /etc/custom-vt-colors.hex
sudo cp "${BASEDIR}/custom-vt-colors.service" /etc/systemd/system/custom-vt-colors.service

# Install systemd unit for vt colors
sudo systemctl daemon-reload
sudo systemctl enable custom-vt-colors.service
sudo systemctl start custom-vt-colors.service

echo "Copiando /etc/issue ..."
sudo cp "${BASEDIR}/issue" /etc/issue
