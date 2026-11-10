#!/bin/sh

#
# Herdr: Copilot CLI no reporta su estado (OSC 7501) como Claude Code, asi que
# herdr lo ve como programa, no como agente. Los hooks de herdr.json llaman a
# este script en cada evento y el escribe el OSC 7501 en el tty del pane.
#
#   herdr-status.sh working|done|clear   estado fijo
#   herdr-status.sh notification         blocked si es permiso o pregunta
#   herdr-status.sh error                error si no es recuperable
#
# Copilot pasa el evento en JSON por stdin y parsea stdout: aqui nunca se
# escribe a stdout. Solo actua dentro de un terminal de herdr ($HC_TERMINAL_ID).
#

payload=$(cat)

test -n "$HC_TERMINAL_ID" || exit 0

# Solo si copilot es el proceso en primer plano del tty: un `copilot -p` que
# lance otro agente en su terminal no debe pisarle el estado. Sin tty
# controlador (tpgid -1) tampoco hay /dev/tty donde escribir.
if command -v ps > /dev/null 2>&1
then
  pgid=$(ps -o pgid= -p "$PPID" 2> /dev/null | tr -d ' ')
  tpgid=$(ps -o tpgid= -p "$PPID" 2> /dev/null | tr -d ' ')
  test -n "$pgid" && test "$pgid" = "$tpgid" || exit 0
fi

case $1 in
  working|done|clear)
    state=$1
    ;;
  notification)
    case $payload in
      *permission_prompt*) state="blocked:kind=permission" ;;
      *elicitation_dialog*) state="blocked:kind=question" ;;
      *) exit 0 ;;
    esac
    ;;
  error)
    case $payload in
      *'"recoverable":false'*|*'"recoverable": false'*) state=error ;;
      *) exit 0 ;;
    esac
    ;;
  *)
    exit 0
    ;;
esac

printf '\033]7501;state=%s:app=copilot\033\\' "$state" 2> /dev/null > /dev/tty
exit 0
