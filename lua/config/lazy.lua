local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
    -- games
    'ThePrimeagen/vim-be-good',

    -- Fuzzy Finding
    { 'nvim-telescope/telescope-fzf-native.nvim', build = "make" },
    { 'nvim-treesitter/nvim-treesitter',          build = ":TSUpdate" },
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim', -- search through files

    -- utility
    { 'numToStr/Comment.nvim', lazy = false, }, -- for easier commenting
    'Pocco81/auto-save.nvim',                   -- auto saves on stop edit
    'mbbill/undotree',
    "nvim-tree/nvim-tree.lua",                  -- nvim tree i.e. the tree explorer that opens to the left
    'nvim-tree/nvim-web-devicons',              -- used in nvim-tree for the little icons
    "numToStr/FTerm.nvim",                      -- used for a popup terminal

    -- Aesthetics
    'itchyny/lightline.vim',          -- better ui for modes on the bottom
    'lukas-reineke/virt-column.nvim', -- vertical column to the right
    "p00f/nvim-ts-rainbow",           -- color parethesis
    "catppuccin/nvim",                -- color scheme

    -- LSP and Autocompletion
    { -- For automating LSP
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
        { 'VonHeikemen/lsp-zero.nvim', branch = 'v3.x' },
    },

    {                           -- Autocompletion
        "hrsh7th/nvim-cmp",     -- The completion plugin
        "hrsh7th/cmp-buffer",   -- buffer completions
        "hrsh7th/cmp-path",     -- path completions
        "hrsh7th/cmp-cmdline",  -- cmdline completions
        "hrsh7th/cmp-nvim-lua", -- completion for lua
        "hrsh7th/cmp-nvim-lsp",
    },

    -- snippets
    {
        'L3MON4D3/LuaSnip',
        'saadparwaiz1/cmp_luasnip'
    },

    -- for coding or compilation stuff
    "lervag/vimtex", -- for latex specifically
    {                -- for html preview
        'ray-x/web-tools.nvim',
        dependencies = {
            "nvim-lua/plenary.nvim"
        },
    },
    "mistweaverco/kulala.nvim",
    --[[ "azratul/expose-localhost.nvim", -- for exposing site to internet with cloudflare later ]]
}

local opts = {}

require("lazy").setup(plugins, opts)
