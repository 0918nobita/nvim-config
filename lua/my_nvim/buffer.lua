---@class BufferKeymaps
---@field prev string
---@field next string

local function setup()
  require('bufferline').setup {
    options = {
      diagnostics = 'nvim_lsp',
      diagnostics_indicator = function(_, _, diagnostics_dict)
        local s = ''

        for e, n in pairs(diagnostics_dict) do
          local icon = e == 'error' and '' or (e == 'warning' and '' or '')

          s = s .. icon .. ' ' .. n
        end

        return s
      end,
    },
  }
end

---@param keys BufferKeymaps
local function setKeymaps(keys)
  vim.api.nvim_set_keymap('n', keys.prev, ':bprev<CR>', { noremap = true, silent = true })

  vim.api.nvim_set_keymap('n', keys.next, ':bnext<CR>', { noremap = true, silent = true })
end

---@param keys BufferKeymaps
return function(keys)
  return {
    {
      'akinsho/bufferline.nvim',
      dependencies = {
        'nvim-tree/nvim-web-devicons',
      },
      config = function()
        setup()
        setKeymaps(keys)
      end,
    },
  }
end
