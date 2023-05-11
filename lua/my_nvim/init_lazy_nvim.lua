local lazy_path = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'

if not vim.loop.fs_stat(lazy_path) then
  print 'Installing lazy.nvim'

  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'git@github.com:folke/lazy.nvim.git',
    '--branch=stable',
    lazy_path,
  }

  print 'Successfully installed lazy.nvim'
end

vim.opt.rtp:prepend(lazy_path)
