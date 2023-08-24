-- Load Packer
vim.cmd [[packadd packer.nvim]]
local packer = require('packer')

-- Start auto commands for auto-compiling plugins
vim.cmd [[
  augroup Packer
    autocmd!
    autocmd BufWritePost init.lua PackerCompile
  augroup end
]]

-- Configure and install plugins
packer.startup(function()
  use 'wbthomason/packer.nvim'
  use 'kyazdani42/nvim-tree.lua'
  use 'neovim/nvim-lspconfig'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim'
  use 'nvim-treesitter/nvim-treesitter'
  use 'ryanoasis/vim-devicons'
  use { 'hrsh7th/nvim-compe' }
  use { 'hrsh7th/vim-vsnip' }
  use { 'hoob3rt/lualine.nvim' }
  use { 'lewis6991/gitsigns.nvim' }
  use { 'TimUntersberger/neogit' }
  use 'mattn/emmet-vim'
  use 'akinsho/nvim-toggleterm.lua'
  use 'tpope/vim-surround'
  use 'tpope/vim-commentary'
  use 'editorconfig/editorconfig-vim'
  use 'windwp/nvim-autopairs'
  use 'dense-analysis/ale'
  use 'jose-elias-alvarez/null-ls.nvim'
  use 'glepnir/dashboard-nvim'
  use 'glepnir/lspsaga.nvim'
  use '907th/vim-auto-save'

end)

-- General settings
vim.opt.backspace = { 'indent', 'eol', 'start' }
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.opt.number = true
vim.opt.ruler = true
vim.opt.showcmd = true
vim.opt.joinspaces = false
vim.opt.mouse = 'a'
vim.opt.laststatus = 2

-- Enable filetype detection, plugins, and indentation
vim.cmd('filetype plugin indent on')

-- Enable syntax highlighting
vim.cmd('syntax on')

-- Key mappings
vim.api.nvim_set_keymap('v', '<C-c>', '"+y', { noremap = true })
vim.api.nvim_set_keymap('v', '<C-x>', '"+x', { noremap = true })
vim.api.nvim_set_keymap('n', 'gA', ':%y+<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-e>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

-- NERDTree configuration
vim.g.NERDTreeMouseMode = 2
vim.g.NERDTreeDirArrows = 0

vim.cmd([[
  autocmd FileType nerdtree setlocal equalalways
  autocmd FileType nerdtree nnoremap <buffer> <CR> :call OpenInTerminal(vim.fn.expand('%'))<CR>
]])

vim.fn['OpenInTerminal'] = function(file)
  local cmd = 'term' .. ' ' .. file
  vim.cmd(cmd)
end

-- Other key mappings
vim.api.nvim_set_keymap('i', '{', '{}<Left>', { noremap = true })
vim.api.nvim_set_keymap('i', '{<CR>', '{<CR>}<Esc>O', { noremap = true })
vim.api.nvim_set_keymap('i', '{{', '{{', { noremap = true })
vim.api.nvim_set_keymap('i', '{}', '{}', { noremap = true })
vim.api.nvim_set_keymap('i', '"', '""<Left>', { noremap = true })

-- Compe
vim.api.nvim_set_keymap('i', '<C-Space>', 'compe#complete()', { noremap = true, silent = true, expr = true })
vim.api.nvim_set_keymap('i', '<CR>', "compe#confirm('<CR>')", { noremap = true, silent = true, expr = true })

-- Telescope
vim.api.nvim_set_keymap('n', '<Leader>ff', [[<Cmd>Telescope find_files<CR>]], { noremap = true, silent = true })

-- Custom mappings for C++ and Python
vim.cmd([[
  autocmd FileType cpp nnoremap <F8> :w <bar> term g++ -std=c++20 -O2 -Wall "%" -o "%:r" && ./"%:r"; rm ./"%:r"<CR>
  autocmd FileType python nnoremap <F8> :w <bar> ter python3 "%" <CR>
  autocmd FileType cpp nnoremap <C-C> :s/^\(\s*\)/\1\/\/<CR> :s/^\(\s*\)\/\/\/\//\1<CR> $
]])

-- Load nvim-lspconfig
local lspconfig = require('lspconfig')
local lsp_saga = require('lspsaga')



-- JavaScript and TypeScript LSP (tsserver)
lspconfig.tsserver.setup {}

-- Python LSP (Pyright)
lspconfig.pyright.setup {}

-- C++ LSP (clangd)
lspconfig.clangd.setup {}

-- Install and Configure File Tree Explorer
require'nvim-tree'.setup {}

-- Configure Compe (Auto-completion)
local compe = require('compe')
compe.setup {
  enabled = true,
  autocomplete = true,
  source = {
    path = true,
    buffer = true,
    nvim_lsp = true,
    nvim_lua = true,
    vsnip = true,
  },
}

-- Configure Lualine (Status Line)
require('lualine').setup {
  options = {
    theme = 'iceberg_dark',
    icons_enabled = true,
  },
}

-- Key mappings for LSP
vim.api.nvim_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', { noremap = true, silent = true })

-- Use Ctrl + H/J/K/L for split navigation
vim.api.nvim_set_keymap('n', '<C-J>', '<C-W><C-J>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-K>', '<C-W><C-K>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-L>', '<C-W><C-L>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-H>', '<C-W><C-H>', { noremap = true })

-- Use Ctrl + S for horizontal split and Ctrl + V for vertical split
vim.api.nvim_set_keymap('n', '<C-S>', ':split<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-V>', ':vsplit<CR>', { noremap = true })

-- Use Ctrl + Q to close current split
vim.api.nvim_set_keymap('n', '<C-Q>', ':q<CR>', { noremap = true })

-- Enable autosave with a 1-second interval
vim.g.auto_save = 1

-- Load template for new Lua files
vim.cmd([[autocmd BufNewFile *.cpp 0r ~/.config/nvim/templates/temp.cpp]])


