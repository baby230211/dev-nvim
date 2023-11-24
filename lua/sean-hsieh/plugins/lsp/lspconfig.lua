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
        local nmap = function(keys, func, desc)
          if desc then
            desc = "LSP: " .. desc
          end

          vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc, remap = false })
        end
        -- to learn the available actions
        lsp_zero.default_keymaps({ buffer = bufnr })
        vim.keymap.set("n", "<leader>vca", function()
          vim.lsp.buf.code_action()
        end, { buffer = bufnr, remap = false })
        vim.keymap.set("n", "<leader>vrr", function()
          vim.lsp.buf.references()
        end, { buffer = bufnr, remap = false })
        vim.keymap.set("n", "<leader>vrn", function()
          vim.lsp.buf.rename()
        end, { buffer = bufnr, remap = false })
        vim.keymap.set("n", "<C-h>", function()
          vim.lsp.buf.signature_help()
        end, { buffer = bufnr, remap = false })
        nmap("gd", function()
          require("telescope.builtin").lsp_definitions({ jump_type = "vsplit" })
        end, "[G]oto [D]efinition")
        nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
        nmap("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
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
