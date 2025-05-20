return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  config = function()
    local highlights = {
      "#878787", "#8d8d8f", "#7d7d7d", "#737272", "#727275",
         }

    for i, color in ipairs(highlights) do
      vim.api.nvim_set_hl(0, "IblIndent" .. i, { fg = color, nocombine = true })
    end

    require("ibl").setup {
      indent = {
        char = "│",
        highlight = vim.tbl_map(function(i) return "IblIndent" .. i end, vim.fn.range(1, 5)),
      },
      scope = {
        enabled = false,
        show_start = false,
        show_end = false,
      },
    }
  end,
}

