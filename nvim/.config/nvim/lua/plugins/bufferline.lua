return {
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("bufferline").setup({
        options = {
          mode = "buffers",
          diagnostics = "nvim_lsp",
          show_close_icon = false,
          show_buffer_close_icons = false,
          separator_style = "thin",  -- or "thick", "thin", "padded_slant", etc.
        },
        highlights = {
          fill = {
            bg = "NONE",
          },
          separator = {
            fg = "NONE",
            bg = "NONE",
          },
          separator_selected = {
            fg = "NONE",
            bg = "NONE",
          },
	  buffer_selected = {
 	  bg = "#1e1e2e", -- subtle dark glow
  	  fg = "#ffffff",
  	  bold = true,
	},



        },
      })
    end,
  },
}

