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
    { 'nvim-telescope/telescope.nvim' }
  },
  config = function()
    local cmp_nvim_lsp = require('cmp_nvim_lsp')
    local lspconfig = require('lspconfig')
    local mason_lspconfig = require('mason-lspconfig')
    local telescope = require('telescope.builtin')
    local capabilities = cmp_nvim_lsp.default_capabilities()

    local on_attach = function(client, bufnr)
      vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

      if client.name == 'tsserver' or client.name == 'gopls' then
        client.server_capabilities.documentFormattingProvider = false
      end

      local opts = { noremap = true, silent = true, buffer = bufnr }

      vim.keymap.set('n', 'gd', function() telescope.lsp_definitions() end,
        { table.unpack(opts), desc = 'Go to definition' })
      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { table.unpack(opts), desc = 'Go to declaration' })
      vim.keymap.set('n', 'gt', function() telescope.lsp_type_definitions() end,
        { table.unpack(opts), desc = 'Go to type definition' })
      vim.keymap.set('n', 'gr', function() telescope.lsp_references() end,
        { table.unpack(opts), desc = 'Go to reference' })
      vim.keymap.set('n', 'gi', function() telescope.lsp_implementations() end,
        { table.unpack(opts), desc = 'Go to implementation' })
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, { table.unpack(opts), desc = 'Hover' })
      vim.keymap.set({ 'n', 'i' }, '<C-k>', vim.lsp.buf.signature_help,
        { table.unpack(opts), desc = 'Display function signature' })
      vim.keymap.set('n', '<leader>cr', vim.lsp.buf.rename, { table.unpack(opts), desc = 'Rename' })
      vim.keymap.set('n', '<leader>.', vim.lsp.buf.code_action, { table.unpack(opts), desc = 'Code action' })
      vim.keymap.set("n", "<leader>ce", function() vim.diagnostic.open_float() end,
        { table.unpack(opts), desc = "Show error popup" })
    end


    local lsp_options = {
      capabilities = capabilities,
      on_attach = on_attach
    }

    mason_lspconfig.setup({
      ensure_installed = {
        'tsserver',
        'lua_ls',
        'cssls',
        'html',
      }
    })

    mason_lspconfig.setup_handlers({
      function(server_name)
        lspconfig[server_name].setup(lsp_options)
      end,
      ['lua_ls'] = function()
        lspconfig.lua_ls.setup(vim.tbl_deep_extend('force', lsp_options, {
          cmd = { 'lua-language-server' },
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
        }))
      end,
      -- ["omnisharp"] = function ()
      --     lspconfig.omnisharp.setup(vim.tbl_deep_extend("force", lsp_options, {
      --         cmd = { "dotnet", vim.fn.expand("$HOME/.local/share/nvim/mason/packages/omnisharp/libexec/OmniSharp.dll")},
      --     }))
      -- end
    })
  end
}
