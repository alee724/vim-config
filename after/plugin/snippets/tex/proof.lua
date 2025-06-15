local ls = require("luasnip")
local fmta = require("luasnip.extras.fmt").fmta

local nonregex = {
    { -- to quick make a lemma thing
        ";lem",
        fmta([[
        \textbf{Lemma <>} \\
        \textit{<>} \medbreak <>
        ]], { ls.i(1), ls.i(2), ls.i(0) })
    },
    { -- to quick make a Theorem
        ";the",
        fmta([[
        \textbf{Theorem <>} \\
        \textit{<>} \medbreak <>
        ]], { ls.i(1), ls.i(2), ls.i(0) })
    },
    { -- proof
        ";pf ",
        fmta([[
        \textit{<>} \\
        \textbf{Proof<>} \\ <>
        ]],
            { ls.c(1, { ls.t "", ls.t " by Contradiction", fmta(" by Induction on <>", { ls.i(1) }) }), ls.i(2), ls.i(0) })
    },
    { -- proof done box thing
        ";pd ",
        fmta([[
        \hfill $\blacksquare$ \medbreak <>
        ]], { ls.i(0) })
    },
}

local regex = {}

local res = {}
for _, s in ipairs(nonregex) do
    local snip = {
        regTrig = false,
        snippetType = "autosnippet"
    }
    snip["trig"] = s[1]
    table.insert(res, ls.s(snip, s[2]))
end
for _, s in ipairs(regex) do
    local snip = {
        regTrig = true,
        wordTrig = false,
        snippetType = "autosnippet"
    }
    snip["trig"] = s[1]
    table.insert(res, ls.s(snip, s[2]))
end

return res
