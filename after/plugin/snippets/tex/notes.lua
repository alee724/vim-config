local ls     = require("luasnip")
local fmta   = require("luasnip.extras.fmt").fmta
local extras = require("luasnip.extras")
local rep    = extras.rep

-- Anything I use mainly for taking notes would go here

local rec_tb
rec_tb       = function(_, _, _, amt)
    local nodes = { ls.i(1) }
    local count = amt or 0
    for ind = 2, count do
        table.insert(nodes, ls.t(" & "))
        table.insert(nodes, ls.i(ind))
    end
    table.insert(nodes, ls.t(" \\\\"))
    table.insert(nodes, ls.c(count + 1, {
        ls.t "",
        ls.sn(nil, { ls.t { "", "\t" }, ls.d(1, rec_tb, {}, { user_args = { amt } }) }),
        ls.sn(nil, { ls.t { "", "\t\\hline", "\t" }, ls.d(1, rec_tb, {}, { user_args = { amt } }) })
    }))
    return ls.sn(nil, nodes)
end

local rec_graph
rec_graph    = function()
    return ls.sn(nil,
        ls.c(1,
            { ls.t { "" }, ls.sn(nil,
                { ls.t { "", "\t  " }, ls.i(1), ls.t { " -- {" }, ls.i(2), ls.t "},", ls.d(3, rec_graph, {}) }) }))
end


local nonregex = {
    { -- creating a new paragraph
        ";;", ls.t "\\\\"
    },
    { -- section
        ";s ",
        fmta([[
        \section<>{<>} <>
        ]], { ls.c(1, { ls.t "*", ls.t "" }), ls.i(2), ls.i(0) })
    },
    { -- subsection
        ";ss ",
        fmta([[
        \subsection<>{<>} <>
        ]], { ls.c(1, { ls.t "*", ls.t "" }), ls.i(2), ls.i(0) })
    },
    { -- subsubsection
        ";sss ",
        fmta([[
        \subsubsection<>{<>} <>
        ]], { ls.c(1, { ls.t "*", ls.t "" }), ls.i(2), ls.i(0) })
    },
    { -- bold text
        ";bf ", fmta("\\textbf{<>} <>", { ls.i(1), ls.i(0) })
    },
    { -- italicized text
        ";it ", fmta("\\textit{<>} <>", { ls.i(1), ls.i(0) })
    },
    { -- item listing
        ";i ", fmta("\\item[<>] <>",
        { ls.c(1, {
            ls.t "",
            ls.t "-",
            fmta("(\\textbf{<>})", { ls.i(1) })
        }), ls.i(0) })
    },
    { -- make a box
        ";box ",
        fmta([[
        fbox{\\parbox{\\boxlength}{
            <>
        }} <>
        ]], { ls.i(1), ls.i(0) })
    },
    { --making a break
        ";b ",
        fmta([[\<><>]],
            { ls.c(1, { ls.t "medbreak", ls.t "smallbreak" }), ls.i(0) }
        )
    },
    { -- creating a new page
        ";np",
        ls.t "\\newpage"
    },
    { -- making a horizontal line
        ";hl",
        ls.t "\\hrule"
    },
    { -- begin
        ";beg",
        fmta([[
        \begin{<>}
            <>
        \end{<>} <>
        ]], { ls.i(1), ls.i(2), rep(1), ls.i(0) })
    },
    { -- tables
        ";tb ",
        fmta([[
        \begin{tabular}{<>}
            <>
        \end{tabular} <>
        ]], { ls.i(1),
            ls.d(2, function(args)
                local text = args[1][1] or ""
                return rec_tb(_, _, _, #text:gsub("%s", ""))
            end, { 1 }),
            ls.i(0) })
    },
    { -- for matrices
        ";mat ",
        fmta([[
        \begin{bmatrix}<>
            <>
        \end{bmatrix} <>
        ]], { ls.i(1),
            ls.d(2, function(args)
                local spaces = args[1][1] or ""
                return rec_tb(_, _, _, #spaces)
            end, { 1 }),
            ls.i(0) })
    },
    { -- for IPA
        ";ipa ",
        fmta([[
        \textipa{<>}<>
        ]], { ls.i(1), ls.i(0) })
    },
    { -- for a code like env
        ";code ",
        fmta([[
        \begin{lstlisting}[language=<>]
        <>
        \end{lstlisting}<>
        ]], { ls.c(1, { ls.t "Python", ls.t "" }), ls.i(2), ls.i(0) })
    },
    { -- for images
        ";img ",
        fmta([[
        \includegraphics[<>]{<>}\medbreak<>
        ]],
            { ls.c(1, { ls.t "", ls.t "scale=1", ls.t "width=0.45\\textwidth, keepaspectratio" }), ls.i(2, "image path"),
                ls.i(0) })
    },
    { -- for making a solving environment
        ";sol ",
        fmta([[
        \(\begin{aligned}
            <>
        \end{aligned}\) <>
        ]], { ls.i(1), ls.i(0) })
    },
    { -- for making &= between solving environment lines
        ";ae ",
        { ls.t "&= " }
    },
    { -- for vertex, edge graphs
        ";g ",
        fmta([[
        \begin{tikzpicture}
          \graph [spring layout] {
              <> -- {<>},<>
          };
        \end{tikzpicture} <>
        ]], { ls.i(1), ls.i(2), ls.d(3, function()
            return rec_graph()
        end), ls.i(0) })
    }
}

local regex = {
    { -- list
        "(.*);l ",
        fmta([[
    <>\begin{note}
    <>
    \end{note} <>
    ]], { ls.f(
            function(_, snip)
                local cap = snip.captures[1]:match("^%s*(.-)%s*$"):gsub("^%l", string.upper)
                if cap == "" then
                    return ""
                else
                    local res = "\\textbf{" .. cap .. "}"
                    return res
                end
            end
        ),
            ls.i(1), ls.c(2, { ls.t "", ls.t "\\medbreak" }) })
    },
    { -- list
        "(.*);t ",
        fmta([[
    <>\begin{note}
    <>
    \end{note} <>
    ]], { ls.f(
            function(_, snip)
                local cap = snip.captures[1]:match("^%s*(.-)%s*$"):gsub("^%l", string.upper)
                if cap == "" then
                    return ""
                else
                    local res = "\\textbf{" .. cap .. "}"
                    return res
                end
            end
        ),
            ls.i(1), ls.c(2, { ls.t "", ls.t "\\medbreak" }) })
    },

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
