-- Set leader key early
vim.g.mapleader = " "

-- Enable line numbers
vim.opt.number = true           -- Show absolute line numbers
vim.opt.relativenumber = false   -- Show relative line numbers (optional, useful for navigation)


-- Bootstrap Lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load plugins from 'lua/plugins'
require("lazy").setup("plugins")
require("configs.keymaps")
