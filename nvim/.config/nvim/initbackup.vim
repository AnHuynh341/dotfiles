call plug#begin('~/.local/share/nvim/plugged')
"Plug 'morhetz/gruvbox'
"Plug 'dracula/vim', { 'as': 'dracula' }
"Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'scottmckendry/cyberdream.nvim'
Plug 'preservim/nerdtree'
Plug 'neovim/nvim-lspconfig'

Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'

call plug#end()

lua << EOF
require("cyberdream").setup {
    transparent = true,
    theme = {
        highlights = {
            Normal = { bg = "#000000" },
            NormalFloat = { bg = "#000000" },
        }
    }
}

-- LSP setup
local lspconfig = require('lspconfig')
lspconfig.dartls.setup {
    on_attach = function(client, bufnr)
        vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
        local opts = { noremap=true, silent=true }
        --vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
        --vim.api.nvim_buf_set_keymap(bufnr, 'n', '<A-k>', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
        --vim.api.nvim_buf_set_keymap(bufnr, 'n', '<A-r>', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
        --vim.api.nvim_buf_set_keymap(bufnr, 'n', '<A-c>', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    end,
    settings = {
        dart = {
            completeFunctionCalls = true,
            showTodos = true,
        }
    }
}

-- Completion setup with nvim-cmp
local cmp = require'cmp'
cmp.setup {
    sources = {
        { name = 'nvim_lsp' },  -- LSP as the primary source
        { name = 'buffer' },    -- Optional: words from current buffer
    },
    mapping = {
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            else
                fallback()  -- Fallback to regular Tab if no menu
            end
        end, { "i", "s" }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            else
                fallback()
            end
        end, { "i", "s" }),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),  -- Enter confirms selection
        ['<C-Space>'] = cmp.mapping.complete(),            -- Ctrl+Space forces completion
    },
    completion = {
        autocomplete = { 'InsertEnter', 'TextChanged' },  -- Trigger on typing
    },
}

-- Link LSP capabilities to cmp
local capabilities = require('cmp_nvim_lsp').default_capabilities()
lspconfig.dartls.setup { capabilities = capabilities }
EOF

colorscheme cyberdream
set background=dark
set termguicolors
set number

nnoremap <Space>e :NERDTreeToggle<CR>

function! ToggleTerminal()
    for buf in tabpagebuflist()
        if getbufvar(buf, '&buftype') == 'terminal'
            execute bufwinnr(buf) . 'wincmd c'
            return
        endif
    endfor
    belowright 15split term://zsh
endfunction

nnoremap <Space>t :call ToggleTerminal()<CR>
