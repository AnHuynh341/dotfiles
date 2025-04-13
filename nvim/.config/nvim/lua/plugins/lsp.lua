return {
  -- Mason package manager for LSP, linters, formatters
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = function()
      require("mason").setup() -- Initialize Mason
    end,
  },

  -- Mason-LSPConfig to automatically hook Mason with lspconfig
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "mason.nvim", "neovim/nvim-lspconfig" },
    config = function()
      -- Automatically install & configure LSPs using mason-lspconfig
      require("mason-lspconfig").setup {
        ensure_installed = {
          "lua_ls", -- Lua LSP
          "clangd", -- C/C++ LSP
          "html", -- HTML LSP
          "cssls",
          "bashls",
          "pyright",
        },
        automatic_installation = true, -- Automatically install missing servers
      }

      local lspconfig = require("lspconfig")

      -- Automatically setup Mason-managed LSPs
      require("mason-lspconfig").setup_handlers {
        -- Default handler for Mason-managed servers
        function(server_name)
          lspconfig[server_name].setup {}
        end,
      }

      -- original, working dartls setup (outside mason-lspconfig)
      lspconfig.dartls.setup {
        cmd = { "/home/AnHuynh/development/flutter/bin/dart", "language-server", "--protocol=lsp" },
        filetypes = { "dart" },
        root_dir = lspconfig.util.root_pattern("pubspec.yaml"),
      }
    end,
  },

  -- LSPConfig: Neovim's LSP integration
  {
    "neovim/nvim-lspconfig",
  },
}
