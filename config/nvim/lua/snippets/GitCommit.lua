-- Snippets para Conventional Commits

local ls = require("luasnip")

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node

-- Todos los tipos llevan scope: el hook commit-msg global lo exige.
-- La descripcion acaba en la ventana de documentacion de blink.
local function tipo(trig, dscr)
    return s({ trig = trig, dscr = dscr }, {
        t(trig .. "("), i(1, "scope"), t("): "), i(2),
    })
end

local tipos = {
    t("feat"), t("fix"), t("docs"), t("style"), t("refactor"), t("perf"),
    t("test"), t("build"), t("ci"), t("chore"), t("revert"),
}

ls.add_snippets("gitcommit", {

    -- Tipos ----------------------------------------------------

    tipo("feat",     "una funcionalidad nueva"),
    tipo("fix",      "correccion de un bug"),
    tipo("docs",     "solo documentacion"),
    tipo("style",    "solo formato, sin cambio de comportamiento"),
    tipo("refactor", "ni arregla un bug ni anade funcionalidad"),
    tipo("perf",     "mejora de rendimiento"),
    tipo("test",     "anade o arregla tests"),
    tipo("build",    "sistema de build, tooling o dependencias"),
    tipo("ci",       "config de CI, pipelines, runners"),
    tipo("chore",    "mantenimiento, nada de src ni tests"),
    tipo("revert",   "revierte un commit anterior"),

    -- Con eleccion de tipo -------------------------------------

    -- Para cuando no recuerdas el tipo: <C-e> cicla los 11.
    s({ trig = "cc", dscr = "commit: elige el tipo con <C-e>" }, {
        c(1, tipos), t("("), i(2, "scope"), t("): "), i(3),
    }),

    -- Igual pero breaking change: ! antes de los dos puntos.
    s({ trig = "cc!", dscr = "commit breaking: elige el tipo con <C-e>" }, {
        c(1, tipos), t("("), i(2, "scope"), t(")!: "), i(3),
    }),

    -- Footers --------------------------------------------------

    s({ trig = "breaking", dscr = "footer: describe que rompe" }, {
        t("BREAKING CHANGE: "), i(1),
    }),

    s({ trig = "refs", dscr = "footer: referencia a un issue" }, {
        t("Refs: #"), i(1),
    }),

})
