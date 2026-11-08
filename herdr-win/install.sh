#!/bin/sh

#
# Script para copiar la config de herdr al herdr desktop de Windows, desde WSL
#
# Solo copia config (keys, settings, tema, mods); la app se instala aparte.
# Reutiliza ../install.sh --herdr con HERDR_APP_HOME apuntando al Home de
# Windows.
#
# HERDR_WIN_HOME=<ruta WSL> fuerza el Home de herdr en Windows.
#

HERDR_WIN_BASEDIR=$(dirname "$0")
REPO_DIR="$HERDR_WIN_BASEDIR/.."

WIN32=/mnt/c/Windows/System32

# ----------------------------------------------

winEnv () {
  (cd /mnt/c && "$WIN32/cmd.exe" /c "echo %$1%" 2> /dev/null) | tr -d '\r'
}

# Ruta tal como la imprime herdr (~/..., ~\... o C:\...) -> ruta de WSL
winToWsl () {
  case $1 in
    '~'*) printf '%s\n' "$WINPROFILE${1#\~}" | tr '\\' '/' ;;
    *) wslpath -u "$1" ;;
  esac
}

# Home de la app en Windows: lo que diga `herdr-app.exe --help`, si esta
herdrHome () {
  if test -n "$HERDR_WIN_HOME"
  then
    printf '%s\n' "$HERDR_WIN_HOME"
    return 0
  fi

  app=$(command -v herdr-app.exe)
  if test -z "$app"
  then
    app="$(wslpath -u "$(winEnv LOCALAPPDATA)")/Programs/herdr-app/herdr-app.exe"
  fi

  home=""
  if test -f "$app"
  then
    home=$("$app" --help 2> /dev/null | tr -d '\r' |
      sed -n 's/^Home: \(.*\) (HERDR_APP_HOME.*/\1/p')
  fi

  if test -n "$home"
  then
    winToWsl "$home"
  else
    printf '%s\n' "$WINPROFILE/.config/herdr-app"
  fi
}

# -- Main --------------------------------------

echo " -- CONFIG HERDR WINDOWS --"

if ! grep -qi microsoft /proc/version 2> /dev/null
then
  echo "Este script se lanza desde WSL."
  echo "Saliendo ..."
  exit 1
fi

WINUSER=$(winEnv USERPROFILE)
case $WINUSER in
  ''|*%*)
    echo "No se pudo leer %USERPROFILE% con cmd.exe."
    exit 1
    ;;
esac
WINPROFILE=$(wslpath -u "$WINUSER")

HERDR_WIN_HOME=$(herdrHome)
echo " + Home de herdr en Windows: $HERDR_WIN_HOME"

HERDR_APP_HOME="$HERDR_WIN_HOME" sh "$REPO_DIR/install.sh" --herdr
