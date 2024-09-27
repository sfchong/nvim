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

    wk.add({
      { "<leader>b",    group = "Buffer actions" },
      { "<leader>c",    group = "Code actions" },
      { "<leader>e",    group = "File explorer" },
      { "<leader>f",    group = "Find with Telescope" },
      { "<leader>p",    group = "Harpoon" },
      { "<leader>w",    proxy = "<C-w>",                desc = "Window actions" },
      { "<c-w>c",       desc = "Quit a window" },
      { "<c-w><left>",  desc = "Go to the left window" },
      { "<c-w><right>", desc = "Go to the right window" },
      { "<c-w><up>",    desc = "Go to the up window" },
      { "<c-w><down>",  desc = "Go to the down window" },
    })
  end
}
