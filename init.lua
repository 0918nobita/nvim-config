require 'my_nvim/basic'
require 'my_nvim/init_lazy_nvim'

local buffer = require 'my_nvim/buffer'
local filer = require 'my_nvim/filer'
local lsp = require 'my_nvim/lsp'
local statusline = require 'my_nvim/statusline'

require('lazy').setup {
  buffer.plugins,
  filer.plugins,
  lsp.plugins,
  statusline.plugins,

  -- カラースキーム
  { 'cocopon/iceberg.vim', lazy = false },
}

vim.cmd.colorscheme 'iceberg'

buffer.setup()

buffer.setKeymaps {
  prev = '<C-h>',
  next = '<C-l>',
}

filer.setup()
statusline.setup()

filer.registerToggleAction '<C-k>'

lsp.setupServers()

lsp.setupCompletion {
  nextItem = '<Tab>',
  prevItem = '<S-Tab>',
  abort = '<C-e>',
  confirm = '<CR>',
}

lsp.setKeymaps {
  definition = 'gd',
  format = 'gf',
  hover = 'K',
  references = 'gr',
}

vim.api.nvim_set_keymap(
  'n',
  'ge',
  ':lua vim.diagnostic.open_float { border = \'single\' }<CR>',
  { noremap = true, silent = true }
)

vim.api.nvim_set_keymap('n', 'g]', ':lua vim.diagnostic.goto_next()<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', 'g[', ':lua vim.diagnostic.goto_prev()<CR>', { noremap = true, silent = true })
