#!/usr/bin/env sh

IFACES="raspi-wireguard wg0"
TOOLTIP="󰦜 Disconnected"

# Toggle mode
if test "$1" = "toggle" && test "$2" != ""
then
    if ip link show "$2"
    then
        wg-quick down ~/VPN/"$2".conf
        notify-send -t 5000 "󰦜 Conexión Wireguard ${2} cerrada"
    else
        wg-quick up ~/VPN/"$2".conf
        notify-send -t 5000 "󰯄 Conectado a Wireguard ${2}"
    fi
fi

# Show mode
for IFACE in $IFACES; do
  if ip link show "$IFACE" >/dev/null 2>&1
  then
    TOOLTIP=$(ip -br addr show raspi-wireguard)

    echo '{"text": "󰯄", "tooltip": "󰯄 '"${TOOLTIP}"'", "class": "connected"}'
    exit 0
  fi
done

echo '{"text": "󰦜", "tooltip": "'"$TOOLTIP"'", "class": "disconnected"}'
