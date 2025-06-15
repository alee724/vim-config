local ls = require('luasnip')
local fmt = require('luasnip.extras.fmt').fmt
local fmta = require('luasnip.extras.fmt').fmta
local extras = require("luasnip.extras")
local rep = extras.rep

local snippets = {
    { -- snippet to make typing = sign easier
        ";;",
        ls.t "="
    },
    { -- for plus sign
        ";p",
        ls.t "+"
    }, -- for minus sign
    {
        ";m",
        ls.t "-"
    },
    { -- for making comments ig
        ";c",
        fmta([[
        # ========== <> ==========<>
        ]], { ls.i(1), ls.i(0) })
    },
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
    -- for making the folding line region
    {
        ";S", ls.t "# START"
    },
    {
        ";E", ls.t "# END"
    },
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
