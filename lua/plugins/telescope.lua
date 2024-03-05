return {
  'nvim-telescope/telescope.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local telescope = require('telescope')
    local actions = require('telescope.actions')

    telescope.setup {
      defaults = {
        mappings = {
          i = {
            ['<C-h>'] = 'which_key',
            ['<esc>'] = actions.close,
          }
        },
        file_ignore_patterns = { 'node_modules/' }
      },
      pickers = {
        find_files = {
          find_command = { 'rg', '--files', '--hidden', '-g', '!.git' }
        },
        live_grep = {
          file_ignore_patterns = { 'node_modules', '.git' },
          additional_args = function(_)
            return { '--hidden' }
          end
        },
        buffers = {
          sort_lastused = true,
          mappings = {
            i = {
              ['<C-d>'] = 'delete_buffer',
            }
          }
        },
        lsp_references = {
          -- fname_width = 100
          show_line = false
        },
        colorscheme = {
          enable_preview = true
        },
        help_tags = {
          mappings = {
            i = {
              ["<CR>"] = "file_vsplit",
            },
          },
        },
      }
    }

    local telescope_builtin = require('telescope.builtin')

    local function find_files_without_test()
      telescope_builtin.find_files({
        find_command = { 'rg', '--files', '--hidden', '-g', '!.git', '-g', '!tests', '-g', '!*test.ts' }
      })
    end

    local function live_grep_without_test()
      telescope_builtin.live_grep({
        file_ignore_patterns = { 'node_modules', '.git' },
        additional_args = { '--hidden', '-g', '!tests', '-g', '!*test.ts' }
      })
    end

    vim.keymap.set('n', '<leader>ff', function() telescope_builtin.find_files() end, { desc = 'Find files' })
    vim.keymap.set('n', '<leader>fF', find_files_without_test, { desc = 'Find files without test' })
    vim.keymap.set('n', '<leader><leader>', function() telescope_builtin.find_files() end, { desc = 'Find files' })
    vim.keymap.set('n', '<leader>fg', function() telescope_builtin.live_grep() end, { desc = 'Live grep' })
    vim.keymap.set('n', '<leader>fG', live_grep_without_test, { desc = 'Live grep without test' })
    vim.keymap.set('n', '<leader>bb', function() telescope_builtin.buffers() end, { desc = 'List buffers' })
    vim.keymap.set('n', '<leader>h', function() telescope_builtin.help_tags() end, { desc = 'Help page' })
    vim.keymap.set('n', '<leader>fn', function() telescope_builtin.current_buffer_fuzzy_find() end,
      { desc = 'Find current file' })
    vim.keymap.set('n', '<leader>ft', function() telescope_builtin.tagstack() end, { desc = 'List tagstack' })
    vim.keymap.set('n', '<leader>fo', function() telescope_builtin.jumplist() end, { desc = 'List jumplist' })
    vim.keymap.set('n', '<leader>fs', function() telescope_builtin.treesitter() end, { desc = 'List treesitter symbol' })
    vim.keymap.set('n', '<leader>fr', function() telescope_builtin.resume() end, { desc = 'Resume telescope' })
    -- vim.keymap.set('n', '<leader>fc', function() telescope_builtin.colorscheme() end, { desc = 'List colorscheme' })
    vim.keymap.set('n', '<leader>cd', function() telescope_builtin.diagnostics() end, { desc = 'Lists Diagnostics' })
  end
}
