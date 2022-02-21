local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

-- Remap space as leader key
keymap("", ",", "<Nop>", opts)
vim.g.mapleader = ","
vim.g.maplocalleader = "\\"

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --

-- Movement --
-- Move by line
keymap("n", "j", "gj", opts)
keymap("n", "k", "gk", opts)

-- Better window navigation
keymap("n", "<C-H>", "<C-W>h", term_opts)
keymap("n", "<C-J>", "<C-W>j", term_opts)
keymap("n", "<C-K>", "<C-W>k", term_opts)
keymap("n", "<C-L>", "<C-W>l", term_opts)

keymap("n", "<leader>nt", ":Lex 30<cr>", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Clean trailing whitespace --
keymap("n", "<leader>w", "mz: %s/\\s\\+$//<CR> :let @/=''<CR> `z", opts)

-- Select entire buffer
keymap("n", "vaa", "ggvGg_", opts)
keymap("n", "Vaa", "ggVG", opts)

-- Toggle [i]nvisible characters
keymap("n", "<leader><leader>i", ":set list!<cr>", opts)

-- Insert --
-- Press jk fast to <ESC>
keymap("i", "jk", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Terminal --
-- Better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

-- NvimTree --
keymap("n", "<leader>nt", "<CMD>NvimTreeToggle<CR>", opts)
keymap("n", "<leader>nr", "<CMD>NvimTreeRefresh<CR>", opts)

-- Rust inlay hints --
keymap("n", "<leader>rh", "<CMD>RustToggleInlayHints<CR>", opts)

-- Use sudo to write --
-- keymap("c", "w!!", "w !sudo tee % > /dev/null")

-- convert_spaces_to_snake_case
-- keymap("n", "<leader>sn", ":s/\> \</_/ge<cr> :noh <cr>", opts)  -- invalid escape sequence
keymap("i", "<leader>sn", "<ESC>F r_ea", opts)
-- keymap("v", "<leader>sn", ":s/\%V /_/g<cr> :noh <cr>", opts)  -- invalid escape sequence

-- convert-dash-case to snake_case
-- keymap("n", "<leader>dn", ":s/\>-\</_/ge<CR> :noh <CR>", opts)
-- keymap("i", "<leader>dn", "<ESC>:s/\>-\</_/ge<CR>:noh<CR>A", opts)

-- Upper case
keymap("i", "<leader><C-u>", "<ESC>viwUEa", opts)

-- Telescope
-- keymap("n", "<leader>f", "<cmd>Telescope find_files<cr>", opts)
keymap("n", "<leader>f", "<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = with_preview }))<cr>", opts)
keymap("n", "<leader>z", "<cmd>lua require'telescope'.extensions.zoxide.list((require('telescope.themes').get_dropdown({ previewer = with_preview })))<cr>", opts)
keymap("n", "<c-t>", "<cmd>Telescope live_grep<cr>", opts)

-- Folding keymaps
-- Space to toggle folds
keymap("n", "<SPACE>", "zA", opts)
keymap("v", "<SPACE>", "zA", opts)
keymap("n", "<S-SPACE>", "za", term_opts)
keymap("v", "<S-SPACE>", "za", term_opts)
