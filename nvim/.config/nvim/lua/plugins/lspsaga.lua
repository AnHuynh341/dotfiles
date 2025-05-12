return {
  "nvimdev/lspsaga.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter", -- optional but recommended
    "neovim/nvim-lspconfig",
  },
  config = function()
    require("lspsaga").setup({
      lightbulb = {
        enable = false,
        enable_in_insert = false,
      },
      symbol_in_winbar = {
        enable = false,
      },
      ui = {
        border = "rounded",
        code_action = "💡",
      },
    })
  end,
}

