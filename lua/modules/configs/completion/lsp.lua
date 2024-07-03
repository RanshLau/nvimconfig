return function()
	local nvim_lsp = require("lspconfig", {
		diagnostics = {
			underline = true,
			update_in_insert = true,
			virtual_text = {
				spacing = 4,
				source = "if_many",
				-- prefix = "●",
				-- this will set set the prefix to a function that returns the diagnostics icon based on the severity
				-- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
				-- prefix = "icons",
			},
			severity_sort = true,
			-- signs = {
			-- 	text = {
			-- 		[vim.diagnostic.severity.ERROR] = LazyVim.config.icons.diagnostics.Error,
			-- 		[vim.diagnostic.severity.WARN] = LazyVim.config.icons.diagnostics.Warn,
			-- 		[vim.diagnostic.severity.HINT] = LazyVim.config.icons.diagnostics.Hint,
			-- 		[vim.diagnostic.severity.INFO] = LazyVim.config.icons.diagnostics.Info,
			-- 	},
			-- },
		},
		-- Enable this to enable the builtin LSP inlay hints on Neovim >= 0.10.0
		-- Be aware that you also will need to properly configure your LSP server to
		-- provide the inlay hints.
		inlay_hints = {
			enabled = true,
			exclude = {}, -- filetypes for which you don't want to enable inlay hints
		},
		codelens = {
			enabled = true,
		},
		document_highlight = {
			enabled = true,
		},
		capabilities = {
			workspace = {
				fileOperations = {
					didRename = true,
					willRename = true,
				},
			},
		},
		format = {
			formatting_options = nil,
			timeout_ms = nil,
		},
		setup = {
			eslint = function()
				local function get_client(buf)
					return LazyVim.lsp.get_clients({ name = "eslint", bufnr = buf })[1]
				end

				local formatter = LazyVim.lsp.formatter({
					name = "eslint: lsp",
					primary = false,
					priority = 200,
					filter = "eslint",
				})

				-- Use EslintFixAll on Neovim < 0.10.0
				if not pcall(require, "vim.lsp._dynamic") then
					formatter.name = "eslint: EslintFixAll"
					formatter.sources = function(buf)
						local client = get_client(buf)
						return client and { "eslint" } or {}
					end
					formatter.format = function(buf)
						local client = get_client(buf)
						if client then
							local diag = vim.diagnostic.get(buf, { namespace = vim.lsp.diagnostic.get_namespace(client.id) })
							if #diag > 0 then
								vim.cmd("EslintFixAll")
							end
						end
					end
				end

				-- register the formatter with LazyVim
				LazyVim.format.register(formatter)
			end,
		},
	})
	require("completion.neoconf").setup()
	require("completion.mason").setup()
	require("completion.mason-lspconfig").setup()

	local opts = {
		capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
	}
	-- Setup lsps that are not supported by `mason.nvim` but supported by `nvim-lspconfig` here.
	if vim.fn.executable("dart") == 1 then
		local ok, _opts = pcall(require, "user.configs.lsp-servers.dartls")
		if not ok then
			_opts = require("completion.servers.dartls")
		end
		local final_opts = vim.tbl_deep_extend("keep", _opts, opts)
		nvim_lsp.dartls.setup(final_opts)
	end


	vim.api.nvim_command([[LspStart]]) -- Start LSPs
end
