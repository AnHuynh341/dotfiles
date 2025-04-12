return {
  {
    "scottmckendry/cyberdream.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("cyberdream").setup({
        transparent = false,         -- Set to true if you want a see-through background
        italic_comments = true,
        hide_fillchars = true,
        borderless_telescope = false,
      })

      vim.cmd.colorscheme("cyberdream")

      -- Pitch black background overrides
      vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
      vim.api.nvim_set_hl(0, "NormalNC", { bg = "NONE" })
      vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "NONE" })

      vim.api.nvim_set_hl(0, "BufferLineFill", { bg = "NONE" })
      vim.api.nvim_set_hl(0, "BufferLineSeparator", { fg = "NONE", bg = "NONE" })
      vim.api.nvim_set_hl(0, "BufferLineSeparatorSelected", { fg = "NONE", bg = "NONE" })
      vim.api.nvim_set_hl(0, "BufferLineSeparatorVisible", { fg = "NONE", bg = "NONE" })
      vim.api.nvim_set_hl(0, "BufferLineTabSelected", { fg = "#ffffff", bg = "#222244", bold = true })
      vim.api.nvim_set_hl(0, "BufferLineTab", { fg = "#aaaaaa", bg = "NONE" })


      --    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#0d0d0d" })
   --   vim.api.nvim_set_hl(0, "VertSplit", { bg = "#0c0c9c" })
  --   vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "#0d0d0d" })
  --   vim.api.nvim_set_hl(0, "TelescopeBorder", { bg = "#000000" })
  --    vim.api.nvim_set_hl(0, "FloatBorder", { bg = "#0a0a0a" })
    end,
  },
}

