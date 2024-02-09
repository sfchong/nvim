return {
  'luukvbaal/nnn.nvim',
  keys = {
    { '<F2>',       '<cmd>NnnExplorer %:p:h<CR>', desc = 'NnnExplorer' },
    { '<leader>ee', '<cmd>NnnPicker<CR>',         desc = 'NnnPicker' },
    { '<leader>ec', '<cmd>NnnPicker %:p:h<CR>',   desc = 'NnnPicker in current directory' },
  },
  config = function()
    local nnn = require('nnn')

    nnn.setup({
      explorer = { cmd = 'nnn -eoHA', session = '', side = 'topleft', width = 32 },
      picker = { cmd = 'nnn -eoHdA', style = { border = 'none' }, tabs = false },
      replace_netrw = 'picker',
      mappings = {
        { '<C-t>', nnn.builtin.open_in_tab },       -- open file(s) in tab
        { '<C-s>', nnn.builtin.open_in_split },     -- open file(s) in split
        { '<C-v>', nnn.builtin.open_in_vsplit },    -- open file(s) in vertical split
        { '<C-y>', nnn.builtin.copy_to_clipboard }, -- copy file(s) to clipboard
        -- { '<C-w>', nnn.builtin.cd_to_path },        -- cd to file directory
        { '<C-p>', nnn.builtin.open_in_preview },   -- open file in preview split keeping nnn focused
        { '<C-e>', nnn.builtin.populate_cmdline },  -- populate cmdline (:) with file(s)
      },
    })

    vim.keymap.set('t', '<F2>', '<cmd>NnnExplorer<CR>', { desc = 'NnnExplorer' })
  end
}
