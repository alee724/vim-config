-- Took this code from L3MON4D3

local ls = require "luasnip"

local function char_count_same(c1, c2)
    local line = vim.api.nvim_get_current_line()
    -- '%'-escape chars to force explicit match (gsub accepts patterns).
    -- second return value is number of substitutions.
    local _, ct1 = string.gsub(line, '%' .. c1, '')
    local _, ct2 = string.gsub(line, '%' .. c2, '')
    return ct1 == ct2
end

local function even_count(c)
    local line = vim.api.nvim_get_current_line()
    local _, ct = string.gsub(line, c, '')
    return ct % 2 == 0
end

local function neg(fn, ...)
    return not fn(...)
end

local function part(fn, ...)
    local args = { ... }
    return function() return fn(unpack(args)) end
end

-- This makes creation of pair-type snippets easier.
local function pair(pair_begin, pair_end, expand_func, auto, ...)
    -- triggered by opening part of pair, wordTrig=false to trigger anywhere.
    -- ... is used to pass any args following the expand_func to it.
    local context = {
        trig = pair_begin,
        wordTrig = false
    }
    if auto then
        context["snippetType"] = "autosnippet"
    end

    return ls.s(context, {
        ls.t({ pair_begin }), ls.i(1), ls.t({ pair_end })
    }, {
        condition = part(expand_func, part(..., pair_begin, pair_end))
    })
end

local res = {
    pair("(", ")", neg, true, char_count_same),
    pair("{", "}", neg, true, char_count_same),
    pair("[", "]", neg, true, char_count_same),
    pair("<", ">", neg, true, char_count_same),
    pair("'", "'", neg, true, even_count),
    pair('"', '"', neg, true, even_count),
    pair("`", "`", neg, true, even_count),
}

return res
