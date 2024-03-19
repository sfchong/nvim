if vim.g.vscode then
  -- use space as leader key
  vim.g.mapleader = ' '

  local vscode = require('vscode-neovim')
  local function map_vscode(mode, keymap, action, opts)
    vim.keymap.set(mode, keymap, function()
      vscode.call(action, opts)
    end)
  end

  -- clipboard related
  vim.keymap.set('x', 'p', '\"_dP')
  vim.keymap.set('n', 'x', '\"_x')
  vim.keymap.set('v', 'x', '\"_x')
  vim.keymap.set('n', 'c', '\"_c')

  -- keep visual mode during indent
  vim.keymap.set('v', '<', '<gv')
  vim.keymap.set('v', '>', '>gv')

  -- editor action
  map_vscode('n', '<leader>s', 'workbench.action.files.save')
  map_vscode('n', '<leader>a', 'editor.action.selectAll')
  map_vscode({ 'n', 'v' }, '<leader>/', 'editor.action.commentLine')
  map_vscode('n', 'U', 'redo')

  -- TODO: make this work
  vim.keymap.set('n', '<leader>w', '<C-w>')

  -- navigation
  map_vscode('n', '<leader> ', 'workbench.action.quickOpen')
  map_vscode('n', '<leader>fn', 'actions.find')
  map_vscode('n', '<leader>fg', 'workbench.action.findInFiles')
  map_vscode('n', '<leader>fG', 'search.action.openEditor')
  map_vscode('n', '<leader>b', 'workbench.action.showAllEditors')
  map_vscode('n', '<leader>,', 'workbench.action.navigateToLastNavigationLocation')

  -- lsp action
  map_vscode('n', '<leader>.', 'editor.action.quickFix')
  map_vscode('n', 'gr', 'editor.action.referenceSearch.trigger')
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
