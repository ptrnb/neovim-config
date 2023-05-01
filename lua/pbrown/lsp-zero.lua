local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
  -- lsp.default_keymaps({buffer = bufnr}) -- disable default keybindings from lsp-zero
  local function lsp_keymaps(bufnum)
    local opts = { noremap = true, silent = true }
    vim.api.nvim_buf_set_keymap(bufnum, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnum, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnum, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnum, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnum, "n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnum, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnum, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnum, "n", "<leader>ga", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
    vim.api.nvim_buf_set_keymap(
      bufnum,
      "n",
      "<leader>gf",
      '<cmd>lua vim.diagnostic.open_float({ scope = "buffer" })<CR>',
      opts
    )
    vim.api.nvim_buf_set_keymap(bufnum, "n", "gl", '<cmd>lua vim.diagnostic.open_float({ scope = "line" })<CR>', opts)
    vim.api.nvim_buf_set_keymap(
      bufnum,
      "n",
      "<leader>gj",
      '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>',
      opts
    )
    vim.api.nvim_buf_set_keymap(
      bufnum,
      "n",
      "<leader>gk",
      '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>',
      opts
    )
    vim.api.nvim_buf_set_keymap(bufnum, "n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
    vim.cmd([[ command! Format execute 'lua vim.lsp.buf.format { async = true }' ]])
    vim.api.nvim_buf_set_keymap(bufnum, "n", "<leader>ff", "<cmd>Format<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnum, "n", "<leader>rid", "<cmd>RustDisableInlayHints<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnum, "n", "<leader>rie", "<cmd>RustEnableInlayHints<CR>", opts)
  end
  lsp_keymaps(bufnr)
end)

lsp.set_sign_icons({
  error = '',
  warn = '',
  hint = '',
  info = ''
})

require('lspconfig').lua_ls.setup {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" }
      }
    }
  }
}

lsp.skip_server_setup({ 'rust_analyzer' })

lsp.setup()
