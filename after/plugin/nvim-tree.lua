-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

-- Key bindings
local function my_on_attach(bufnr)
    local keymap = vim.keymap.set
    local api = require "nvim-tree.api"

    local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    -- default mappings
    api.config.mappings.default_on_attach(bufnr)

    -- custom mappings
    keymap("n", "cd", api.tree.change_root_to_node, opts('CD'))
    keymap("n", "t", function()
        api.node.open.tab()
        api.tree.toggle()
    end, opts('Open: New Tab'))
    keymap("n", "v", api.node.open.vertical, opts('Open: Vertical Split'))
    keymap("n", "h", api.node.open.horizontal, opts('Open: Horizontal Split'))
    keymap("n", "cp", api.fs.copy.absolute_path, opts('Copy Absolute Path'))
end

require("nvim-tree").setup {
    on_attach = my_on_attach,
    sort = {
        sorter = "name",
    },
    view = {
        width = 30,
    },
    renderer = {
        group_empty = true,
        icons = {
            glyphs = {
                default = "",
                symlink = "",
                folder = {
                    arrow_closed = "",
                    arrow_open = "",
                    default = "",
                    open = "",
                    empty = "",
                    empty_open = "",
                    symlink = "",
                },
                git = {
                    unstaged = "",
                    staged = "S",
                    unmerged = "",
                    renamed = "➜",
                    deleted = "",
                    untracked = "U",
                    ignored = "◌",
                },
            }
        }
    },
    diagnostics = {
        enable = true,
        show_on_dirs = true,
        debounce_delay = 100
    },
    filters = {
        dotfiles = true,
        custom = {
            enable = true,
            "Applications",
            "Desktop",
            "go",
            "Music",
            "Movies",
            "Pictures",
            "Public",
        },
        -- List of directories or files to exclude from filtering: always show them.
        exclude = {
            ".config",
            ".local",
            ".ocamlformat",
            ".ocamlinit",
            ".zshrc",
            ".gitignore",
            ".aliases",
            "*.json"
        },
    },
    actions = {
        open_file = {
            quit_on_open = true,
        }
    },
    update_focused_file = {
        -- enable changing the focused file
        enable = true,
        update_root = {
            -- enable changing focused file if not in the root dir's tree
            enable = true
        }
    },
    prefer_startup_root = true,
}
