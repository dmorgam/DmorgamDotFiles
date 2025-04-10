#!/bin/zsh

# Funciones para mostrar el banner

ttyMenu () {
    # Menu para tty

    menu="hyprland\nexit"
    echo -n $menu | /usr/bin/fzf --height=5 --prompt="Select option: " | sh -s
}


ttyBanner () {
  #
  # Muestra el banner de la tty.
  # Params: sin params.

  # Porcentaje de bateria
  width=30
  percent=$(cat /sys/class/power_supply/BAT0/capacity)
  (( blobs = percent * width / 100 ))
  printf "\n\rBATTERY:     \e[92m%3d%% [%-${width}s]\e[0m\n" $percent "$( printf "%${blobs}s" | tr " " "=" )"

  echo "CONNECTIONS:"
  nmcli con show --active
  printf "\n\rLaunch GUI:  \e[94mHyprland\e[0m\n"

  ttyMenu

}


normalBanner () {
  #
  # Banner normal
  #
  clear

  # Banner para WSL
  if cat /proc/version | grep -q "[mM]icrosoft"
  then
    cat ~/.zsh/ansi-logos/wsl-logo.txt

  # Banner para linux
  elif type pokemon-colorscripts &> /dev/null
  then
    echo '' && pokemon-colorscripts --no-title -r

  # Banner fallback
  else
    echo $(cat /etc/hostname) | figlet -f smslant | lolcat
  fi

  # Config de longitud para formatear fortune
  COL_LEN=$(tput cols)
  COLS=60
  test $(tput cols) -lt 60 && (( COLS = $COL_LEN - 2 ))

  fortune ~/.fortune/custom-quotes | fold -s -w $COLS | lolcat
  echo ""
}
