require 'my_nvim/basic'
require 'my_nvim/init_lazy_nvim'

local filer = require 'my_nvim/filer'
local lsp = require 'my_nvim/lsp'
local statusline = require 'my_nvim/statusline'

require('lazy').setup {
  filer.plugins,
  lsp.plugins,
  statusline.plugins,

  -- カラースキーム
  { 'cocopon/iceberg.vim', lazy = false },

  -- .editorconfig を検出してエディタ設定に反映する
  { 'editorconfig/editorconfig-vim', lazy = false },
}

vim.cmd.colorscheme 'iceberg'

filer.setup()
statusline.setup()

filer.registerToggleAction '<C-h>'

lsp.setupServers()

lsp.setupCompletion {
  nextItem = '<Tab>',
  prevItem = '<S-Tab>',
  abort = '<C-e>',
}

lsp.registerHoverAction 'K'

vim.api.nvim_set_keymap(
  'n',
  'ge',
  ':lua vim.diagnostic.open_float { border = \'single\' }<CR>',
  { noremap = true, silent = true }
)

vim.api.nvim_set_keymap('n', 'g]', ':lua vim.diagnostic.goto_next()<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', 'g[', ':lua vim.diagnostic.goto_prev()<CR>', { noremap = true, silent = true })
