local map = function(mode, lhs, rhs, desc, opts)
  local options = { noremap = true }
  if desc then
    options.desc = desc
  end
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end

  vim.keymap.set(mode, lhs, rhs, options)
end

-- prevent clipboard override by selected text when pasting
map('x', 'p', '\"_dP')

-- no override clipboard when x and c
map('n', 'x', '\"_x')
map('v', 'x', '\"_x')
map('n', 'c', '\"_c')

-- exit vim
map('n', '<leader>q', ':q<cr>', 'Quit')
map('n', '<leader>Q', ':q!<cr>', 'Force Quit')

-- buffer
map('n', '<leader>bn', ':bnext<cr>', 'Next buffer')
map('n', '<leader>n', ':bnext<cr>', 'Next buffer')
map('n', '<leader>b,', ':bprev<cr>', 'Previous buffer')
map('n', '<leader>,', ':bprev<cr>', 'Previous buffer')
map('n', '<leader>bx', ':bd<cr>', 'Delete buffer')
map('n', '<leader>bX', ':bd!<cr>', 'Force delete buffer')

-- save
map('n', '<leader>s', ':w<cr>', 'Save file')
map('n', '<leader>S', ':wq<cr>', 'Save and quit')

-- select all
map('n', '<leader>a', 'ggVG', 'Select all')

-- Redo
map('n', 'U', '<C-r>', 'Redo')

-- keep visual mode after indent
map('v', '<', '<gv')
map('v', '>', '>gv')

-- re-center after scroll
-- map('n', '<C-d>', '<C-d>zz')
-- map('n', '<C-u>', '<C-u>zz')

-- disable q:
map('n', 'q:', '<nop>')

-- netrw
-- map('n', '<F2>', '<cmd>Lexplore<cr>')

-- exit terminal mode
-- map('t', '<Esc>', [[<C-\><C-n><CR>]])
