return {
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      local telescope = require("telescope")
      local builtin = require("telescope.builtin")
      local actions = require("telescope.actions")
      -- code

      telescope.load_extension("fzf")

      local keymap = vim.keymap

      keymap.set("n", "<leader>pf", builtin.find_files, { desc = "Project Find Files" })
      vim.keymap.set("n", "<leader>ps", function()
        builtin.grep_string({ search = vim.fn.input("Grep > ") })
      end, { desc = "Project Search" })
      keymap.set("n", "<leader>pg", builtin.live_grep, { desc = "Project By Grep in cwd" })
      keymap.set("n", "<leader>pd", builtin.diagnostics, { desc = "Project Diagnostics" })
      keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Project Help Tags" })
      keymap.set("n", "<leader>pof", builtin.oldfiles, { desc = "Project Find recent Files" })
      keymap.set("n", "<leader>pr", builtin.resume, { desc = "Project Resume" })

      vim.keymap.set("n", "<C-p>", builtin.git_files, { desc = "Telescope Git Files" })
      vim.keymap.set("n", "<leader>vh", builtin.help_tags, { desc = "Project Help Tags" })
    end,
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
    config = function()
      require("telescope").setup({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({
              -- even more opts
            }),

            -- pseudo code / specification for writing custom displays, like the one
            -- for "codeactions"
            -- specific_opts = {
            --   [kind] = {
            --     make_indexed = function(items) -> indexed_items, width,
            --     make_displayer = function(widths) -> displayer
            --     make_display = function(displayer) -> function(e)
            --     make_ordinal = function(e) -> string
            --   },
            --   -- for example to disable the custom builtin "codeactions" display
            --      do the following
            --   codeactions = false,
            -- }
          },
        },
      })
      require("telescope").load_extension("ui-select")
    end,
  },
}
