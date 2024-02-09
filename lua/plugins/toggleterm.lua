return {
  'akinsho/toggleterm.nvim',
  config = function()
    local toggleterm = require('toggleterm')

    toggleterm.setup({
      open_mapping = [[<F4>]],
      direction = 'float',
      float_opts = {
        border = 'rounded',
        shade_terminals = false
      }
    })
  end
}
