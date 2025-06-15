local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set

-- Leader Key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Simple Shortcuts
keymap("n", "<leader>e", ":NvimTreeToggle<cr>", opts) -- opens explorer
keymap("n", "<leader>h", ":tab help<cr>", opts) -- opens help in new tab
keymap('t', '<esc>', '<C-\\><C-N>', opts) -- <esc> but in terminal
keymap("n", "œ", "ZQ", opts) -- closes current buff
keymap("n", "ç˙", ":checkhealth<cr>", opts) -- checkhealth shortcut

keymap("n", "fC", "zM", opts) -- closes all folds
keymap("n", "fO", "zR", opts) -- opens all folds
keymap("n", "fc", "zc", opts) -- closes all folds
keymap("n", "fo", "zo", opts) -- opens all folds

keymap("n", "t", "<CMD>lua require('FTerm').toggle()<CR>", opts) -- opens terminal
keymap('n', '<leader>t', vim.cmd.UndotreeToggle) -- opens undotree

-- disable the arrow keys to force learning to use hjkl
keymap({ "n", "v" }, "<left>", ":echo 'No left for you!'<CR>")
keymap({ "n", "v" }, "<right>", ":echo 'No right for you!'<CR>")
keymap({ "n", "v" }, "<up>", ":echo 'No up for you!'<CR>")
keymap({ "n", "v" }, "<down>", ":echo 'No down for you!'<CR>")

-- keymaps for improving navigation on the current window
keymap({ "v", "n" }, "j", "gj")
keymap({ "v", "n" }, "k", "gk")
keymap({ "v", "n" }, "¨", "<C-u>")
keymap({ "v", "n" }, "Î", "<C-d>")

-- Window Navigation
keymap("n", "Ó", "<C-w>h", opts)
keymap("n", "Ô", "<C-w>j", opts)
keymap("n", "", "<C-w>k", opts)
keymap("n", "Ò", "<C-w>l", opts)

keymap("n", "˙", "gT", opts) -- moves to the left tab
keymap("n", "¬", "gt", opts) -- moves to the right tab
keymap("n", "<leader>nt", ":tabnew<cr>", opts) -- creates new tab

keymap("n", "<leader>vs", ":vne<cr>", opts) -- vertical split
keymap("n", "<leader>hs", ":ne<cr>", opts) -- horizontal split

-- Text Editing
keymap("v", "<", "<gv^", opts) -- shift text to the left
keymap("v", ">", ">gv^", opts) -- shift text to the right
keymap({ "n", "v" }, "<leader>y", "\"+y", opts) -- copies whole paragraph
keymap({ "n", "v" }, "<leader>Y", "\"+Y", opts) -- copies whole line
keymap("v", "∆", ":m '>+1<cr>gv=gv", opts) -- moves highlighted text down
keymap("v", "˚", ":m '<-2<cr>gv=gv", opts) -- moves highlighted text up

keymap("x", "<leader>p", "\"_dP", opts) -- keeps copied text

-- edits word that the cursor is on
keymap("n", "<leader>r", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- formatting
keymap("n", "<leader>f", function() -- formatting
    vim.lsp.buf.format()
    vim.cmd.normal("zC")
end)

-- telescope seems to be broken and can't create keymaps so I put it here
local gen_dirs = { "~/Documents", "~/.config/nvim", "~/.zshrc", "~/Notes/", "~/Library/texmf/" }
keymap('n', '<leader>ff', function()
    require('telescope.builtin').find_files(require('telescope.themes').get_dropdown({
        previewer = false,
        search_dirs = gen_dirs,
    }))
end)

keymap("n", "<leader>gg", function()
    require('telescope.builtin').live_grep {
        layout_strategy = "horizontal",
        shorten_path = true,
        search_dirs = gen_dirs,
        layout_config = {
            height = 0.8,
            width = 0.9,
            preview_width = 0.7,
        } }
end)

-- for opening the html file in the web browser
vim.keymap.set('n', '<leader>b', '<cmd>BrowserPreview<CR>')
