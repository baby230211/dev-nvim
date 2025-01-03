return {
  {
    -- "VonHeikemen/lsp-zero.nvim",
    -- branch = "v4.x",
    -- -- lazy = true,
    -- config = false,
  },
  -- Install all the language server
  {
    "williamboman/mason.nvim",
    config = function()
      local mason = require("mason")
      -- enable mason and configure icons
      mason.setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })
    end,
  },
  -- bridge between mason and lsp
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      local mason_lspconfig = require("mason-lspconfig")
      mason_lspconfig.setup({
        ensure_installed = {
          "lua_ls",
          "ts_ls",
        },
      })
    end,
  },

  -- Auto completion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
      -- "onsails/lspkind-nvim",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      require("luasnip.loaders.from_vscode").lazy_load()
      cmp.setup({
        completion = {
          completeopt = "menu,menuone,preview,noselect",
        },
        snippet = { -- configure how nvim-cmp interacts with snippet engine
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-p>"] = cmp.mapping.select_prev_item(), -- previous suggestion
          ["<C-n>"] = cmp.mapping.select_next_item(), -- next suggestion
          ["<C-u>"] = cmp.mapping.scroll_docs(-4),
          ["<C-d>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
          ["<C-e>"] = cmp.mapping.abort(), -- close completion window
          ["<CR>"] = cmp.mapping.confirm({ select = false }),
        }),
        -- sources for autocompletion
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" }, -- snippets
          { name = "buffer" }, -- text within current buffer
          { name = "path" }, -- file system paths
        }),
        -- configure lspkind for vs-code like pictograms in completion menu
        -- formatting = {
        --   format = lspkind.cmp_format({
        --     maxwidth = 50,
        --     ellipsis_char = "...",
        --   }),
        -- },
      })
    end,
  },

  -- configure neovim does between itself and the LSP server
  {
    "neovim/nvim-lspconfig",
    -- cmd = { "LspInfo", "LspInstall", "LspStart" },
    -- event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "hrsh7th/cmp-nvim-lsp" },
      { "williamboman/mason-lspconfig.nvim" },
    },
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
      })
      lspconfig.ts_ls.setup({
        capabilities = capabilities,
      })
      local map = function(keys, func, desc)
        vim.keymap.set("n", keys, func, { desc = "LSP: " .. desc })
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
      -- map("<C-h>", function()
      --   vim.lsp.buf.signature_help()
      -- end, "Show signature help")
      map("[d", function()
        vim.diagnostic.goto_prev()
      end, "Go to previous diagnostic")
      map("]d", function()
        vim.diagnostic.goto_next()
      end, "Go to next diagnostic")
    end,
  },
}
