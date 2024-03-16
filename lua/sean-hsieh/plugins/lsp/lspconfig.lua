return {
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v3.x",
    lazy = true,
    config = false,
    init = function()
      -- Disable automatic setup, we are doing it manually
      vim.g.lsp_zero_extend_cmp = 0
      vim.g.lsp_zero_extend_lspconfig = 0
    end,
  },
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = true,
  },

  -- Autocompletion

  -- LSP
  {
    "neovim/nvim-lspconfig",
    cmd = { "LspInfo", "LspInstall", "LspStart" },
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "hrsh7th/cmp-nvim-lsp" },
      { "williamboman/mason-lspconfig.nvim" },
    },
    config = function()
      -- This is where all the LSP shenanigans will live
      local lsp_zero = require("lsp-zero")
      lsp_zero.extend_lspconfig()

      lsp_zero.on_attach(function(client, bufnr)
        -- see :help lsp-zero-keybindings
        -- to learn the available actions
        -- local opts = { buffer = bufnr, remap = false }
        local map = function(keys, func, desc) 
          vim.keymap.set("n", keys, func, { buffer = bufnr, desc = 'LSP: ' .. desc })
        end

        map("gd", function()
          vim.lsp.buf.definition()
        end, "Go to definition")
        map("gr", function()
          vim.lsp.buf.references()
        end, "Go to references")
        map("gI", function()
          vim.lsp.buf.implementation()
        end, "Go to implementation")
        map("K", function()
          vim.lsp.buf.hover()
        end, "Show hover")

        map("<leader>vd", function()
          vim.diagnostic.open_float()
        end, "Show diagnostics [Error] messages")

        map("<leader>vca", function()
          vim.lsp.buf.code_action()
        end, "Show code actions")
        map("<leader>vws", function()
          vim.lsp.buf.workspace_symbol()
        end, "Search workspace symbols")
        map("<leader>vrn", function()
          vim.lsp.buf.rename()
        end, "Rename")
        map("<leader>vrn", function()
          vim.lsp.buf.rename()
        end, "Rename")
        map("<C-h>", function()
          vim.lsp.buf.signature_help()
        end, "Show signature help")
        map("[d", function()
          vim.diagnostic.goto_prev()
        end, "Go to previous diagnostic")
        map("]d", function()
          vim.diagnostic.goto_next()
        end, "Go to next diagnostic")

        lsp_zero.default_keymaps({ buffer = bufnr })
      end)

      require("mason-lspconfig").setup({
        ensure_installed = {},
        handlers = {
          lsp_zero.default_setup,
          lua_ls = function()
            -- (Optional) Configure lua language server for neovim
            local lua_opts = lsp_zero.nvim_lua_ls()
            require("lspconfig").lua_ls.setup(lua_opts)
          end,
        },
      })
    end,
  },
}
