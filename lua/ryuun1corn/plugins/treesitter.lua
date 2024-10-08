return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPre", "BufNewFile" },
	build = ":TSUpdate",
	dependencies = {
		"windwp/nvim-ts-autotag",
	},
	config = function()
		local treesitter = require("nvim-treesitter.configs")

		-- configure treesitter
		treesitter.setup({ -- enable syntax highlighting
			highlight = {
				enable = true,
			},
			-- enable indentation
			indent = { enable = true },

			-- ensure these language parsers are installed
			ensure_installed = {
				"bash",
				"c",
				"cmake",
				"cpp",
				"css",
				"dockerfile",
				"gitignore",
				"html",
				"htmldjango",
				"java",
				"javascript",
				"json",
				"lua",
				"make",
				"markdown",
				"markdown_inline",
				"python",
				"regex",
				"tsx",
				"typescript",
				"vim",
				"vimdoc",
				"yaml",
			},

			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<space>hi",
					node_incremental = "<space>hk",
					scope_incremental = false,
					node_decremental = "<space>hj",
				},
			},

			sync_install = false,
			ignore_install = {},
			auto_install = true,
			modules = {},
		})
	end,
}
