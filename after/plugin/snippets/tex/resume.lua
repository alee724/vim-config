local ls = require("luasnip")
local fmta = require("luasnip.extras.fmt").fmta

local nonregex = {
    { ";desc ",
        fmta([[
    \begin{desc}{<>}{<>}{<>}
        \item[-] <>
    \end{desc}
    ]], { ls.i(1, "name"), ls.i(2, "position"), ls.i(3, "date"), ls.i(0) })
    }
}


local res = {}
for _, s in ipairs(nonregex) do
    local snip = {
        regTrig = false,
        snippetType = "autosnippet"
    }
    snip["trig"] = s[1]
    table.insert(res, ls.s(snip, s[2]))
end
return res
