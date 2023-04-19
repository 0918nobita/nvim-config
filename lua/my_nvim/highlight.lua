return {
  {
    'HiPhish/nvim-ts-rainbow2',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require('nvim-treesitter.configs').setup {
        rainbow = {
          enable = true,
          query = 'rainbow-parens',
          strategy = require('ts-rainbow').strategy.global,
        },
      }
    end,
  },

  {
    'lukas-reineke/indent-blankline.nvim',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      vim.api.nvim_set_hl(0, 'IndentBlanklineIndent1', { fg = '#333316' })
      vim.api.nvim_set_hl(0, 'IndentBlanklineIndent2', { fg = '#193323' })
      vim.api.nvim_set_hl(0, 'IndentBlanklineIndent3', { fg = '#33193d' })
      vim.api.nvim_set_hl(0, 'IndentBlanklineIndent4', { fg = '#102f39' })

      require('indent_blankline').setup {
        char_highlight_list = {
          'IndentBlanklineIndent1',
          'IndentBlanklineIndent2',
          'IndentBlanklineIndent3',
          'IndentBlanklineIndent4',
        },
      }
    end,
  },

  {
    'nvim-treesitter/nvim-treesitter-context',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require('treesitter-context').setup {}
    end,
  },
}
