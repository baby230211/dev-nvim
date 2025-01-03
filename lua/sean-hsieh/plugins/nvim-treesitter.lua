return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      -- import nvim-treesitter plugin
      local treesitter = require("nvim-treesitter.configs")

      -- configure treesitter
      treesitter.setup({ -- enable syntax highlighting
        auto_install = true,
        highlight = {
          enable = true,
        },
        -- enable indentation
        indent = { enable = true },
        -- enable autotagging (w/ nvim-ts-autotag plugin)
        -- autotag = {
        --   enable = true,
        -- },
        -- ensure these language parsers are installed
        ensure_installed = {
          "vimdoc",
          "luadoc",
          "vim",
          "lua",
          "markdown",
        },
        -- enable nvim-ts-context-commentstring plugin for commenting tsx and jsx
        -- context_commentstring = {
        --   enable = true,
        --   enable_autocmd = false,
        -- },
      })
    end,
  },
}
