return {
    "mbbill/undotree",
    dependencies = {},
    config = function()
        local keymap = vim.keymap
        keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Toggle undotree" })
    end
}
