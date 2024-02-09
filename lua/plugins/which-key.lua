return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  opts = {},
  config = function()
    local wk = require('which-key')
    wk.register({
      b = {
        name = 'Buffer actions'
      },
      c = {
        name = 'Code actions'
      },
      e = {
        name = 'File explorer'
      },
      f = {
        name = 'Find with Telescope'
      },
      p = {
        name = 'Harpoon'
      }
    }, { prefix = '<leader>' })
  end
}
