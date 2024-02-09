return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  event = 'VeryLazy',
  dependencies = {
    { 'windwp/nvim-ts-autotag' }
  },
  opts = {
    highlight = { enable = true },
    indent = { enable = false },
    ensure_installed = {
      'bash',
      'css',
      'c_sharp',
      'go',
      'html',
      'javascript',
      'json',
      'jsonc',
      'lua',
      'markdown',
      'markdown_inline',
      'scss',
      'svelte',
      'toml',
      'tsx',
      'typescript',
      'vim',
      'vimdoc',
      'yaml'
    },
  },
  config = function(_, opts)
    require('nvim-treesitter.configs').setup(opts)
  end,
}
