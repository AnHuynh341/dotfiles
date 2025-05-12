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
      local lspconfig = require("lspconfig")

      require("mason-lspconfig").setup {
        ensure_installed = {
          "lua_ls", -- Lua LSP
          "clangd", -- C/C++ LSP
          "html",
          "cssls",
          "bashls",
          "pyright",
        },
        handlers = {
          -- Default handler for all other servers
          function(server_name)
            lspconfig[server_name].setup {}
          end,

          -- Optional: specific config for Lua
          ["lua_ls"] = function()
            lspconfig.lua_ls.setup {
              settings = {
                Lua = {
                  diagnostics = {
                    globals = { "vim" },
                  },
                },
              },
            }
          end,
        },
      }

      -- Original dartls setup (outside Mason)
      lspconfig.dartls.setup {
        cmd = { "/home/AnHuynh/development/flutter/bin/dart", "language-server", "--protocol=lsp" },
        filetypes = { "dart" },
        root_dir = lspconfig.util.root_pattern("pubspec.yaml"),
      }

        --  Inline virtual text diagnostics
    vim.diagnostic.config({
      virtual_text = {
        prefix = "●",  -- Or use ">>", "→", etc. for fun
        spacing = 4,
      },
      signs = true,
      underline = true,
      update_in_insert = false,
      severity_sort = true,
    })

    end,
  },

  -- LSPConfig: Neovim's LSP integration
  {
    "neovim/nvim-lspconfig",
  },
}

