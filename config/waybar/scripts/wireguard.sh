#!/usr/bin/env sh

VPN_DIR="${HOME}/VPN"
IFACES="amnesiawg-pozo wg0"
TOOLTIP="󰦜 Disconnected"

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

# Toggle mode
if test "$1" = "toggle" && test "$2" != ""
then
    CONF="${VPN_DIR}/${2}.conf"

    if ! test -f "$CONF"
    then
        notify-send -u critical -t 5000 "󰦜 No existe ${CONF}"
        exit 1
    fi

    TOOL=$(quick_tool "$CONF")

    if ip link show "$2" >/dev/null 2>&1
    then
        if ERR=$("$TOOL" down "$CONF" 2>&1)
        then
            notify-send -t 5000 "󰦜 Conexión Wireguard ${2} cerrada"
        else
            notify-send -u critical -t 8000 "󰦜 Error cerrando ${2}" "$ERR"
        fi
    else
        if ERR=$("$TOOL" up "$CONF" 2>&1)
        then
            notify-send -t 5000 "󰯄 Conectado a Wireguard ${2}"
        else
            notify-send -u critical -t 8000 "󰦜 Error conectando a ${2}" "$ERR"
        fi
    fi
fi

# Show mode
for IFACE in $IFACES; do
  if ip link show "$IFACE" >/dev/null 2>&1
  then
    TOOLTIP=$(ip -br addr show "$IFACE")

    echo '{"text": "󰯄", "tooltip": "󰯄 '"${TOOLTIP}"'", "class": "connected"}'
    exit 0
  fi
done

echo '{"text": "󰦜", "tooltip": "'"$TOOLTIP"'", "class": "disconnected"}'
