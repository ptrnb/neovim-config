local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Install your plugins here
return packer.startup(function(use)
	-- My plugins here
	use("wbthomason/packer.nvim") -- Have packer manage itself
	use("nvim-lua/popup.nvim") -- An implementation of the Popup API from vim in Neovim
	use("nvim-lua/plenary.nvim") -- Useful lua functions used by lots of plugins
	use("justinmk/vim-sneak") -- A better, faster forward search
	use("nvim-lualine/lualine.nvim") -- Lua status line
	use("numToStr/Comment.nvim") -- Easily comment stuff
	use("windwp/nvim-autopairs") -- Automatically pair braces and quotes
	use("kyazdani42/nvim-web-devicons") -- Provides icons for plugins when using a Nerdfont
	use({
		"kyazdani42/nvim-tree.lua", -- File explorer in Lua
		requires = "kyazdani42/nvim-web-devicons",
	})
	use({
		"akinsho/bufferline.nvim", -- Buffer statusline
		requires = "kyazdani42/nvim-web-devicons",
	})

	-- Markdown --
	use("ellisonleao/glow.nvim") -- Console based markdown previewer using Glow

	-- GIT --
	use("lewis6991/gitsigns.nvim") -- Git integration for Neovim

	-- Colorschemes
	use("jonathanfilip/vim-lucius")
	use("EdenEast/nightfox.nvim")

	-- Treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	})
	use("p00f/nvim-ts-rainbow")
	use("JoosepAlviste/nvim-ts-context-commentstring")
	use("anuvyklack/pretty-fold.nvim")

	-- Completion
	use("hrsh7th/nvim-cmp") -- The completion plugin
	use("hrsh7th/cmp-buffer") -- buffer completions
	use("hrsh7th/cmp-path") -- path completions
	-- use 'hrsh7th/cmp-cmdline'                 -- cmdline completions
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-nvim-lua")
	use("hrsh7th/cmp-git")
	use("saadparwaiz1/cmp_luasnip") -- snippet completions

	-- Snippets
	use("L3MON4D3/LuaSnip") -- snippet engine
	use("rafamadriz/friendly-snippets") -- a bunch of snippets to use
	use("honza/vim-snippets") -- Snipmate stlye snippets

	-- LSP
	use("neovim/nvim-lspconfig") -- enable LSP
	use("williamboman/nvim-lsp-installer") -- manage installation of language servers
	use("simrat39/rust-tools.nvim") -- rust-analyzer enhancements
	use("jose-elias-alvarez/null-ls.nvim") -- formatter and linter that links into LSP
	use("godlygeek/tabular") -- Tabularize plugin

	-- Terraform
	use("hashivim/vim-terraform") -- terraform plugin that supports fmt on save

	-- Rust
	-- use {
	--   'rust-lang/rust.vim',                  -- Rust syntax support
	--   enabled = false,
	-- }
	--
	-- Telescope
	use("nvim-telescope/telescope.nvim")
	use("nvim-telescope/telescope-ui-select.nvim") -- required by rust-tools
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
	use("jvgrootveld/telescope-zoxide")

	-- Debug
	use("akinsho/toggleterm.nvim")
	use("mfussenegger/nvim-dap")
	use({ "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } })

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
