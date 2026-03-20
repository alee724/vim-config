local ls = require('luasnip')
local fmta = require('luasnip.extras.fmt').fmta
local extras = require("luasnip.extras")
local rep = extras.rep


local snippets = {
    { -- for brackets
        ";b",
        fmta([[
        [<>]<>
        ]], { ls.i(1), ls.i(0) })
    },
    { -- for squiggly brackets
        ";s",
        fmta([[
        {<>}<>
        ]], { ls.i(1), ls.i(0) })
    },
    { -- snippet to make typing = sign easier
        ";e",
        ls.t "="
    },
    { -- for plus sign
        ";a",
        ls.t "+"
    }, -- for minus sign
    {
        ";m",
        ls.t "-"
    },
    {
        ";f", fmta([[
        for (<>; <>; <>) {
            <>
        }<>
        ]], { ls.i(1, "init"), ls.i(2, "guard"), ls.i(3, "after"), ls.i(4), ls.i(5) })
    },
    {
        ";w", fmta([[
        while (<>) {
            <>
        }<>
        ]], { ls.i(1, "guard"), ls.i(2), ls.i(3) })
    }
}


local res = {}
for _, s in ipairs(snippets) do
    local snip = {
        regTrig = false,
        wordTrig = false,
        snippetType = "autosnippet"
    }
    snip["trig"] = s[1]
    table.insert(res, ls.s(snip, s[2]))
end

return res
