local rust_tools = require('rust-tools')

local rust_opts = {
  tools = {
    runnables = {
      use_telescope = true,
    },
    inlay_hints = {
      only_current_line = true,
      other_hints_prefix = "  ==>"
    }
  },
  server = {
    settings = {
      ["rust-analyzer"] = {
        checkOnSave = {
          command = "clippy",
        }
      }
    }
  }
}

rust_tools.setup(rust_opts)
