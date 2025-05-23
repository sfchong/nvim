return {
  'saghen/blink.cmp',
  version = '1.*',
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = {
      preset = "default",
      ['<CR>'] = { 'accept', 'fallback' },
    },
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },
    fuzzy = { implementation = "prefer_rust_with_warning" },
    signature = { enabled = true },
    cmdline = {
      keymap = {
        preset = 'inherit',
        ['<CR>'] = { 'accept_and_enter', 'fallback' }
      },
      completion = { menu = { auto_show = true } },
    }
  }
}
