-- Snippets para MarkDown

local ls = require("luasnip")

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

ls.add_snippets("markdown", {

  -- Basicos --------------------------------------------------

  -- Comentario de codigo en markdown
  s("```", {
    t("```"), i(1),
    t({"",""}), i(0),
    t({"","```"})
  }),

  -- Enlace
  s("[]()", {
    t("["), i(1), t("]"), t("("), i(2), t(")"),
  }),

  -- Foto
  s("![]()", {
    t("!["), i(1), t("]"), t("("), i(2), t(")"),
  }),

  -- Negrita
  s("**", {
    t("**"), i(1), t("**"),
  }),

  -- Tablas ---------------------------------------------------

  -- Tabla 2 campos
  s("tabla2", {
    t("| "), i(1), t(" | "), i(2), t(" |"),
    t({
      "",
      "|------|------|",
      "|      |      |"
    })
  }),

  -- Tabla 3 campos
  s("tabla3", {
    t("| "), i(1), t(" | "), i(2), t(" | "), i(3), t(" |"),
    t({
      "",
      "|------|------|------|",
      "|      |      |      |"
    })
  }),

  -- Tabla 4 campos
  s("tabla4", {
    t("| "), i(1), t(" | "), i(2), t(" | "), i(3), t(" | "), i(4), t(" |"),
    t({
      "",
      "|------|------|------|------|",
      "|      |      |      |      |"
    })
  }),

  -- Tabla 5 campos
  s("tabla5", {
    t("| "), i(1), t(" | "), i(2), t(" | "), i(3), t(" | "), i(4), t(" | "), i(5), t(" |"),
    t({
      "",
      "|------|------|------|------|------|",
      "|      |      |      |      |      |"
    })
  }),

})
