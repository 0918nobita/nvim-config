local lualine = require('lualine')

require('basic')
local lsp = require('lsp')

vim.cmd.packadd 'packer.nvim'

require 'packer'.startup(function(use)
  -- プラグインマネージャ
  -- :PackerSync, :PackerStatus 等のコマンドを使用するときだけ読み込んでほしいので
  -- opt = true で遅延読み込みさせている
  use { 'wbthomason/packer.nvim', opt = true }

  lsp.usePlugins(use)

  -- カラースキーム
  -- vim.opt.colorscheme は start, opt の両方で検索するので、opt = true でよい
  use { 'cocopon/iceberg.vim', opt = true }

  -- statusline をカスタマイズするためのプラグイン
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }

  -- .editorconfig を検出してエディタ設定に反映する
  use 'editorconfig/editorconfig-vim'
end)

vim.cmd.colorscheme 'iceberg'

lualine.setup {}

lsp.setupServers()
lsp.setupCompletion()

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client.server_capabilities.hoverProvider then
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = args.buf })
    end
  end,
})
