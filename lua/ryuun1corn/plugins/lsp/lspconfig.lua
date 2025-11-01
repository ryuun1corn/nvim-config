return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/neodev.nvim", opts = {} },
	},
	config = function()
		-- import cmp-nvim-lsp plugin
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		local keymap = vim.keymap -- for conciseness

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				-- buffer local mappings
				-- See ':help vim.lsp.*' for documentations on any of the functions below
				local opts = { buffer = ev.buf, silent = true }

				-- set keybinds
				opts.desc = "Show LSP references"
				keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

				opts.desc = "Go to declaration"
				keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

				opts.desc = "Show LSP definitions"
				keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

				opts.desc = "Show LSP implementations"
				keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

				opts.desc = "Show LSP type definitions"
				keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

				opts.desc = "See available code actions"
				keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

				opts.desc = "Smart rename"
				keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

				opts.desc = "Show buffer diagnostics"
				keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

				opts.desc = "Show line diagnostics"
				keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

				opts.desc = "Go to previous diagnostic"
				keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

				opts.desc = "Go to next diagnostic"
				keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

				opts.desc = "Show documentation for what is under cursor"
				keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

				opts.desc = "Restart LSP"
				keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
			end,
		})

		-- used to enable autocompletion (assign to every lsp server config)
		local capabilities = cmp_nvim_lsp.default_capabilities()
		capabilities.textDocument.completion.completionItem.snippetSupport = true

		-- Apply cmp capabilities to ALL LSP clients by default (0.11+ feature)
		vim.lsp.config("*", {
			capabilities = capabilities,
		})

		-- Emmet (use the newer server name)
		-- Docs + options: https://github.com/olrtg/emmet-language-server
		vim.lsp.config("emmet_language_server", {
			filetypes = {
				"html",
				"htmldjango",
				"css",
				"sass",
				"scss",
				"less",
				"javascriptreact",
				"typescriptreact",
				"svelte",
				"pug",
				"eruby",
			},
			init_options = {
				-- Emmet preferences (maps your old ["bem.enabled"] option)
				preferences = { ["bem.enabled"] = true },
				showExpandedAbbreviation = "always",
			},
		})

		-- Lua (with neodev; keep your “vim” global + snippet behavior)
		vim.lsp.config("lua_ls", {
			settings = {
				Lua = {
					diagnostics = { globals = { "vim" } },
					completion = { callSnippet = "Replace" },
				},
			},
		})

		-- Jinja (jinja-lsp)
		-- Install via Mason (“jinja-lsp”) or `cargo install jinja-lsp`
		vim.lsp.config("jinja_lsp", {
			cmd = { "jinja-lsp" },
			-- Attach on these filetypes; include Django templates if you want it there
			filetypes = { "jinja", "htmldjango" },
			-- Simple, fast root detection (0.11+ supports root_markers directly)
			root_markers = { ".git", "pyproject.toml", "manage.py" },
			settings = {
				jinja = {
					env = { django = true, customTags = {}, customFilters = {} },
					trim_blocks = true,
					lstrip_blocks = true,
				},
			},
		})

		-- HTML (extend to work on htmldjango too)
		vim.lsp.config("html", {
			filetypes = { "html", "htmldjango" },
		})

		-- If you use mason-lspconfig, prefer managing enablement yourself
		local ok_mlsp, mlsp = pcall(require, "mason-lspconfig")
		if ok_mlsp then
			mlsp.setup({
				ensure_installed = {
					"lua_ls",
					"html",
					"emmet_language_server",
					"jinja_lsp",
				},
				automatic_enable = false, -- we call vim.lsp.enable() below
			})
		end

		-- Finally, enable the servers (0.11+ supports enabling a list)
		vim.lsp.enable({ "emmet_language_server", "lua_ls", "jinja_lsp", "html" })

		-- Change the Diagnostic symbols in the sign column (gutter)
		-- (not in youtube nvim video)
		-- local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		-- for type, icon in pairs(signs) do
		-- 	local hl = "DiagnosticSign" .. type
		-- 	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		-- end

		-- mason_lspconfig.setup_handlers({
		-- 	-- default handler for installed servers
		-- 	function(server_name)
		-- 		lspconfig[server_name].setup({
		-- 			capabilities = capabilities,
		-- 		})
		-- 	end,

		-- 	["emmet_ls"] = function()
		-- 		-- configure emmet language server
		-- 		lspconfig["emmet_ls"].setup({
		-- 			capabilities = capabilities,
		-- 			filetypes = {
		-- 				"html",
		-- 				"htmldjango",
		-- 				"typescriptreact",
		-- 				"javascriptreact",
		-- 				"css",
		-- 				"sass",
		-- 				"scss",
		-- 				"less",
		-- 				"svelte",
		-- 			},
		-- 			init_options = {
		-- 				html = {
		-- 					options = {
		-- 						-- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
		-- 						["bem.enabled"] = true,
		-- 					},
		-- 				},
		-- 			},
		-- 		})
		-- 	end,

		-- 	["lua_ls"] = function()
		-- 		-- configure lua server (with special settings)
		-- 		lspconfig["lua_ls"].setup({
		-- 			capabilities = capabilities,
		-- 			settings = {
		-- 				Lua = {
		-- 					-- make the language server recognize "vim" global
		-- 					diagnostics = {
		-- 						globals = { "vim" },
		-- 					},
		-- 					completion = {
		-- 						callSnippet = "Replace",
		-- 					},
		-- 				},
		-- 			},
		-- 		})
		-- 	end,

		-- 	["jinja_lsp"] = function()
		-- 		lspconfig["jinja_lsp"].setup({
		-- 			capabilities = capabilities,
		-- 			cmd = { "jinja-lsp" },
		-- 			filetypes = { "htmldjango" },
		-- 			root_dir = function(fname)
		-- 				return lspconfig.util.find_git_ancestor(fname)
		-- 			end,
		-- 			settings = {
		-- 				jinja = {
		-- 					env = {
		-- 						django = true,
		-- 						customTags = {},
		-- 						customFilters = {},
		-- 					},
		-- 					trim_blocks = true,
		-- 					lstrip_blocks = true,
		-- 				},
		-- 			},
		-- 		})
		-- 	end,

		-- 	["html"] = function()
		-- 		lspconfig["html"].setup({
		-- 			capabilities = capabilities,
		-- 			filetypes = { "html", "htmldjango" },
		-- 		})
		-- 	end,
		-- })
	end,
}
