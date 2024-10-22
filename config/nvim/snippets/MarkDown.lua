-- Snippets para MarkDown

local ls = require("luasnip")

ls.add_snippets("markdown", {

  -- Basicos --------------------------------------------------

  -- Comentario de codigo en markdown
  ls.snippet("codigo", {
    ls.text_node("```"),
    ls.insert_node(1),
    ls.text_node({"",""}),
    ls.insert_node(0),
    ls.text_node({"","```"})
  }),

  -- Enlace
  ls.snippet("enlace", {
    ls.text_node("["),
    ls.insert_node(1),
    ls.text_node("]"),
    ls.text_node("("),
    ls.insert_node(2),
    ls.text_node(")"),
  }),

  -- Foto
  ls.snippet("foto", {
    ls.text_node("![]"),
    ls.text_node("("),
    ls.insert_node(1),
    ls.text_node(")"),
  }),

  -- Negrita
  ls.snippet("negrita", {
    ls.text_node("***"),
    ls.insert_node(1),
    ls.text_node("***"),
  }),


  -- Tablas ---------------------------------------------------

  -- Tabla 2 campos
  ls.snippet("tabla2", {
    ls.text_node("| "),
    ls.insert_node(1),
    ls.text_node(" | "),
    ls.insert_node(2),
    ls.text_node(" |"),
    ls.text_node({
      "",
      "|------|------|",
      "|      |      |"
    })
  }),

  -- Tabla 3 campos
  ls.snippet("tabla3", {
    ls.text_node("| "),
    ls.insert_node(1),
    ls.text_node(" | "),
    ls.insert_node(2),
    ls.text_node(" | "),
    ls.insert_node(3),
    ls.text_node(" |"),
    ls.text_node({
      "",
      "|------|------|------|",
      "|      |      |      |"
    })
  }),

  -- Tabla 4 campos
  ls.snippet("tabla4", {
    ls.text_node("| "),
    ls.insert_node(1),
    ls.text_node(" | "),
    ls.insert_node(2),
    ls.text_node(" | "),
    ls.insert_node(3),
    ls.text_node(" | "),
    ls.insert_node(4),
    ls.text_node(" |"),
    ls.text_node({
      "",
      "|------|------|------|------|",
      "|      |      |      |      |"
    })
  }),

  -- Tabla 5 campos
  ls.snippet("tabla5", {
    ls.text_node("| "),
    ls.insert_node(1),
    ls.text_node(" | "),
    ls.insert_node(2),
    ls.text_node(" | "),
    ls.insert_node(3),
    ls.text_node(" | "),
    ls.insert_node(4),
    ls.text_node(" | "),
    ls.insert_node(5),
    ls.text_node(" |"),
    ls.text_node({
      "",
      "|------|------|------|------|------|",
      "|      |      |      |      |      |"
    })
  }),

})
