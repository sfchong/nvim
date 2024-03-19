if vim.g.vscode then
  vim.g.mapleader = ' '
  require('options')
  require('keymap')
else
  local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable", -- latest stable release
      lazypath,
    })
  end
  vim.opt.rtp:prepend(lazypath)

  -- use space as leader key
  vim.g.mapleader = ' '

  require("lazy").setup('plugins', {
    change_detection = {
      enabled = true,
      notify = false,
    },
  })

  require('options')
  require('keymap')
  require('autocmd')
end
