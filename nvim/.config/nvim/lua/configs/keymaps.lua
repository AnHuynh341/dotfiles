-- lua/keymaps.lua
--vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to Definition" })
--vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Go to References" })
--vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover Info" })
--vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename Symbol" })
--vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
--vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format { async = true } end, { desc = "Format" })
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show Diagnostics" })
--vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous Diagnostic" })
--vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next Diagnostic" })
vim.keymap.set('n', 'q', '<Nop>', { noremap = true, silent = true })


-- Modern clipboard shortcuts for a comfy experience

-- Copy selection (Visual mode)
vim.keymap.set("v", "<C-c>", '"+y', { desc = "Copy to system clipboard" })

-- Cut selection (Visual mode)
vim.keymap.set("v", "<C-x>", '"+d', { desc = "Cut to system clipboard" })

-- Paste clipboard content (Normal and Visual mode)
vim.keymap.set({ "n", "v" }, "<C-v>", '"+p', { desc = "Paste from system clipboard" })

-- Optional: Copy current line in Normal mode with Ctrl+C
vim.keymap.set("n", "<C-c>", '"+yy', { desc = "Copy line to system clipboard" })

vim.keymap.set("n", "<C-s>", ":w<CR>", { desc = "Save file" })

vim.keymap.set("n", "<C-z>", "u", { desc = "Undo" })



    -- Tiny peek instead of full jump
vim.keymap.set("n", "<leader>gd", "<cmd>Lspsaga peek_definition<CR>", { desc = "Peek definition" })

    -- Code action
vim.keymap.set("n", "C",  vim.lsp.buf.code_action, { desc = "Code Action" })

    -- Hover doc (alternative to K if you want prettier UI)
vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", { desc = "Hover Docs" })

    -- Diagnostic jump
vim.keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { desc = "Prev Diagnostic" })
vim.keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", { desc = "Next Diagnostic" })


-- Normal mode navigation between splits
-- Set these in your keymaps file or init.lua
local opts = { noremap = true, silent = true }

-- Normal mode navigation between splits
-- Normal mode: Move between splits as usual
vim.keymap.set('n', '<C-h>', '<C-w>h', opts)  -- Move left
vim.keymap.set('n', '<C-j>', '<C-w>j', opts)  -- Move down
vim.keymap.set('n', '<C-k>', '<C-w>k', opts)  -- Move up
vim.keymap.set('n', '<C-l>', '<C-w>l', opts)  -- Move right

-- Terminal mode: Exit insert mode and move between splits
vim.keymap.set('t', '<C-h>', [[<C-\><C-n><C-w>h]], opts)  -- Move left in terminal mode
vim.keymap.set('t', '<C-j>', [[<C-\><C-n><C-w>j]], opts)  -- Move down in terminal mode
vim.keymap.set('t', '<C-k>', [[<C-\><C-n><C-w>k]], opts)  -- Move up in terminal mode
vim.keymap.set('t', '<C-l>', [[<C-\><C-n><C-w>l]], opts)  -- Move right in terminal mode

-- Next buffer (like tab)
vim.keymap.set('n', '<leader><Tab>', ':bnext<CR>', { desc = 'Next buffer' })
