---@class FilerKeymaps
---@field toggle string

---@param keys FilerKeymaps
return function(keys)
  return {
    {
      'lambdalisue/fern.vim',
      lazy = false,
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
      lazy = false,
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
      'yuki-yano/fern-preview.vim',
      lazy = false,
      dependencies = {
        'lambdalisue/fern.vim',
      },
    },

    {
      'lambdalisue/fern-git-status.vim',
      lazy = false,
      dependencies = {
        'lambdalisue/fern.vim',
      },
    },

    { 'lambdalisue/nerdfont.vim', lazy = false },

    {
      'lambdalisue/fern-renderer-nerdfont.vim',
      lazy = false,
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
      lazy = false,
      dependencies = {
        'lambdalisue/fern.vim',
      },
    },
  }
end
