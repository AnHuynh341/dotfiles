-- lua/plugins/nvim-autopairs.lua

return {
  'windwp/nvim-autopairs',  -- Plugin name

  config = function()
    -- Set up the plugin
    require('nvim-autopairs').setup({
      -- Enable treesitter-based syntax awareness
      check_ts = true,
      
      -- Optional: Customize the language support (e.g., for Lua)
      ts_config = {
        lua = {'string'},
      },

      -- Configure fast wrapping (e.g., wrap text with {} [] () "" '' when pressing <C-e>)
      fast_wrap = {
        map = '<C-e>', -- Keybinding to trigger fast wrap
        chars = {'{', '[', '(', '"', "'"}, -- Set the wrap characters
        pattern = string.gsub([[ [%'%"%>%]%)%}]], "%s+", ""), -- Match against the closing characters
        offset = 0, -- Positioning of the cursor after wrapping
      },
    })
  end
}

