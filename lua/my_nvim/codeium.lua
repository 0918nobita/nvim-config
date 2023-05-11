---@class CodeiumKeymaps
---@field clearCurrentSuggestion string
---@field insertSuggestion string
---@field nextSuggestion string
---@field previousSuggestion string

---@param keys CodeiumKeymaps
return function(keys)
  return {
    'Exafunction/codeium.vim',
    init = function()
      vim.g.codeium_disable_bindings = 1
    end,
    config = function()
      vim.keymap.set('i', keys.clearCurrentSuggestion, function()
        vim.fn['codeium#Clear']()
      end, { expr = true })

      vim.keymap.set('i', keys.insertSuggestion, function()
        vim.fn['codeium#Accept']()
      end, { expr = true })

      vim.keymap.set('i', keys.nextSuggestion, function()
        vim.fn['codeium#CycleCompletions'](1)
      end, { expr = true })

      vim.keymap.set('i', keys.previousSuggestion, function()
        vim.fn['codeium#CycleCompletions'](-1)
      end, { expr = true })
    end,
  }
end
