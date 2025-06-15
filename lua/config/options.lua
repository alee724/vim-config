local options = {
    shiftwidth = 4,
    tabstop = 4,
    expandtab = true,
    smartindent = true,
    showtabline = 4,

    number = true,
    relativenumber = true,
    numberwidth = 4,

    fileencoding = "utf-8",

    hlsearch = false,
    incsearch = true,
    ignorecase = true,
    mouse = "a",
    cursorline = true,

    swapfile = false,
    backup = false,
    undodir = os.getenv("HOME") .. "/.vim/undodir",
    undofile = true,

    sidescrolloff = 8,

    updatetime = 50,
    tm = 500,

    splitbelow = true,
    splitright = true,

    colorcolumn = "100",
    modifiable = true,
    acd = true,
    laststatus = 2,
    showmode = false,
    termguicolors = true,
    linebreak = true,

    textwidth = 100,

    -- for folding lines
    foldmethod = "marker",
    foldmarker = "START,END",
    foldlevel = 1
}


function _G.fold_text()
    local start = vim.v.foldstart
    local finish = vim.v.foldend
    local lines = vim.api.nvim_buf_get_lines(0, start - 1, finish, false)

    for i = 2, #lines do
        if lines[i]:match("%S") then
            return lines[i] .. " ..."
        end
    end

    return lines[1] .. " ..."
end

vim.opt.foldtext = "v:lua.fold_text()"


for option, value in pairs(options) do
    vim.opt[option] = value
end
vim.cmd("filetype plugin on")

vim.o.timeout = true
vim.o.timeoutlen = 300

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = { "*.doc", "*.docx" },
    callback = function()
        vim.opt_local.textwidth = 80
    end,
})
