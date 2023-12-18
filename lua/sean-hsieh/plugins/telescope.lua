return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
	},
	config = function ()
		local telescope = require("telescope")
		local builtin = require("telescope.builtin")
		local actions = require("telescope.actions")
		-- code

		telescope.load_extension("fzf")


		local keymap = vim.keymap

		keymap.set("n", "<leader>pf", builtin.find_files, { desc = "Project Find Files" })
		keymap.set("n", "<leader>ps", function() 
			builtin.grep_string({ search = vim.fn.input("Grep > ") })
		end, { desc = "Project Find Files" })
		keymap.set("n", "<leader>pg", builtin.live_grep, { desc = "Project By Grep in cwd" })
		keymap.set("n", "<leader>pd", builtin.diagnostics, { desc = "Project Diagnostics" })
		keymap.set("n", "<leader>pof", builtin.oldfiles, { desc = "Project Find recent Files" })
		keymap.set("n", "<leader>pr", builtin.resume, { desc = "Project Resume" })

	end
}
