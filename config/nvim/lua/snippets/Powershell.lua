-- Snippets para Powershell
--
local ls = require("luasnip")

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local ri = require("luasnip.extras").rep

ls.add_snippets("ps1", {

    -- Basicos --------------------------------------------------

    -- Foreach
    s("foreach", {
        t('foreach ($'), i(1, "item"), t(' in $'), i(2, "items"), t(') {'),
        t({'','    '}), i(0),
        t({'','}'}),
    }),

    -- If
    s("if", {
        t('if ($'), i(1, 'condition'), t(') {'),
        t({'','    '}), i(0),
        t({'','}'}),
    }),

    -- If else
    s("ifelse", {
        t('if ($'), i(1, 'condition'), t(') {'),
        t({'','    '}), i(0),
        t({'','} else {'}),
        t({'','    '}),
        t({'','}'}),
    }),

    -- Function
    s("function", {
        t('function '), i(1, "funName"), t(' {'),
        t({'','    <#'}),
        t({'','    .SYNOPSIS'}),
        t({'','    '}), i(2, "description"),
        t({'','    .DESCRIPTION'}),
        t({'','    '}), ri(2),
        t({'','    .PARAMETER '}), i(3, "param1Name"),
        t({'','    '}), i(4, "param1Desc"),
        t({'','    #>'}),
        t({'',''}),
        t({'','    param ('}),
        t({'','        ['}), i(5, "param1Type"), t(']$'), ri(3),
        t({'','    )'}),
        t({'',''}),
        t({'','    '}), i(0),
        t({'',''}),
        t({'','}'}),
    }),

    -- Class
    s("class", {
        t('class '), i(1, "className"), t(' {'),
        t({'','    <#'}),
        t({'','    .SYNOPSIS'}),
        t({'','    '}), i(2, "description"),
        t({'','    .DESCRIPTION'}),
        t({'','    '}), ri(2),
        t({'','    .PARAMETER '}), i(3, "param1Name"),
        t({'','    '}), i(4, "param1Desc"),
        t({'','    #>'}),
        t({'',''}),
        t({'','    ['}), i(5, "property1Type"), t(']$'), i(6, "property1Name"),
        t({'','    '}), i(0),
        t({'',''}),
        t({'','    '}), ri(1), t('(['), i(7, 'param1Type'), t(']$'), ri(3), t(') {'),
        t({'','        $this.'}), ri(6), t(' = $'), ri(3),
        t({'','    }'}),
        t({'','}'}),
    }),

    -- TryCatch
    s("try", {
        t('try {'),
        t({'','    '}), i(0),
        t({'','} catch ['}), i(1, "Exception"), t('] {'),
        t({'','    '}),
        t({'','}'}),
    }),

    -- Parameters
    s("param(", {
        t('param('),
        t({'','    [Parameter(Mandatory=$true, HelpMessage=\''}), i(1, 'HelpMessage'), t('\')]'),
        t({'','    ['}), i(2, 'param1Type'), t(']$'), i(3, 'param1Name'),
        t({'','    '}), i(0),
        t({'',')'}),
    }),

})
