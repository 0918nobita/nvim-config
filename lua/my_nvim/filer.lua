---@class FilerKeymaps
---@field toggle string

---@param keys FilerKeymaps
return function(keys)
  return {
    {
      'lambdalisue/fern.vim',
      dependencies = {
        'lambdalisue/glyph-palette.vim',
      },
      config = function()
        vim.g['fern#default_hidden'] = true
        vim.keymap.set('n', keys.toggle, function()
          local parent_dir = vim.fn.expand '%:h'
          vim.cmd(':Fern ' .. parent_dir .. ' -drawer -toggle -width=40<CR>')
        end)
      end,
    },

    {
      'lambdalisue/glyph-palette.vim',
      config = function()
        vim.api.nvim_create_autocmd('FileType', {
          pattern = { 'fern' },
          callback = function()
            vim.fn['glyph_palette#apply']()
          end,
        })
      end,
    },

    {
      'lambdalisue/fern-git-status.vim',
      dependencies = {
        'lambdalisue/fern.vim',
      },
    },

    'lambdalisue/nerdfont.vim',

    {
      'lambdalisue/fern-renderer-nerdfont.vim',
      dependencies = {
        'lambdalisue/fern.vim',
        'lambdalisue/nerdfont.vim',
      },
      config = function()
        vim.g['fern#renderer'] = 'nerdfont'
      end,
    },

    {
      'lambdalisue/fern-hijack.vim',
      dependencies = {
        'lambdalisue/fern.vim',
      },
    },
  }
end
