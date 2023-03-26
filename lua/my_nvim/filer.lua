local plugins = {
  {
    'lambdalisue/fern.vim',
    lazy = false,
    dependencies = {
      'lambdalisue/glyph-palette.vim',
    },
  },

  { 'lambdalisue/glyph-palette.vim', lazy = false },

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
  },

  {
    'lambdalisue/fern-hijack.vim',
    lazy = false,
    dependencies = {
      'lambdalisue/fern.vim',
    },
  },
}

local function setup()
  vim.g['fern#default_hidden'] = true
  vim.g['fern#renderer'] = 'nerdfont'

  vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'fern' },
    callback = function()
      vim.fn['glyph_palette#apply']()
    end,
  })
end

local function registerToggleAction(key)
  vim.api.nvim_set_keymap(
    'n', key, ':Fern . -drawer -toggle -width=40<CR>',
    { noremap = true, silent = true }
  )
end

return {
  plugins = plugins,
  setup = setup,
  registerToggleAction = registerToggleAction,
}
