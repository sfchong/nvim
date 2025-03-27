return {
  {
    'catppuccin/nvim',
    lazy = true,
    name = 'catppuccin',
    keys = {
      { '<leader>fc', '<cmd>Telescope colorscheme<cr>', desc = 'Preview colorscheme' }
    },
  },
  {
    'sainnhe/gruvbox-material',
    priority = 1000,
    config = function()
      vim.o.termguicolors = true
      vim.o.background = 'dark'

      vim.g.gruvbox_material_background = 'hard'
      vim.g.gruvbox_material_ui_contrast = 'high'
      vim.g.gruvbox_material_float_style = 'dim'
      vim.g.gruvbox_material_diagnostic_virtual_text = 'colored'
      vim.g.gruvbox_material_transparent_background = 1
      vim.cmd([[colorscheme gruvbox-material]])
      vim.cmd([[
        highlight CursorLine guibg=#323232 guifg=NONE
      ]])
    end
  },
}
