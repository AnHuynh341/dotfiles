return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  config = function()
    local highlights = {
      "#b0b0b0", "#a0a0b8", "#9090c0", "#8080c8", "#7070d0",
      "#6060d8", "#5050e0", "#4040e8", "#3030f0", "#2020f8"
    }

    for i, color in ipairs(highlights) do
      vim.api.nvim_set_hl(0, "IblIndent" .. i, { fg = color, nocombine = true })
    end

    require("ibl").setup {
      indent = {
        char = "│",
        highlight = vim.tbl_map(function(i) return "IblIndent" .. i end, vim.fn.range(1, 10)),
      },
      scope = {
        enabled = false,
        show_start = false,
        show_end = false,
      },
    }
  end,
}

