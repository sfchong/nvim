return {
  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim',
      'nvim-telescope/telescope.nvim',
    },
    keys = {
      { '<leader>g', function() require('neogit').open() end, { desc = 'Neogit' } }
    },
    opts = {}
  },
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      local gitsigns = require('gitsigns')

      gitsigns.setup({
        current_line_blame = true
      })
    end
  }
}
