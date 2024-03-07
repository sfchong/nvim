return {
  'stevearc/conform.nvim',
  dependencies = { 'mason.nvim' },
  event = 'LspAttach',
  opts = {
    formatters_by_ft = {
      typescript = { { 'prettierd', 'prettier' } },
      typescriptreact = { { 'prettierd', 'prettier' } },
      javascript = { { 'prettierd', 'prettier' } },
      javascriptreact = { { 'prettierd', 'prettier' } },
      json = { { 'prettierd', 'prettier' } },
      jsonc = { { 'prettierd', 'prettier' } },
      html = { { 'prettierd', 'prettier' } },
      css = { { 'prettierd', 'prettier' } },
      scss = { { 'prettierd', 'prettier' } },
      markdown = { { 'prettierd', 'prettier' } },
      yaml = { { 'prettierd', 'prettier' } },
      go = { 'gofmt' }
    },
    format_on_save = {
      lsp_fallback = true,
      timeout_ms = 500,
    },
    format_after_save = {
      lsp_fallback = true,
    },
  },
  config = function(_, opts)
    local conform = require('conform')
    conform.setup(opts)

    vim.keymap.set({ 'n', 'v' }, '<leader>cf', function()
      conform.format({ lsp_fallback = true, async = true, timeout_ms = 500 })
    end, { desc = 'Format document' })
  end

}
