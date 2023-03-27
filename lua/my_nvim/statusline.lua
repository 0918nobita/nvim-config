local plugins = {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
  },
}

local function setup()
  require('lualine').setup {}
end

return {
  plugins = plugins,
  setup = setup,
}
