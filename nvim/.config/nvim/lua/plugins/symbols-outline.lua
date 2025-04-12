-- lua/plugins/symbol-outline.lua
-- Set up the plugin
return {
  "simrat39/symbols-outline.nvim",
  config = function()
    -- Plugin-specific configuration
    require("symbols-outline").setup({
      highlight_hovered_item = true,
      show_guides = true, -- Show indentation guides
      position = "right", -- Change this to "left", "bottom", etc.
      relative_width = true, -- Makes the outline panel width dynamic
      auto_preview = true, -- Preview symbol when hovering over it
    })

    -- Key mapping to toggle the symbols outline
    vim.api.nvim_set_keymap('n',  "<leader>s", ':SymbolsOutline<CR>', { noremap = true, silent = true })
  end
}

