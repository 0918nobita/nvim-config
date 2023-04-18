require 'my_nvim/basic'
require 'my_nvim/init_lazy_nvim'

local buffer = require 'my_nvim/buffer'
local filer = require 'my_nvim/filer'
local lsp = require 'my_nvim/lsp'
local statusline = require 'my_nvim/statusline'

vim.g.copilot_no_tab_map = true

require('lazy').setup {
  buffer.plugins,
  filer.plugins,
  lsp.plugins,
  statusline.plugins,

  -- カラースキーム
  { 'cocopon/iceberg.vim', lazy = false },

  -- fuzzy finder
  {
    'nvim-telescope/telescope.nvim',
    lazy = false,
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
  },

  { 'f-person/git-blame.nvim', lazy = false },

  { 'github/copilot.vim', lazy = false },
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

vim.api.nvim_set_keymap('i', '<C-j>', 'copilot#Accept("<CR>")', { expr = true, noremap = false, silent = true })

require('telescope').setup {
  defaults = {
    mappings = {
      n = {
        ['<ESC>'] = require('telescope.actions').close,
      },
      i = {
        ['<ESC>'] = require('telescope.actions').close,
      },
    },
  },
}

local telescope_builtin = require 'telescope.builtin'

vim.keymap.set('n', '<C-p>', telescope_builtin.find_files, { noremap = true, silent = true })

vim.keymap.set('n', '<C-g>', telescope_builtin.live_grep, { noremap = true, silent = true })
