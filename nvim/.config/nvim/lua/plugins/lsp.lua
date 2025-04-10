return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("lspconfig").dartls.setup {
        cmd = { "/home/AnHuynh/development/flutter/bin/dart", "language-server", "--protocol=lsp" },
        filetypes = { "dart" },
        root_dir = require("lspconfig.util").root_pattern("pubspec.yaml"),
      }
    end,
  },
}

