-- Snippets para MarkDown

local ls = require("luasnip")

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local ri = require("luasnip.extras").rep

ls.add_snippets("sh", {

    -- Basicos --------------------------------------------------

    -- Bucle for
    s("for", {
        t('for index in $('), i(1),
        t({')','do'}),
        t({'','  '}), i(2),
        t({'','done'}),
    }),

    -- Bucle while
    s("while", {
        t('while '), i(1),
        t({'','do'}),
        t({'','  '}), i(2),
        t({'','done'}),
    }),

    -- Switch case
    s("case", {
        t('case "'), i(1),
        t({'" in','  "'}),
        i(2), t({'")','    '}),
        i(3),
        t({'','    ;;','esac'}),
    }),

    -- If
    s("if", {
        t('if test '), i(1),
        t({'','then'}),
        t({'','  '}), i(2),
        t({'','fi'}),
    }),

    -- If else
    s("ifelse", {
        t('if test '), i(1),
        t({'','then'}),
        t({'','  '}), i(2),
        t({'','else','  ','fi'}),
    }),

    -- Date timestamp in day
    s("TIMESTAMP=$(date +%Y%m%d)", {
        t({'TIMESTAMP=$(date +%Y%m%d)',''})
    }),

    -- Funcion
    s("function", {
        t('# '), ri(1), t(": "), i(2, "Description"),
        t({'','#'}),
        t({'','# '}), t("Args:"),
        t({'','#   $1 - '}), i(3, "arg1Desc"),
        t({'','#'}),
        t({'','# '}), t("Returns:"),
        t({'','#   '}), i(4, "returnType"), t(' - '), i(5, "returnDescription"),
        t({'','#'}),
        t({'',''}),i(1, "FunctionName"),
        t({' () {'}),
        t({'', '    '}), i(6, "Contents"),
        t({'','}'}),
    }),

    -- shebang
    s("#!-shebang", {
        t('#!/bin/sh'),
        t({'','#'}),
        t({'','# '}), i(1, "Description"),
        t({'','#'}),
        t({'','# '}), t("Args:"),
        t({'','#   $1 - '}), i(2, "arg1Desc"),
        t({'','#'}),
        t({'','# '}), t("Returns:"),
        t({'','#   '}), i(3, "returnType"), t(' - '), i(4, "returnDescription"),
        t({'','#','',''}),
        t({'','# ---- Variables -----------------------------------'}),
        t({'',''}),
        t({'',''}),
        t({'BASEDIR=$(dirname "$0")',''}),
        t({'',''}),
        t({'','# ---- Functions -----------------------------------'}),
        t({'',''}),
        t({'',''}),
        t({'',''}),
        t({'','# ---- Main ----------------------------------------'}),
        t({'',''}),
        t({'',''}),
    }),

    -- Basedir
    s("BASEDIR=$(dirname...", {
        t({'BASEDIR=$(dirname "$0")',''})
    }),


    -- Common functions ----------------------------------------

    -- help function 
    s("help ()", {
        t('help () {'),
        t({'','    echo "'}), i(1, 'Description'), t('"'),
        t({'','    echo "    --'}), i(2, 'param1'), t('         -  '), i(3,'param1_desc'), t('"'),
        t({'','    echo "    --help           -  Muestra la ayuda."'}),
        t({'','}'}),
    }),

})
