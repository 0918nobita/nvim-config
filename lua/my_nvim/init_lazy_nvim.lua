local lazyPath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'

if not vim.loop.fs_stat(lazyPath) then
  print 'Installing lazy.nvim'

  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'git@github.com:folke/lazy.nvim.git',
    '--branch=stable',
    lazyPath,
  }

  print 'Successfully installed lazy.nvim'
end

vim.opt.rtp:prepend(lazyPath)
