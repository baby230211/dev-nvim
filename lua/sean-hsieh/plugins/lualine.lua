return {
  --- Set lualine as statusline
  "nvim-lualine/lualine.nvim",
  -- See `:help lualine.txt`,
  config = function()
    require("lualine").setup({
      options = {
        theme = "onedark",
        globalstatus = true,
        disabled_filetypes = { statusline = { "dashboard", "alpha", "starter" } },
      },

      sections = {
        lualine_c = {
          {
            "filename",
            path = 1,
          },
        },
      },
    })
  end,
}
