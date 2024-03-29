local function augroup(name)
  return vim.api.nvim_create_augroup('lazyvim_' .. name, { clear = true })
end

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ 'FocusGained', 'TermClose', 'TermLeave' }, {
  group = augroup('checktime'),
  callback = function()
    if vim.o.buftype ~= 'nofile' then
      vim.cmd('checktime')
    end
  end
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ 'VimResized' }, {
  group = augroup('resize_splits'),
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd('tabdo wincmd =')
    vim.cmd('tabnext ' .. current_tab)
  end,
})

-- save without formatting
vim.api.nvim_create_user_command('SaveWithoutFormatting',
  function()
    vim.cmd [[noautocmd write]]
  end,
  {}
)

-- better mapping for netrw
vim.api.nvim_create_autocmd('filetype', {
  pattern = 'netrw',
  desc = 'Better mappings for netrw',
  callback = function()
    local bind = function(lhs, rhs)
      vim.keymap.set('n', lhs, rhs, { remap = true, buffer = true })
    end

    -- edit new file
    bind('n', '%')

    -- rename file
    bind('r', 'R')
  end
})

-- close all other buffers
vim.api.nvim_create_user_command('BufferCloseOther',
  function()
    -- write - save current buffer without formatting
    -- %bd - close all the buffers
    -- e# - open last edited files
    -- bd# - close the unnamed buffer
    vim.cmd [[noautocmd write|%bd|e#|bd#]]
  end,
  {}
)

vim.api.nvim_create_user_command('YankCurrentPath',
  function()
    vim.cmd [[let @+ = expand('%')]]
  end,
  {}
)

vim.api.nvim_create_autocmd('Filetype', {
  group = augroup('setIndent'),
  pattern = { 'xml', 'html', 'xhtml', 'css', 'scss', 'javascript', 'typescript', 'yaml', 'lua', 'jsx', 'tsx',
    'typescriptreact', 'javascriptreact'
  },
  command = 'setlocal shiftwidth=2 tabstop=2'
})
