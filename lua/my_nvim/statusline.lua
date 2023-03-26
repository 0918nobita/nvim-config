local plugins = {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'kyazdani42/nvim-web-devicons' }
  },
}

local function setup()
  require 'lualine'.setup {}
end

return {
  plugins = plugins,
  setup = setup,
}
