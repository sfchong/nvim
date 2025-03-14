return {
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = {} -- this is equalent to setup({}) function
  },
  {
    'kylechui/nvim-surround',
    version = '*', -- Use for stability; omit to use `main` branch for the latest features
    event = 'VeryLazy',
    config = function()
      require('nvim-surround').setup()
    end
  },
  {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {},
    config = function()
      local oil = require('oil')
      oil.setup({
        keymaps = {
          ['<C-v>'] = { 'actions.select', opts = { vertical = true } },
          ['q'] = { 'actions.close', mode = 'n' },
          ['<left>'] = { 'actions.parent', mode = 'n' },
          ['<right>'] = { 'actions.select', mode = 'n' }
        }
      })

      vim.keymap.set('n', '<leader>eo', '<cmd>Oil --float<CR>', { desc = 'Oil Explorer' })
    end
  },
  {
    "OXY2DEV/markview.nvim",
    lazy = false
  },
  {
    'github/copilot.vim',
    event = 'InsertEnter'
  }
}
