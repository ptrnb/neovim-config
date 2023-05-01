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

-- Normal mappings --

-- Move by line
keymap("n", "j", "gj", opts)
keymap("n", "k", "gk", opts)

-- Better window navigation
keymap("n", "<C-H>", "<C-W>h", term_opts)
keymap("n", "<C-J>", "<C-W>j", term_opts)
keymap("n", "<C-K>", "<C-W>k", term_opts)
keymap("n", "<C-L>", "<C-W>l", term_opts)

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

-- NvimTree --
keymap("n", "<leader>nt", "<CMD>NvimTreeToggle<CR>", opts)
keymap("n", "<leader>nr", "<CMD>NvimTreeRefresh<CR>", opts)

-- Rust inlay hints --
keymap("n", "<leader>rh", "<CMD>RustToggleInlayHints<CR>", opts)

-- Telescope
keymap("n", "<leader>f", "<cmd>Telescope find_files<cr>", opts)
keymap("n", "<leader>tf", "<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = with_preview }))<cr>", opts)
keymap("n", "<leader>tz", "<cmd>lua require'telescope'.extensions.zoxide.list((require('telescope.themes').get_dropdown({ previewer = with_preview })))<cr>", opts)
keymap("n", "<leader>tg", "<cmd>Telescope live_grep<cr>", opts)

-- Insert mappings --

-- Press jk fast to <ESC>
keymap("i", "dv", "<ESC>", opts)

-- convert_spaces_to_snake_case
-- keymap("n", "<leader>sn", ":s/\> \</_/ge<cr> :noh <cr>", opts)  -- invalid escape sequence
keymap("i", "<leader>sn", "<ESC>F r_ea", opts)
-- keymap("v", "<leader>sn", ":s/\%V /_/g<cr> :noh <cr>", opts)  -- invalid escape sequence

-- convert-dash-case to snake_case
-- keymap("n", "<leader>dn", ":s/\>-\</_/ge<CR> :noh <CR>", opts)
-- keymap("i", "<leader>dn", "<ESC>:s/\>-\</_/ge<CR>:noh<CR>A", opts)

-- Upper case
keymap("i", "<leader><C-u>", "<ESC>viwUEa", opts)

-- Visual mappings --

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
function _G.set_terminal_keymaps()
  local tt_opts = {noremap = true}
  vim.api.nvim_buf_set_keymap(0, "t", "<ESC>", [[<C-\><C-n>]], tt_opts)
  vim.api.nvim_buf_set_keymap(0, "t", "dv", [[<C-\><C-n>]], tt_opts)
  vim.api.nvim_buf_set_keymap(0, "t", "<C-h>", [[<C-\><C-n><C-w>h]], tt_opts)
  vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", [[<C-\><C-n><C-w>j]], tt_opts)
  vim.api.nvim_buf_set_keymap(0, "t", "<C-k>", [[<C-\><C-n><C-w>k]], tt_opts)
  vim.api.nvim_buf_set_keymap(0, "t", "<C-l>", [[<C-\><C-n><C-w>l]], tt_opts)
end

vim.cmd('autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()')

-- Use sudo to write --
-- keymap("c", "w!!", "w !sudo tee % > /dev/null")

-- Folding keymaps
-- Space to toggle folds
keymap("n", "<SPACE>", "zA", opts)
keymap("v", "<SPACE>", "zA", opts)
keymap("n", "<M-SPACE>", "za", opts)
keymap("v", "<M-SPACE>", "za", opts)
