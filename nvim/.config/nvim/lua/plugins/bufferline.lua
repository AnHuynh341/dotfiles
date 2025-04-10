return {
  -- Bufferline plugin
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("bufferline").setup {
        options = {
          mode = "buffers",
          diagnostics = "nvim_lsp",
          show_close_icon = false,
          separator_style = "slant", -- or "thin" / "padded_slant" / "thick"
        },
      }
    end,
  },
}

