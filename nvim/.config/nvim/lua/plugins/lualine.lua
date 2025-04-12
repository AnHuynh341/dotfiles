return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
 require("lualine").setup({
  options = {
    theme = {
      normal = {
        a = { fg = "#000000", bg = "#00ffff", gui = "bold" }, -- cyan
        b = { fg = "#ffffff", bg = "#005f87" },               -- deep blue
        c = { fg = "#00ffff", bg = "NONE" },                 
      },
      insert = {
        a = { fg = "#220536", bg = "#ffff00", gui = "bold" }, -- green
      },
      visual = {
        a = { fg = "#000000", bg = "#ff5fff", gui = "bold" }, -- pink
      },
      replace = {
        a = { fg = "#000000", bg = "#ff5f5f", gui = "bold" }, -- red
      },
      command = {
        a = { fg = "#000000", bg = "#ffff5f", gui = "bold" }, -- yellow
      },
      inactive = {
        a = { fg = "#666666", bg = "#111111", gui = "bold" },
        b = { fg = "#888888", bg = "#111111" },
        c = { fg = "#888888", bg = nil },
      },
    },
    section_separators = { left = "", right = "" },
    component_separators = { left = "│", right = "│" },
    globalstatus = true,
    disabled_filetypes = {},
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch", "diff" },
    lualine_c = { "filename" },
    lualine_x = { "encoding", "fileformat", "filetype" },
    lualine_y = { "progress" },
    lualine_z = { "location" },
  },
})



end,
  },
}

