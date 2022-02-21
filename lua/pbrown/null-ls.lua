local status_ok, null_ls = pcall(require, "null-ls")
if not status_ok then
  return
end

null_ls.setup {
  sources = {
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.prettier,
    null_ls.builtins.formatting.rustfmt,
  }
}

null_ls.builtins.formatting.rustfmt.with({
  extra_args = { "--edition=2021" }
})
