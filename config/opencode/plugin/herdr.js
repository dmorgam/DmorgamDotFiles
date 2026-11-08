// Herdr: opencode le dice a herdr en qué estado está (OSC 7501), igual que
// Claude Code. Sin esto herdr ve opencode como programa, no como agente.
//
//   working  alguna sesión trabajando
//   blocked  esperando permiso o respuesta a una pregunta
//   idle     nada que hacer
//
// Solo actúa dentro de un terminal de herdr ($HC_TERMINAL_ID).

import { openSync, writeSync, closeSync } from "node:fs";

export const HerdrStatus = async () => {
  if (!process.env.HC_TERMINAL_ID) return {};

  let tty;
  try {
    tty = openSync("/dev/tty", "w");
  } catch {
    return {};
  }

  const send = (data) => {
    try {
      writeSync(tty, `\x1b]7501;${data}\x1b\\`);
    } catch {}
  };

  const busy = new Set(); // sessionID
  const waiting = new Map(); // requestID -> { kind, sessionID }
  let last = "";

  const report = () => {
    let state = "idle";
    let kind;
    if (waiting.size) {
      state = "blocked";
      kind = [...waiting.values()].at(-1).kind;
    } else if (busy.size) {
      state = "working";
    }
    const data = `state=${state}:app=opencode${kind ? `:kind=${kind}` : ""}`;
    if (data !== last) {
      last = data;
      send(data);
    }
  };

  const forget = (sessionID) => {
    busy.delete(sessionID);
    for (const [id, w] of waiting) if (w.sessionID === sessionID) waiting.delete(id);
  };

  process.once("exit", () => {
    send("state=clear");
    try {
      closeSync(tty);
    } catch {}
  });

  report();

  return {
    event: async ({ event }) => {
      const p = event.properties ?? {};
      switch (event.type) {
        case "session.status":
          if (p.status?.type === "idle") busy.delete(p.sessionID);
          else busy.add(p.sessionID);
          break;
        case "session.idle":
          forget(p.sessionID);
          break;
        case "session.deleted":
          forget(p.info?.id ?? p.sessionID);
          break;
        case "permission.asked":
        case "permission.updated":
          waiting.set(p.id, { kind: "permission", sessionID: p.sessionID });
          break;
        case "permission.replied":
          waiting.delete(p.requestID ?? p.permissionID);
          break;
        case "question.asked":
          waiting.set(p.id, { kind: "question", sessionID: p.sessionID });
          break;
        case "question.replied":
        case "question.rejected":
          waiting.delete(p.requestID);
          break;
        default:
          return;
      }
      report();
    },
  };
};
