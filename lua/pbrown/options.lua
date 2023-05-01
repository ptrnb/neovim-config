local options = {
	backup = false, -- creates a backup file
	title = false, -- Disable the window title
	icon = false,
	clipboard = "unnamedplus", -- allows neovim to access the system clipboard
	cmdheight = 2, -- more space in the neovim command line for displaying messages
	completeopt = { -- Options for nvim-cmp
    "menu",
		"menuone", -- popup even when there's only one match
		"noinsert", -- do not insert text until a selection is made
		"noselect", -- force user to select from the popup menu
	},
	conceallevel = 0, -- so that `` is visible in markdown files
	fileencoding = "utf-8", -- the encoding written to a file
	ignorecase = true, -- ignore case in search patterns
	gdefault = true, -- default to substituting all matches on a line
	mouse = "a", -- allow the mouse to be used in neovim
	pumheight = 10, -- pop up menu height
	showmode = false, -- we don't need to see things like -- INSERT -- anymore
	showtabline = 1, -- only show tabs when there are at least two pages
	smartcase = true, -- smart case
	smartindent = true, -- make indenting smarter again
	splitbelow = true, -- force all horizontal splits to go below current window
	splitright = true, -- force all vertical splits to go to the right of current window
	swapfile = false, -- creates a swapfile
	termguicolors = true, -- set term gui colors (most terminals support this)
	timeout = true, -- enable timeout for key mappings
	timeoutlen = 800, -- time to wait for a mapped sequence to complete (in milliseconds)
	ttimeoutlen = 100, -- time to wait for key code sequence to complete (in milliseconds)
	undofile = true, -- enable persistent undo
	updatetime = 300, -- faster completion (4000ms default)
	writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
	expandtab = true, -- convert tabs to spaces
	shiftwidth = 2, -- the number of spaces inserted for each indentation
	tabstop = 2, -- insert 2 spaces for a tab
	cursorline = true, -- highlight the current line
	number = true, -- set numbered lines
	relativenumber = true, -- set relative numbered lines
	numberwidth = 5, -- set number column width to 5 {default 4}
	signcolumn = "yes", -- always show the sign column, otherwise it would shift the text each time
	wrap = false, -- display lines as one long line
	scrolloff = 8, -- is one of my fav
	sidescrolloff = 8,
	guifont = "Monoid Nerd Font:h14", -- the font used in graphical neovim applications
}

vim.opt.shortmess:append("c")

for k, v in pairs(options) do
	vim.opt[k] = v
end

vim.cmd("set whichwrap+=<,>,[,],h,l")
vim.cmd([[set iskeyword+=-,_]])
vim.cmd([[set formatoptions+=t,c,r,q,n,b]]) -- describes automatic formatting - see fo-table
vim.cmd([[set listchars=nbsp:¬,eol:¶,extends:»,precedes:«,trail:•]])
vim.cmd([[set fillchars+=eob:\ "]])

-- Disable matchit --
vim.g.loaded_matchit = 1

-- Rust configuration for rust.vim plugin --
vim.g.rust_recommended_style = 1
vim.g.rust_fold = 1

vim.g.rustfmt_autosave = 1

-- Terraform options
vim.g.terraform_fmt_on_save = 1
vim.g.terraform_align = 1

-- Neovide options
if vim.g.neovide then
  vim.o.guifont = "Monoid Nerd Font:h12"
  vim.opt.linespace = 12
  vim.g.neovide_padding_top = 25
  vim.g.neovide_padding_bottom = 25
  vim.g.neovide_padding_right = 25
  vim.g.neovide_padding_left = 25
  -- Helper function for transparency formatting
  local alpha = function()
    return string.format("%x", math.floor((255 * vim.g.transparency) or 0.95))
  end
  -- g:neovide_transparency should be 0 if you want to unify transparency of content and title bar.
  vim.g.neovide_transparency = 1
  vim.g.transparency = 0.95
  -- vim.g.neovide_background_color = "#0f1117" .. alpha()
  vim.g.neovide_scroll_animation_length = 0.3
  vim.g.neovide_hide_mouse_when_typing = true
  vim.g.neovide_confirm_quit = true
  vim.g.neovide_remember_window_size = true
  vim.g.neovide_cursor_animation_length = 0.05
  vim.g.neovide_cursor_animate_command_line = false
  vim.g.neovide_cursor_vfx_mode = "pixiedust"
end
