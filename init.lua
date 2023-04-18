require 'my_nvim/basic'
require 'my_nvim/init_lazy_nvim'

local buffer = require 'my_nvim/buffer'
local colorscheme = require 'my_nvim/colorscheme'
local filer = require 'my_nvim/filer'
local fuzzy_finder = require 'my_nvim/fuzzy_finder'
local github_copilot = require 'my_nvim/github_copilot'
local lsp = require 'my_nvim/lsp'
local statusline = require 'my_nvim/statusline'
local sticky_scroll = require 'my_nvim/sticky_scroll'

require('lazy').setup {
  buffer {
    prev = '<C-h>',
    next = '<C-l>',
  },

  filer {
    toggle = '<C-k>',
  },

  fuzzy_finder {
    close = '<ESC>',
    find_files = '<C-p>',
    live_grep = '<C-g>',
  },

  lsp {
    action = {
      definition = 'gd',
      format = 'gf',
      hover = 'K',
      references = 'gr',
    },
    completion = {
      next_item = '<Tab>',
      prev_item = '<S-Tab>',
      abort = '<C-e>',
      confirm = '<CR>',
    },
    diagnostics = {
      open_float = 'ge',
      goto_next = 'g]',
      goto_prev = 'g[',
    },
  },

  statusline,
  colorscheme,

  sticky_scroll,

  { 'f-person/git-blame.nvim', lazy = false },

  github_copilot {
    accept = '<C-j>',
  },
}
