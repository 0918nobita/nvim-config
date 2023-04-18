---@class FuzzyFinderKeymaps
---@field close string
---@field find_files string
---@field live_grep string

---@param keys FuzzyFinderKeymaps
return function(keys)
  return {
    'nvim-telescope/telescope.nvim',
    lazy = false,
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    config = function()
      local telescope_actions = require 'telescope.actions'

      require('telescope').setup {
        defaults = {
          mappings = {
            n = {
              [keys.close] = telescope_actions.close,
            },
            i = {
              [keys.close] = telescope_actions.close,
            },
          },
        },
      }

      local telescope_builtin = require 'telescope.builtin'

      vim.keymap.set('n', keys.find_files, telescope_builtin.find_files, { noremap = true, silent = true })

      vim.keymap.set('n', keys.live_grep, telescope_builtin.live_grep, { noremap = true, silent = true })
    end,
  }
end
