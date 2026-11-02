#!/usr/bin/env sh

# Modulo custom/wg de waybar:
#   wireguard.sh              -> estado en JSON (exec del modulo)
#   wireguard.sh menu         -> menu rofi con los perfiles de VPN_DIR (on-click)
#   wireguard.sh toggle NAME  -> levanta/tumba VPN_DIR/NAME.conf

VPN_DIR="${HOME}/VPN"
# Interfaces que no salen de VPN_DIR pero tambien cuentan como conectado
EXTRA_IFACES="wg0"
TOOLTIP="󰦜 Disconnected"

# wg-quick/awg-quick llaman a la interfaz igual que el fichero, asi que cada
# VPN_DIR/NAME.conf es un perfil con interfaz NAME. Soltar un .conf nuevo en
# VPN_DIR basta para que salga en el menu, sin tocar waybar.
profiles () {
    for CONF in "${VPN_DIR}"/*.conf
    do
        test -f "$CONF" || continue
        NAME="${CONF##*/}"
        echo "${NAME%.conf}"
    done
}

is_up () {
    ip link show "$1" >/dev/null 2>&1
}

# AmneziaWG usa claves de obfuscacion (Jc, Jmin, Jmax, S1, S2, H1-H4) que
# `wg setconf` rechaza con "Line unrecognized: `Jc=5'". Hay que levantar esos
# tuneles con awg-quick (amneziawg-tools); los conf de WireGuard normal siguen
# con wg-quick.
quick_tool () {
    if grep -qE '^[[:space:]]*(Jc|Jmin|Jmax|S1|S2|H[1-4])[[:space:]]*=' "$1" 2>/dev/null
    then
        echo "awg-quick"
    else
        echo "wg-quick"
    fi
}

toggle () {
    CONF="${VPN_DIR}/${1}.conf"

    if ! test -f "$CONF"
    then
        notify-send -u critical -t 5000 "󰦜 No existe ${CONF}"
        exit 1
    fi

    TOOL=$(quick_tool "$CONF")

    if is_up "$1"
    then
        if ERR=$("$TOOL" down "$CONF" 2>&1)
        then
            notify-send -t 5000 "󰦜 Conexión Wireguard ${1} cerrada"
        else
            notify-send -u critical -t 8000 "󰦜 Error cerrando ${1}" "$ERR"
        fi
    else
        if ERR=$("$TOOL" up "$CONF" 2>&1)
        then
            notify-send -t 5000 "󰯄 Conectado a Wireguard ${1}"
        else
            notify-send -u critical -t 8000 "󰦜 Error conectando a ${1}" "$ERR"
        fi
    fi
}

menu () {
    PROFILES=$(profiles)

    if test -z "$PROFILES"
    then
        notify-send -u critical -t 5000 "󰦜 No hay perfiles en ${VPN_DIR}"
        exit 1
    fi

    # Una fila por perfil: estado, nombre (= interfaz, max 15 chars) y tipo
    ENTRIES=$(
        for NAME in $PROFILES
        do
            if is_up "$NAME"; then ICON="󰯄"; else ICON="󰦜"; fi

            if test "$(quick_tool "${VPN_DIR}/${NAME}.conf")" = "awg-quick"
            then
                TYPE="AmneziaWG"
            else
                TYPE="WireGuard"
            fi

            printf '%s  %-16s%s\n' "$ICON" "$NAME" "$TYPE"
        done
    )

    COUNT=$(printf '%s\n' "$PROFILES" | wc -l)
    test "$COUNT" -gt 10 && COUNT=10

    # Hereda el tema global (catppuccin-mocha) y solo lo encoge a una columna
    # pegada arriba a la derecha, bajo el modulo. height 0 = alto automatico.
    THEME="window { width: 450px; height: 0px; location: north east; anchor: north east; x-offset: -140px; y-offset: 6px; }
           listview { columns: 1; lines: ${COUNT}; }"

    # -format i devuelve el indice (0..N-1) de la fila; Esc -> rofi sale con 1
    IDX=$(printf '%s\n' "$ENTRIES" \
        | rofi -dmenu -i -no-custom -format i -p "󰯄 VPN" -theme-str "$THEME") \
        || exit 0

    case "$IDX" in
        ''|*[!0-9]*) exit 0 ;;
    esac

    NAME=$(printf '%s\n' "$PROFILES" | sed -n "$((IDX + 1))p")
    test -n "$NAME" || exit 0

    toggle "$NAME"
}

case "$1" in
    menu)
        menu
        exit 0
        ;;
    toggle)
        test -n "$2" || exit 1
        toggle "$2"
        exit 0
        ;;
esac

# Estado: lista todos los tuneles levantados (puede haber varios a la vez)
CONNECTED=""
for IFACE in $( { profiles; printf '%s\n' $EXTRA_IFACES; } | sort -u )
do
    if is_up "$IFACE"
    then
        LINE=$(ip -br addr show "$IFACE" | tr -s ' ')
        CONNECTED="${CONNECTED:+${CONNECTED}\\n}󰯄 ${LINE}"
    fi
done

if test -n "$CONNECTED"
then
    echo '{"text": "󰯄", "tooltip": "'"${CONNECTED}"'", "class": "connected"}'
    exit 0
fi

echo '{"text": "󰦜", "tooltip": "'"$TOOLTIP"'", "class": "disconnected"}'
