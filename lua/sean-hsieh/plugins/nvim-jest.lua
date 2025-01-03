return {
  "mattkubej/jest.nvim",
  config = function()
    local jest = require("nvim-jest")
    jest.setup({
      -- Jest executable
      -- By default finds jest in the relative project directory
      -- To override with an npm script, provide 'npm test --' or similar

      -- Prevents tests from printing messages
    })
  end,
}
