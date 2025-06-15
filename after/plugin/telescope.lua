require('telescope').setup {
    defaults = {
        prompt_prefix = " ",
        selection_caret = " ",
        path_display = {}, -- "smart"

        mappings = {
            i = {
            }
        },
        file_ignore_patterns = {
            "aux/", "anime/", "_build/", ".*%.pdf", ".*%.png", ".*%.img", ".*%..tf", "__pycache__/"
        },
    },
    pickers = {
        -- Default configuration for builtin pickers goes here:
        -- picker_name = {
        --   picker_config_key = value,
        --   ...
        -- }
        -- Now the picker_config_key will be applied every time you call this
        -- builtin picker
    },
    extensions = {
        fzf = {
            fuzzy = true,                   -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true,    -- override the file sorter
            case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
        }
    }
}

-- 'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = false })
local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>ff', function()
    builtin.find_files(require('telescope.themes').get_dropdown({
        previewer = false,
        search_dirs = { "~/Documents", "~/.config/nvim", "~/.zshrc" },
        no_ignore = false,
    }))
end)

vim.keymap.set("n", "<leader>gg", function()
    builtin.live_grep {
        layout_strategy = "horizontal",
        shorten_path = true,
        search_dirs = { "~/Documents", "~/.config/nvim" },
        width = 0.4,
        layout_config = {
            height = 0.5,
            width = 0.80,
            preview_width = 0.60,
        },
        no_ignore = true,
    }
end)
