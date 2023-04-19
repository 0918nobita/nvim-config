---@class GitHubCopilotKeymaps
---@field accept string

---@param keys GitHubCopilotKeymaps
return function(keys)
  return {
    'github/copilot.vim',
    event = 'InsertEnter',
    init = function()
      vim.g.copilot_no_tab_map = true
    end,
    config = function()
      vim.api.nvim_set_keymap(
        'i',
        keys.accept,
        'copilot#Accept("<CR>")',
        { expr = true, noremap = false, silent = true }
      )
    end,
  }
end
