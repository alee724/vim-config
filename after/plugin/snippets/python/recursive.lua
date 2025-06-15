local ls = require('luasnip')
local fmta = require('luasnip.extras.fmt').fmta
local extras = require("luasnip.extras")
local rep = extras.rep

local function initf(args)
    local indent = "    "

    local input = vim.fn.substitute(args[1][1], [[\s\+]], "", "g") or ""
    local split_input = vim.split(input, ",")

    local nodes = {}
    table.insert(nodes, ls.t { '"""', "" .. indent })
    table.insert(nodes, ls.i(1, "description"))
    table.insert(nodes, ls.t { "", indent })
    if input ~= "" then
        table.insert(nodes, ls.t { "", "" })
        for ind, text in ipairs(split_input) do
            table.insert(nodes, ls.t(indent .. "@param " .. text .. ": "))
            table.insert(nodes, ls.i(ind + 1))
            table.insert(nodes, ls.t { "", "" })
        end
        table.insert(nodes, ls.t { indent .. '"""', indent })
        for _, text in ipairs(split_input) do
            table.insert(nodes, ls.t({ "self." .. text .. " = " .. text, indent }))
        end
        return ls.sn(nil, nodes)
    else
        table.insert(nodes, ls.t { '"""', indent })
    end
    return ls.sn(nil, nodes)
end

local function deff(args)
    local indent = "    "

    local input = vim.fn.substitute(args[1][1], [[\s\+]], "", "g") or ""
    local split_input = vim.split(input, ",")
    if table[1] == "self" then
        table.remove(split_input, 1)
    end

    local nodes = {}
    table.insert(nodes, ls.t { '"""', "" .. indent })
    table.insert(nodes, ls.i(1, "description"))
    table.insert(nodes, ls.t { "", indent })
    if #split_input > 0 and input ~= "" then
        table.insert(nodes, ls.t { "", "" })
        local ind = 1
        for _, text in ipairs(split_input) do
            if text == "self" then
                goto continue
            end
            table.insert(nodes, ls.t(indent .. "@param " .. text .. ": "))
            table.insert(nodes, ls.i(ind + 1))
            table.insert(nodes, ls.t { "", "" })
            ind = ind + 1
            ::continue::
        end
        table.insert(nodes, ls.t { indent .. '"""', indent })
        return ls.sn(nil, nodes)
    else
        table.insert(nodes, ls.t { '"""', indent })
    end
    return ls.sn(nil, nodes)
end

local function iff(args)
    return ls.sn(nil, ls.c(1, { ls.t "",
        fmta([[
        elif <>:
            <>
        <>
        ]], { ls.i(1, "cond"), ls.i(2), ls.d(3, iff) }),
        fmta([[
        else:
            <>
        <>
        ]], { ls.i(1), ls.d(2, iff) })
    }))
end

local snippets = {
    { -- for initializing a class
        ";init",
        fmta([[
        def __init__(self, <>):
            <><>
        ]], {
            ls.i(1),
            ls.d(2, initf, { 1 }),
            ls.c(3, { ls.t(""), fmta("super().__init__(<>) <>", { ls.i(1), ls.i(2) }) }),
        })
    },
    { -- simple if snippet
        ";if",
        fmta([[
        if <>:
            <>
        <>
        ]], { ls.i(1, "cond"), ls.i(2), ls.d(3, iff) })
    },
    { -- simple definition snippet
        ";def",
        fmta([[
        # START
        def <>(<>):
            <><>
        # END
        ]], { ls.i(1, "fname"), ls.i(2), ls.d(3, deff, { 2 }), ls.i(4) })
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
