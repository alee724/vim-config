local ls = require("luasnip")
local types = require("luasnip.util.types")

-- configure luasnip
ls.config.set_config({
    history = true,
    updateevents = { "TextChanged", "TextChangedI" },
    enable_autosnippets = true,
    ext_opts = {
        [types.choiceNode] = {
            active = {
                virt_text = { { "©", "choice_node" } },
                hl_mode = "combine"
            }
        },
    },
})

opts = { silent = true }
-- create the key bindings for luasnip
vim.keymap.set({ "s", "i" }, "˚", function()
    if ls.expand_or_jumpable() then
        ls.expand_or_jump()
    end
end, opts)
vim.keymap.set({ "s", "i" }, "∆", function()
    if ls.jumpable(-1) then
        ls.jump(-1)
    end
end, opts)
vim.keymap.set("i", "¬", function()
    if ls.choice_active() then
        ls.change_choice(1)
    end
end, opts)

-- directory location to load in snippets from
require("luasnip.loaders.from_lua").lazy_load({ paths = "~/.config/nvim/after/plugin/snippets/" })
