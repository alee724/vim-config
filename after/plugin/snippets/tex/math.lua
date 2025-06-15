local ls = require("luasnip")
local fmta = require("luasnip.extras.fmt").fmta
local fmt = require("luasnip.extras.fmt").fmt
local extras = require("luasnip.extras")
local rep = extras.rep

local in_mathzone = function()
    -- The `in_mathzone` function requires the VimTeX plugin
    return vim.fn['vimtex#syntax#in_mathzone']() == 1
end

local nonregex = {
    { -- creating a math env
        "mm",
        fmt("{}${}${}", { ls.f(function(_, snip) return snip.captures[1] end), ls.i(1, "temporary"), ls.i(2) })
    },
}

local nonregex_math = {
    -- snippets that I want to execute immediately upon typing in the math env
    { -- fractions
        "ff", fmta([[\frac{<>}{<>}<>]],
        { ls.i(1), ls.i(2), ls.i(0) })
    },
    { -- for squiggly brackets
        "{", fmta([[
        \{<>\}<>
        ]], { ls.i(1), ls.i(0) })
    },
    { -- subscript
        "sb", fmta([[_{<>}<>]],
        { ls.i(1), ls.i(0) })
    },
    { -- superscript
        "sp", fmta([[^{<>}<>]],
        { ls.i(1), ls.i(0) })
    },
    { -- summation equation
        ";sum ",
        fmta([[\sum_{<>}<>]], { ls.i(1), ls.i(0) })
    },
    { -- integral
        ";int ",
        fmta([[\int_{<>}^{<>}<> d<>]],
            { ls.i(1), ls.i(2), ls.i(3), ls.i(0) })
    },
    { -- limit thing
        ";lim ",
        fmta([[\lim_{<> \to <>}<>]],
            { ls.i(1), ls.c(2, { ls.t "\\infty", ls.t "0" }), ls.i(0) })
    },
    { -- square root
        ";sq ", fmta([[\sqrt[<>]{<>}<>]],
        { ls.c(1, { ls.t "", ls.t "2", ls.t "3", ls.t "4" }), ls.i(2), ls.i(0) })
    },
    -- greater and less than
    {
        ";ge ", ls.t "\\geq "
    },
    {
        ";le ", ls.t "\\leq "
    },
    { -- infinity
        ";inf ", ls.t "\\infty "
    },
    { -- not equal
        ";ne ", ls.t "\\neq "
    },
    { -- plus minus
        ";pm ", ls.t "\\pm "
    },
    { -- dot product symbol
        ";dot ", ls.t "\\cdot "
    },

    -- Some logic symbols
    {
        ";ex ", ls.t "\\exists "
    },
    {
        ";fa ", ls.t "\\forall "
    },
    {
        ";in ", ls.t "\\in "
    },
    {
        ";nin ", ls.t "\\notin "
    },
    {
        ";sbs ", ls.t "\\subset "
    },
    {
        ";sbse ", ls.t "\\subseteq "
    },
    {
        ";empty ", ls.t "\\emptyset "
    },
    {
        ";if ", ls.t "\\iff "
    },
    {
        ";imp ", ls.t "\\implies "
    },
    {
        ";the ", ls.t "\\therefore "
    },
    {
        ";bec ", ls.t "\\because "
    },

    -- General Math Symbols
    {
        ";pp ", ls.t "\\partial "
    },
    {
        ";x ", ls.t "\\times "
    },
    {
        ";> ", ls.t "\\rightarrow "
    },
    {
        ";< ", ls.t "\\leftarrow "
    },

    -- greek symbols
    {
        ";a ", ls.t "\\alpha "
    },
    {
        ";be ", ls.t "\\beta "
    },
    {
        ";g ", ls.t "\\gamma "
    },
    {
        ";G ", ls.t "\\Gamma "
    },
    {
        ";d ", ls.t "\\delta "
    },
    {
        ";D ", ls.t "\\Delta "
    },
    {
        ";e ", ls.t "\\epsilon "
    },
    {
        ";E ", ls.t "\\Epsilon "
    },
    {
        ";th ", ls.t "\\theta "
    },
    {
        ";la ", ls.t "\\lambda "
    },
    {
        ";mu ", ls.t "\\mu "
    },
    {
        ";p ", ls.t "\\pi "
    },
    {
        ";r ", ls.t "\\rho "
    },
    {
        ";si ", ls.t "\\sigma "
    },
    {
        ";Si ", ls.t "\\Sigma "
    },
    {
        ";t ", ls.t "\\tau "
    },
    {
        ";ph ", ls.t "\\phi "
    },
    {
        ";Ph ", ls.t "\\Phi "
    },
    {
        ";c ", ls.t "\\chi "
    },
    {
        ";ps ", ls.t "\\psi "
    },
    {
        ";Ps ", ls.t "\\Psi "
    },
    {
        ";o ", ls.t "\\omega "
    },
    {
        ";O ", ls.t "\\Omega "
    },
    {
        ";n ", ls.t "\\nabla "
    }
}

local res = {}
for _, s in ipairs(nonregex) do
    local snip = {
        regTrig = false,
        wordTrig = true,
        snippetType = "autosnippet"
    }
    snip["trig"] = s[1]
    table.insert(res, ls.s(snip, s[2]))
end
for _, s in ipairs(nonregex_math) do
    local snip = {
        regTrig = true,
        wordTrig = false,
        snippetType = "autosnippet"
    }
    snip["trig"] = s[1]
    table.insert(res, ls.s(snip, s[2], { condition = in_mathzone }))
end

return res
