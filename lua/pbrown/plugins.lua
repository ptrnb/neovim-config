local fn = vim.fn

local lazypath = fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

-- Install your plugins here
local plugins = {
	-- My plugins here
	"nvim-lua/popup.nvim",   -- An implementation of the Popup API from vim in Neovim
	"nvim-lua/plenary.nvim",   -- Useful lua functions used by lots of plugins
	"justinmk/vim-sneak",   -- A better, faster forward search
	"nvim-lualine/lualine.nvim",   -- Lua status line
	"numToStr/Comment.nvim",   -- Easily comment stuff
	"windwp/nvim-autopairs",   -- Automatically pair braces and quotes
	"nvim-tree/nvim-web-devicons",   -- Provides icons for plugins when using a Nerdfont
	{
		"nvim-tree/nvim-tree.lua", -- File explorer in Lua
		dependencies = "nvim-tree/nvim-web-devicons",
	},
	{
		"akinsho/bufferline.nvim", -- Buffer statusline
    version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
	},

	-- LSP
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v2.x",
    dependencies = {
      "neovim/nvim-lspconfig",   -- enable LSP
      {
        "williamboman/mason.nvim",   -- manage installation of language servers
        build = function()
          pcall(vim.cmd, 'MasonUpdate')
        end,
      },
      "williamboman/mason-lspconfig.nvim",
      "simrat39/rust-tools.nvim",   -- rust-analyzer enhancements
      "jose-elias-alvarez/null-ls.nvim",   -- formatter and linter that links into LSP

      -- Completion
      "hrsh7th/nvim-cmp",   -- The completion plugin
      "hrsh7th/cmp-buffer",   -- buffer completions
      "hrsh7th/cmp-path",   -- path completions
      -- use 'hrsh7th/cmp-cmdline'                 -- cmdline completions
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-git",
      "saadparwaiz1/cmp_luasnip",   -- snippet completions

      -- Snippets
      "L3MON4D3/LuaSnip",   -- snippet engine
      "rafamadriz/friendly-snippets",   -- a bunch of snippets to use
      "honza/vim-snippets",   -- Snipmate stlye snippets
    }
  },

	"godlygeek/tabular",   -- Tabularize plugin

	-- Markdown --
	"ellisonleao/glow.nvim",   -- Console based markdown previewer using Glow

	-- GIT --
	"lewis6991/gitsigns.nvim",   -- Git integration for Neovim

	-- Colorschemes
	"jonathanfilip/vim-lucius",
	"EdenEast/nightfox.nvim",

	-- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate"
  },

  "p00f/nvim-ts-rainbow",
	"JoosepAlviste/nvim-ts-context-commentstring",
	"anuvyklack/pretty-fold.nvim",

	-- Terraform
	"hashivim/vim-terraform",   -- terraform plugin that supports fmt on save

  -- OPA rego
  "tsandall/vim-rego",   -- OPA rego syntax plugin

	-- Telescope
	{
    "nvim-telescope/telescope.nvim",
    tag = "0.1.1",
    dependencies = { "nvim-lua/plenary.nvim" }
  },
	"nvim-telescope/telescope-ui-select.nvim",   -- required by rust-tools
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build"
  },
	-- { "nvim-telescope/telescope-fzf-native.nvim", cmd = "make" },
	"jvgrootveld/telescope-zoxide",

	-- Debug
	"akinsho/toggleterm.nvim",
	"mfussenegger/nvim-dap",
	{ "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap" } },
}

local opts = {}

require("lazy").setup(plugins, opts)
