local ls = require('luasnip')
local fmta = require('luasnip.extras.fmt').fmta
local extras = require("luasnip.extras")
local rep = extras.rep

-- local function ffield(string)
--     local mod = vim.split(string, " ")[1]
--     local nodes = {}
--     local buff = "    "
--     if mod == "private" or mod == "protected" then
--         table.insert(nodes, ls.t { "", buff .. "{ " })
--         table.insert(nodes, ls.c(1, { ls.sn(nil, { ls.t "set;", ls.c(1, { ls.t "", ls.t " get;" }) }), ls.t "get;" }))
--         table.insert(nodes, ls.t { " }", "" })
--         table.insert(nodes, ls.i(2))
--     else
--         table.insert(nodes, ls.i(1))
--     end
--     return ls.sn(nil, ls.c(1, { ls.t "", ls.sn(nil, nodes) }))
-- end

--     {
--         ";f", fmta([[
--             <> <><>
--         ]], { ls.c(1, { ls.t "public", ls.t "private", ls.t "protected" }), ls.i(2), ls.d(3, function(args)
--         return ffield(args[1][1])
--     end, { 1 }) })
--     }

local snippets = {
    {
        ";cl", fmta([[
        class <> {
            /*
            <>
            */
            <><>
        }<>
        ]], { ls.i(1, "ClassName"), ls.i(2, "description"), ls.i(3), ls.d(4, function(args)
        local buff = "    "
        return ls.sn(nil,
            { ls.c(1,
                { ls.t "", ls.sn(nil,
                    { ls.t({ "", buff .. "public " .. args[1][1] .. " (" }), ls.i(1), ls.t({ ")", buff .. "{", buff ..
                    buff }), ls.i(2), ls.t { "", buff .. "}" } }) }) })
    end, { 1 }), ls.i(0) })
    },
}

local res = {}
for _, s in ipairs(snippets) do
    local snip = {
        regTrig = false,
        wordTrig = true,
        snippetType = "autosnippet"
    }
    snip["trig"] = s[1]
    table.insert(res, ls.s(snip, s[2]))
end

return res
