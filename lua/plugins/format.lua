return {
  'stevearc/conform.nvim',
  dependencies = { 'mason.nvim' },
  event = 'LspAttach',
  config = function()
    local prettier_formatter = {
      'prettierd',
      'prettier',
      stop_after_first = true
    }

    local options = {
      formatters_by_ft = {
        typescript = prettier_formatter,
        typescriptreact = prettier_formatter,
        javascript = prettier_formatter,
        javascriptreact = prettier_formatter,
        json = prettier_formatter,
        jsonc = prettier_formatter,
        html = prettier_formatter,
        css = prettier_formatter,
        scss = prettier_formatter,
        markdown = prettier_formatter,
        yaml = prettier_formatter,
        go = { 'gofmt' }
      },
      format_on_save = {
        lsp_fallback = true,
        timeout_ms = 500,
      },
      format_after_save = {
        lsp_fallback = true,
      },
    }

    local conform = require('conform')
    conform.setup(options)

    vim.keymap.set({ 'n', 'v' }, '<leader>cf', function()
      conform.format({ lsp_fallback = true, async = true, timeout_ms = 500 })
    end, { desc = 'Format document' })
  end

}
