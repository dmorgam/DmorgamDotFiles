# Se lee en TODA invocacion de zsh (login, interactivo y no interactivo).
#
# El PATH vive aqui y no en .zshrc a proposito: SDDM arranca la sesion con
# /usr/share/sddm/scripts/wayland-session, que hace `exec $SHELL --login`.
# Ese zsh es login pero NO interactivo, asi que .zshrc nunca se lee y Hyprland
# heredaba un PATH sin ~/.local/bin (scripts como tmux-coding-session.sh o
# snip.sh no se encontraban desde hl.exec_cmd/hl.bind).
#
# /etc/zsh/zprofile -> /etc/profile usa append_path, no machaca PATH, asi que
# lo que se anada aqui sobrevive.

# -U mantiene las entradas unicas: .zshenv se relee en shells anidados.
typeset -U path PATH

path+=("$HOME/.local/bin")

export PATH
