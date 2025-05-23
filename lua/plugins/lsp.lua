return {
  'neovim/nvim-lspconfig',
  dependencies = {
    {
      'williamboman/mason.nvim',
      opts = {},
      run = ':MasonUpdate'
    },
    { 'williamboman/mason-lspconfig.nvim' },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'folke/neodev.nvim' },
    { 'nvim-telescope/telescope.nvim' },
  },
  config = function()
    require('neodev').setup({})

    local mason_lspconfig = require('mason-lspconfig')
    local telescope = require('telescope.builtin')

    local test_file_patterns = {
      '%.test.ts',
      '%.test.tsx',
    }

    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('lsp_cmds', { clear = true }),
      desc = 'LSP actions',
      callback = function(args)
        vim.bo[args.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        local map = function(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = args.buf, desc = desc })
        end
        local function toggle_unit_test()
          -- Get the current buffer name
          local current_file = vim.fn.expand("%:p")
          if current_file == '' then
            print("Error: No file name")
            return
          end

          -- Extract directory, base file name without extension, and extension
          local directory, file_name = current_file:match("(.*/)(.*)")
          local base_name, ext = file_name:match("(.*)%.([^.]*)$")

          if not directory or not base_name or not ext then
            print("Error: Unable to parse file path")
            return
          end

          -- Check if the file is a test file
          local is_test_file = string.match(base_name, "%.test$")

          if is_test_file then
            -- Remove the test suffix and replace with original file extension
            local original_file = directory .. base_name:gsub("%.test$", "") .. "." .. ext
            vim.cmd("edit " .. original_file)
          else
            -- Append the test suffix and replace with test file extension
            local test_file = directory .. base_name .. ".test." .. ext
            vim.cmd("edit " .. test_file)
          end
        end

        map('n', 'K', vim.lsp.buf.hover, 'Hover')
        -- map('n', 'gd', function() telescope.lsp_definitions() end, 'Go to definition')
        map('n', 'gd', vim.lsp.buf.definition, 'Go to definition')
        map('n', 'gD', vim.lsp.buf.declaration, 'Go to declaration')
        map('n', 'gI', function() telescope.lsp_implementations() end, 'Go to implementation')
        map('n', 'go', function() telescope.lsp_type_definitions() end, 'Go to type definition')
        map('n', 'gr', function() telescope.lsp_references() end, 'Go to reference')
        map('n', 'gR', function()
            telescope.lsp_references({ file_ignore_patterns = test_file_patterns })
          end,
          'Go to reference (no test)')
        map({ 'n', 'i' }, '<C-k>', vim.lsp.buf.signature_help, 'Signature help')
        map('n', '<leader>cr', vim.lsp.buf.rename, 'Rename')
        map('n', '<leader>.', vim.lsp.buf.code_action, 'Code action')
        map('n', '<leader>ce', vim.diagnostic.open_float, 'Open float')
        map('n', '<leader>ct', toggle_unit_test, 'Toggle unit test')
      end
    })

    vim.lsp.config('lua_ls', {
      settings = {
        Lua = {
          runtime = {
            -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
            version = 'LuaJIT',
            -- Setup your lua path
            path = vim.split(package.path, ';'),
          },
          diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = { 'vim' },
          },
          workspace = {
            -- Make the server aware of Neovim runtime files
            library = vim.api.nvim_get_runtime_file('', true),
            checkThirdParty = false
          },
        },
      },
    })

    local base_on_attach = vim.lsp.config.eslint.on_attach
    vim.lsp.config("eslint", {
      on_attach = function(client, bufnr)
        if not base_on_attach then return end

        base_on_attach(client, bufnr)
        vim.api.nvim_create_autocmd("BufWritePre", {
          buffer = bufnr,
          command = "LspEslintFixAll",
        })
      end,
    })

    mason_lspconfig.setup({
      ensure_installed = {
        'ts_ls',
        'lua_ls',
        'cssls',
        'html',
        'eslint',
        'graphql'
      }
    })
  end
}
