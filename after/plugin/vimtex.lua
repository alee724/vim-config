vim.g.vimtex_view_method = "sioyek"
vim.g.vimtex_compiler_method = "latexmk"

-- 1 to enable, 0 to disable
vim.g.vimtex_view_automatic = 1

vim.g.vimtex_compiler_latexmk = {
    aux_dir = "out", -- create a directory called out that will contain all the auxiliary files
    out_dir = "out", -- set the out_dir to be the same as the aux_dir as I don't care about seeing these files
}

-- set some keymaps
opts = { noremap = false, silent = true }
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    pattern = { "*.tex" },
    callback = function()
        vim.keymap.set("n", "<leader>c", ":VimtexCompile<CR>", opts)
        vim.keymap.set("n", "<leader>o", ":VimtexView<CR>", opts)
        vim.api.nvim_set_keymap("n", "csm", "<plug>(vimtex-env-change-math)", opts)
        vim.api.nvim_set_keymap("n", "tsm", "<plug>(vimtex-env-toggle-math)", opts)
        vim.api.nvim_set_keymap("n", "<leader>v", "<plug>(vimtex-view)", opts)
    end
})
