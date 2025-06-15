require("Comment").setup {
    opleader = {
        line = 'gc',
        block = 'gb',
    },
    mappings = {
        ---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
        basic = true,
        ---Extra mapping; `gco`, `gcO`, `gcA`
        extra = true,
    },
    ---Function to call before (un)comment
    pre_hook = nil,
    ---Function to call after (un)comment
    post_hook = nil,
    ---Lines to be ignored while (un)comment
    ignore = "^$",
}

-- Map languages that do not have mappings
local ft = require("Comment.ft")
ft.set('lua', { '--%s', "--[[%s]]" })
ft.set('python', { '#%s', '"""%s"""' })
ft.set('ocaml', { '(*%s*)' }, { '(*%s*)' })
