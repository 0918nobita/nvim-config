local lsp = require('lsp')

-- 改行を可視化する
vim.opt.list = true
vim.opt.listchars = {
  eol = '↲',
  nbsp = '+',
  tab = '»-',
  trail = '*',
}

-- 現在の行のみ絶対的な行番号を表示し、他の行には相対的な行番号を表示する
vim.opt.number = true
vim.opt.relativenumber = true

-- 現在の行を行番号の下線で強調する
vim.opt.cursorline = true
vim.opt.cursorlineopt = 'number'

-- 画面右端で行を折り返さない
vim.opt.wrap = false

-- 通常モードにおいて
-- カーソルが行頭にあって h を押したときに前の行の末尾に移動する
-- カーソルが行末にあって l を押したときに次の行の先頭に移動する
vim.opt.whichwrap = 'h,l'

-- バックスペースを押したときに
-- (indent) インデントを消去できる
-- (eol) 行末を消去できる
-- (start) 挿入の開始点を超えて消去できる
vim.opt.backspace = 'indent,eol,start'

-- 通常モードでの方向キーの使用を禁止する
local arrowKeys = { '<up>', '<left>', '<right>', '<down>' }
for _, keyName in ipairs(arrowKeys) do
  vim.api.nvim_set_keymap('n', keyName, '<nop>', { silent = true })
end

-- jj で挿入モードから通常モードに戻る
vim.api.nvim_set_keymap(
  'i', 'jj', '<ESC>',
  {
    noremap = true, -- 素の Vim が持っている機能に割り当てる
    silent = true -- 実行するコマンドをコマンドラインに表示しない
  }
)

-- ヤンクした内容を自動でクリップボードにコピーする
vim.opt.clipboard = 'unnamed'

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

require 'lualine'.setup {}

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
