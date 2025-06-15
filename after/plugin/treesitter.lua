require("lazy").setup({{
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function () 
      local configs = require("nvim-treesitter.configs")

      configs.setup({
          ensure_installed = { 
              "c", 
              "lua", 
              "vim", 
              "vimdoc", 
              "python", 
              "ocaml", 
              "java", 
              "json", 
              "latex", 
              "sql" 
          },
          sync_install = false,
          highlight = { 
              enable = true, 
              additional_vim_regex_highlighting = true 
          },
        })
    end
 }})


