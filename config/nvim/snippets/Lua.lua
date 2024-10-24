-- Snippets para MarkDown

local ls = require("luasnip")

ls.add_snippets("lua", {

  -- Basicos --------------------------------------------------

  -- Snippets para luasnip ------------------------------------

  ls.snippet("ls.snippet", {
    ls.text_node('ls.snippet("'),
    ls.insert_node(1),
    ls.text_node({'", {',''}),
    ls.insert_node(0),
    ls.text_node({'  ','}),'}),
  }),

  ls.snippet("ls.text_node", {
    ls.text_node('ls.text_node("'),
    ls.insert_node(1),
    ls.text_node('")'),
  }),

  ls.snippet("ls.insert_node", {
    ls.text_node('ls.insert_node('),
    ls.insert_node(1),
    ls.text_node(')'),
  }),

})
