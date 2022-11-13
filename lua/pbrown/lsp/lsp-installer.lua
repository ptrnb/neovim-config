local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
	return
end

-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).
lsp_installer.on_server_ready(function(server)
	local opts = {
		on_attach = require("pbrown.lsp.handlers").on_attach,
		capabilities = require("pbrown.lsp.handlers").capabilities,
	}

	-- Initialise the LSP with rust-tools instead
	if server.name == "rust_analyzer" then
		local extension_path = vim.env.HOME .. "/.vscode/extensions/vadimcn.vscode-lldb-1.6.10/"
		local codelldb_path = extension_path .. "adapter/codelldb"
		local liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"
		local rust_tool_opts = {
			autoSetHints = true,
			-- hover_with_actions = true,
			executor = require("rust-tools/executors").termopen,
			runnables = {
				use_telescope = true,
			},
			debuggables = {
				use_telescope = true,
			},
			inlay_hints = {
				only_current_line = true,
			},
			hover_actions = {
				-- the border that is used for the hover window
				-- see vim.api.nvim_open_win()
				border = {
					{ "╭", "FloatBorder" },
					{ "─", "FloatBorder" },
					{ "╮", "FloatBorder" },
					{ "│", "FloatBorder" },
					{ "╯", "FloatBorder" },
					{ "─", "FloatBorder" },
					{ "╰", "FloatBorder" },
					{ "│", "FloatBorder" },
				},

				-- whether the hover action window gets automatically focused
				auto_focus = false,
			},
		}
		require("rust-tools").setup({
			tools = rust_tool_opts,
			server = vim.tbl_deep_extend("force", server:get_default_options(), opts),
			dap = {
				adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
			},
		})
		server:attach_buffers()
		return
	end

	if server.name == "sumneko_lua" then
		local sumneko_opts = require("pbrown.lsp.settings.sumneko_lua")
		opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
	end

	if server.name == "tflint" then
		local tflint_opts = require("pbrown.lsp.settings.tflint")
		opts = vim.tbl_deep_extend("force", tflint_opts, opts)
	end

	if server.name == "terraformls" then
		local terraformls_opts = require("pbrown.lsp.settings.terraformls")
		opts = vim.tbl_deep_extend("force", terraformls_opts, opts)
	end

	-- This setup() function is exactly the same as lspconfig's setup function.
	-- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
	server:setup(opts)
end)
