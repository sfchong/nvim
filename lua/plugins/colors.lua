return {
  -- {
  --   'eddyekofo94/gruvbox-flat.nvim',
  --   -- priority = 1000,
  --   config = function()
  --     -- vim.g.gruvbox_flat_style = 'hard'
  --     -- vim.g.gruvbox_transparent = true
  --     -- vim.cmd [[colorscheme gruvbox-flat]]
  --   end
  -- },
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
      vim.g.gruvbox_material_background = 'hard'
      vim.g.gruvbox_material_ui_contrast = 'high'
      vim.g.gruvbox_material_float_style = 'dim'
      vim.g.gruvbox_material_diagnostic_virtual_text = 'colored'
      vim.g.gruvbox_material_transparent_background = 1
      vim.cmd([[colorscheme gruvbox-material]])
    end
  },
}
