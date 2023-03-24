local lualine = require('lualine')
local tree = require('nvim-tree')
local treeApi = require('nvim-tree.api')

require('basic')
local lsp = require('lsp')

vim.cmd.packadd 'packer.nvim'

require 'packer'.startup(function(use)
  -- プラグインマネージャ
  -- :PackerSync, :PackerStatus 等のコマンドを使用するときだけ読み込んでほしいので
  -- opt = true で遅延読み込みさせている
  use { 'wbthomason/packer.nvim', opt = true }

  lsp.usePlugins(use)

  -- カラースキーム
  -- vim.opt.colorscheme は start, opt の両方で検索するので、opt = true でよい
  use { 'cocopon/iceberg.vim', opt = true }

  -- statusline をカスタマイズするためのプラグイン
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }

  -- .editorconfig を検出してエディタ設定に反映する
  use 'editorconfig/editorconfig-vim'

  -- ファイルエクスプローラー
  use 'nvim-tree/nvim-tree.lua'
end)

vim.cmd.colorscheme 'iceberg'

lualine.setup {}

lsp.setupServers()

lsp.setupCompletion {
  nextItem = '<Tab>',
  prevItem = '<S-Tab>',
  abort = '<C-e>',
}

lsp.registerHoverAction 'K'

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

tree.setup {
  filters = { custom = { '^.git$' } }
}

vim.api.nvim_set_keymap(
  'n', '<C-h>', ':NvimTreeToggle<CR>',
  { noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
  'n', 'ge', ':lua vim.diagnostic.open_float { border = \'single\' }<CR>',
  { noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
  'n', 'g]', ':lua vim.diagnostic.goto_next()<CR>',
  { noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
  'n', 'g[', ':lua vim.diagnostic.goto_prev()<CR>',
  { noremap = true, silent = true }
)
