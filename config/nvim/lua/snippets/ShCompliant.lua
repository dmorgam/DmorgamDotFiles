-- Snippets para MarkDown

local ls = require("luasnip")

ls.add_snippets("sh", {

  -- Basicos --------------------------------------------------

  -- Bucle for
  ls.snippet("for", {
    ls.text_node('for index in $('),
    ls.insert_node(1),
    ls.text_node({')','do','  '}),
    ls.insert_node(0),
    ls.text_node({'','done'}),
  }),

  -- Bucle while
  ls.snippet("while", {
    ls.text_node('while '),
    ls.insert_node(1),
    ls.text_node({'','do','  '}),
    ls.insert_node(0),
    ls.text_node({'','done'}),
  }),

  -- Switch case
  ls.snippet("case", {
    ls.text_node('case "'),
    ls.insert_node(1),
    ls.text_node({'" in','  "'}),
    ls.insert_node(2),
    ls.text_node({'")','    ','    ;;','esac'}),
  }),

  -- If
  ls.snippet("if", {
    ls.text_node('if test '),
    ls.insert_node(1),
    ls.text_node({'','then','  '}),
    ls.insert_node(0),
    ls.text_node({'','fi'}),
  }),

  -- If else
  ls.snippet("ifelse", {
    ls.text_node('if test '),
    ls.insert_node(1),
    ls.text_node({'','then','  '}),
    ls.insert_node(0),
    ls.text_node({'','else','  ','fi'}),
  }),

  -- Date timestamp in day
  ls.snippet("date-daytimestamp", {
    ls.text_node('$(date +%Y%m%d)')
  }),

  -- Funcion
  ls.snippet("funcion", {
    ls.insert_node(1),
    ls.text_node({' () {','  ','}'})
  }),

  -- shebang
  ls.snippet("#!-shebang", {
    ls.text_node('#!/bin/sh')
  }),
})
