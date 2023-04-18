vim.opt.title = true

vim.opt.termguicolors = true

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
local arrow_keys = { '<up>', '<left>', '<right>', '<down>' }
for _, key_name in ipairs(arrow_keys) do
  vim.api.nvim_set_keymap('n', key_name, '<nop>', { silent = true })
end

-- jj で挿入モードから通常モードに戻る
vim.api.nvim_set_keymap('i', 'jj', '<ESC>', {
  noremap = true, -- 素の Vim が持っている機能に割り当てる
  silent = true, -- 実行するコマンドをコマンドラインに表示しない
})

-- ヤンクした内容を自動でクリップボードにコピーする
vim.opt.clipboard = 'unnamed'

-- バッファ切り替え時に編集中のファイルを保存しなくてもいいようにする
vim.opt.hidden = true
