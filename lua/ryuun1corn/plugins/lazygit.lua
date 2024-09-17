return {
	"kdheepak/lazygit.nvim",
	cmd = {
		"LazyGit",
		"LazyGitConfig",
		"LazyGitCurrentFile",
		"LazyGitFilter",
		"LazyGitFilterCurrentFile",
	},

	dependencies = { -- optional, for floating window border decoration
		"nvim-lua/plenary.nvim",
	},

	-- setting the keybinding for LazyGit with 'keys' is recommended in
	-- order to load the plugin when the command is ran for the first time
	keys = {
		{ "<leader>lg", "<cmd>LazyGit<cr>", desc = "Open Lazy Git" },
	},
}
