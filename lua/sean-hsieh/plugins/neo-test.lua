return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "rouge8/neotest-rust",
    },
    keys = {
      {
        "<leader>co",
        function()
          require("neotest").output.open({ enter = true })
        end,
        desc = "Open test",
      },
      {
        "<leader>cT",
        function()
          require("neotest").run.run(vim.fn.expand("%"))
        end,
        desc = "All tests",
      },
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-rust")({
            args = { "--nocapture" },
          }),
        },
      })
    end,
  },
}
