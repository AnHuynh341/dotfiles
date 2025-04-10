return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup {
        vim.keymap.set("n", "<leader>h", "<cmd>ToggleTerm direction=horizontal<CR>", { noremap = true, silent = true })
      }
    end,
  },
}

