// Prefijo estilo tmux para herdr.
//
// keys.json abre este popup con ctrl-a ("ctrl-a": "mod.open:leader"). El popup
// coge el teclado, espera UNA tecla, ejecuta el comando que le toca (tabla de
// abajo, misma que ~/.tmux.conf + defaults de tmux) y se cierra.
// Esc, click fuera o cualquier tecla sin binding: cancela.
//
// tmux -> herdr:  window = tab,  session = space,  pane = pane.

import { View, div } from "gpui-kit";
import { h_flex } from "gpui-base";
import { run, props, closeOverlay, openOverlay, focused, panes, hc, notify, theme, nextCommand } from "herdr";

// Cada entrada: (target) => [comando, args] | void. `target` es el pane, terminal
// y tab con foco al pulsar el prefijo.
const go = (direction) => () => ["pane.go", { direction }];

const BINDINGS = {
  // ~/.tmux.conf: splits conservando el path actual
  '"': (t) => ["pane.split", { direction: "right", pane: t.pane }],
  "%": (t) => ["pane.split", { direction: "down", pane: t.pane }],
  // ~/.tmux.conf: r recarga config. herdr ya recarga solo al guardar.
  r: () => {
    notify({ title: "Config recargada ✓", body: "herdr aplica keys.json y mods al guardar", level: "success" });
  },

  // Windows -> tabs
  c: () => ["tab.new"],
  n: () => ["tab.next"],
  p: () => ["tab.prev"],
  ",": (t) => ["tab.rename", { id: t.tab }],
  "&": (t) => confirm("¿Cerrar tab?", "Termina todos sus terminales.", "tab.close", { id: t.tab, confirmed: true }),
  w: () => ["mod.open", { name: "picker" }],
  ...Object.fromEntries([1, 2, 3, 4, 5, 6, 7, 8, 9].map((i) => [String(i), () => ["tab.select", { index: i }]])),
  0: () => ["tab.select", { index: 10 }],

  // Sessions -> spaces
  s: () => ["mod.open", { name: "picker" }],
  $: () => ["space.rename"],
  "(": () => ["space.prev"],
  ")": () => ["space.next"],
  // detach: cierra la ventana; los terminales siguen vivos en herdr-core
  d: () => ["window.close"],

  // Panes
  x: (t) => confirm("¿Cerrar pane?", "Termina su terminal.", "pane.close", { pane: t.pane }),
  z: (t) => ["pane.zoom", { pane: t.pane }],
  o: (t) => nextPane(t),
  left: go("left"),
  down: go("down"),
  up: go("up"),
  right: go("right"),
  h: go("left"),
  j: go("down"),
  k: go("up"),
  l: go("right"),
  "{": () => ["pane.swap", { direction: "left" }],
  "}": () => ["pane.swap", { direction: "right" }],

  // Copy mode / buffers (lo más cercano que tiene herdr)
  "[": () => ["terminal.search"],
  pageup: (t) => ["terminal.scroll", t.terminal ? { pages: -1, terminal: t.terminal } : { pages: -1 }],
  "]": () => ["terminal.paste"],

  // Prompt y ayuda
  ":": () => ["app.palette"],
  "?": () => ["app.help"],
};

function confirm(title, detail, name, args) {
  openOverlay({ mod: "confirm", kind: "dialog", width: 380, height: 150, props: { title, detail, command: { name, args } } });
}

function nextPane(t) {
  const list = panes().filter((p) => p.tab === t.tab);
  if (list.length < 2) return;
  const i = list.findIndex((p) => p.pane === t.pane);
  return ["pane.focus", { pane: list[(i + 1) % list.length].pane }];
}

const MODIFIERS = new Set(["shift", "control", "ctrl", "alt", "platform", "cmd", "super", "function", "fn"]);

// Tecla como la escribe tmux: '"', '%', '1', 'left', 'pageup'... Se usa el carácter
// que teclea (key_char), así vale cualquier layout (ES: '"' = shift-2, '[' = altgr).
function keyOf(e) {
  const m = e.modifiers;
  if (!m.control && !m.platform && e.key_char && e.key_char.trim()) return e.key_char;
  return e.keystroke;
}

export default class Leader extends View {
  init(_props, cx) {
    const f = focused();
    const p = panes().find((x) => x.focused);
    this.target = {
      pane: f?.pane ?? p?.pane ?? null,
      terminal: f?.terminal ?? p?.terminal ?? null,
      tab: f?.tab ?? p?.tab ?? null,
    };
    this.done = false;
    this.handle = cx.focus_handle();
    this.handle.focus();

    // "mod:leader": { "ctrl-a": "leader.passthrough" } en keys.json -> C-a C-a manda C-a al programa
    cx.spawn(async () => {
      for (;;) {
        const c = await nextCommand();
        if (c === "passthrough") this.passthrough();
      }
    });
  }

  dismiss() {
    if (this.done) return;
    this.done = true;
    closeOverlay(props().overlay);
  }

  passthrough() {
    if (this.done) return;
    const term = this.target.terminal;
    this.dismiss();
    if (term) hc(["keys", term, "ctrl+a"]);
  }

  press(e) {
    if (MODIFIERS.has(e.key)) return;
    const key = keyOf(e);
    if (key === "escape") return this.dismiss();
    if (key === "ctrl-a") return this.passthrough();
    const binding = BINDINGS[key];
    this.dismiss();
    const action = binding?.(this.target);
    if (action) run(action[0], action[1] ?? {});
  }

  render(_cx) {
    const t = theme();
    const hint = (k, label) =>
      h_flex().gap(4).items_center().child(div().text_color(t.foreground).font_semibold().child(k)).child(div().text_color(t.dim).child(label));
    return h_flex()
      .id("leader")
      .track_focus(this.handle)
      .on_key_down((e, cx) => {
        cx.stop_propagation();
        this.press(e);
      })
      .size_full()
      .px(12)
      .gap(12)
      .items_center()
      .bg(t.popover)
      .text_size(12)
      .child(div().px(6).py(1).rounded(4).bg(t.accent).text_color(t.accent_foreground).font_semibold().child("C-a"))
      .child(hint('"', "split →"))
      .child(hint("%", "split ↓"))
      .child(hint("c", "tab"))
      .child(hint("x", "cerrar"))
      .child(hint("z", "zoom"))
      .child(hint("?", "ayuda"))
      .child(div().flex_1())
      .child(div().text_color(t.dim).child("Esc"));
  }
}
