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
    { 'Hoffs/omnisharp-extended-lsp.nvim' }
  },
  config = function()
    require('neodev').setup({})

    local cmp_nvim_lsp = require('cmp_nvim_lsp')
    local lspconfig = require('lspconfig')
    local mason_lspconfig = require('mason-lspconfig')
    local telescope = require('telescope.builtin')

    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('lsp_cmds', { clear = true }),
      desc = 'LSP actions',
      callback = function(args)
        vim.bo[args.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
        local client = vim.lsp.get_client_by_id(args.data.client_id)

        local map = function(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = args.buf, desc = desc })
        end

        map('n', 'K', vim.lsp.buf.hover, 'Hover')
        map('n', 'gd', function() telescope.lsp_definitions() end, 'Go to definition')
        map('n', 'gD', vim.lsp.buf.declaration, 'Go to declaration')
        map('n', 'gI', function() telescope.lsp_implementations() end, 'Go to implementation')
        map('n', 'go', function() telescope.lsp_type_definitions() end, 'Go to type definition')
        map('n', 'gr', function() telescope.lsp_references() end, 'Go to reference')
        map({ 'n', 'i' }, '<C-k>', vim.lsp.buf.signature_help, 'Signature help')
        map('n', '<leader>cr', vim.lsp.buf.rename, 'Rename')
        map('n', '<leader>.', vim.lsp.buf.code_action, 'Code action')
        map('n', '<leader>ce', vim.diagnostic.open_float, 'Open float')

        if client.name == 'omnisharp' then
          map('n', 'gd', function() require('omnisharp_extended').telescope_lsp_definitions() end,
            'Go to definition (omnisharp)')
        end
        if client.name == 'eslint' then
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = args.buf,
            command = "EslintFixAll",
          })
        end
      end
    })


    local lsp_options = {
      capabilities = cmp_nvim_lsp.default_capabilities()
    }

    mason_lspconfig.setup({
      ensure_installed = {
        'tsserver',
        'lua_ls',
        'cssls',
        'html',
        'eslint'
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
      ["omnisharp"] = function()
        lspconfig.omnisharp.setup(vim.tbl_deep_extend("force", lsp_options, {
          handlers = {
            ["textDocument/definition"] = require('omnisharp_extended').handler,
          },
          cmd = {
            "dotnet",
            vim.fn.expand("$HOME/.local/share/nvim/mason/packages/omnisharp/libexec/OmniSharp.dll"),
          },
        }))
      end
    })
  end
}
