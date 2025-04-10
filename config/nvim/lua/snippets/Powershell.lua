-- Snippets para Powershell

local ls = require("luasnip")

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local ri = require("luasnip.extras").rep

ls.add_snippets("ps1", {

    -- Basicos --------------------------------------------------

    -- Foreach
    s("foreach", {
        t('foreach ($'), i(1, "item"), t(' in $'), i(2, "items"), t(') {'),
        t({'','    '}), i(0),
        t({'','}'}),
    }),

    -- For
    s("for($i = 0, $i -lt 10", {
        t('for ($i = 0; $i -lt '), i(1, 'counter'), t('; $i++) {'),
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

    -- Switch Case
    s("switch ($var) {", {
        t('switch ($'), i(1, 'Variable'), t(') {'),
        t({'','    "'}), i(2, 'Valor1'), t('"  { '), i(0), t(' }'),
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

    -- Method
    s("[type] Method() {", {
        t('['), i(1, 'returnType'), t('] '), i(2, 'MethodName'), t('() {'),
        t({'','    <#'}),
        t({'','    .SYNOPSIS'}),
        t({'','    '}), i(3, "description"),
        t({'','    .DESCRIPTION'}),
        t({'','    '}), ri(3),
        t({'','    #>'}),
        t({'',''}),
        t({'','    '}), i(0),
        t({'','}'}),
    }),

    -- Documentation
    s("<#", {
        t({'<#'}),
        t({'','.SYNOPSIS'}),
        t({'',''}), i(1,'description'),
        t({'',''}),
        t({'','.DESCRIPTION'}),
        t({'',''}), ri(1),
        t({'',''}),
        t({'','.PARAMETER '}), i(2, 'parameter1'),
        t({'',''}), i(3, 'parameter1desc'),
        t({'',''}),
        t({'','.EXAMPLE'}),
        t({'','.\\'}), i(4, 'example'),
        t({'',''}),
        t({'#>'}),
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

    -- HTTP Requests --------------------------------------------

    -- Invoke-RestMethod
    s("Invoke-RestMethod", {
        t('$url = "'), i(1, 'Url'), t('"'),
        t({'',''}),
        t({'','$body = @{'}),
        t({'','    '}), i(0),
        t({'','}'}),
        t({'',''}),
        t({'','$headers = @{'}),
        t({'','    "Content-Type" = "application/json"'}),
        t({'','    "Authorization" = "Bearer '}), i(3, 'token'), t('"'),
        t({'','}'}),
        t({'',''}),
        t({'','$response = Invoke-RestMethod -Uri $url -Method '}),
        c(2, { t('Post'), t('Get'), t('Put'), t('Patch'), t('Delete'), t('Head')}), t(' -Headers $headers -Body $body'),
    }),
})
