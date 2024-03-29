require("mason").setup {
  ui = {
    icons = {
      package_installed = "✓"
    }
  }
}

require("mason-lspconfig").setup {
  ensure_installed = { "lua_ls", "rust_analyzer"}
}
