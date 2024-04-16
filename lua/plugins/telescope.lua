return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    { 'nvim-lua/plenary.nvim' },
    { 'nvim-telescope/telescope-file-browser.nvim' },
    { 'nvim-telescope/telescope-live-grep-args.nvim' }
  },
  config = function()
    local telescope = require('telescope')
    local actions = require('telescope.actions')
    local telescope_builtin = require('telescope.builtin')
    local lga_actions = require("telescope-live-grep-args.actions")

    local ts_select_dir_for_grep = function(prompt_bufnr)
      local action_state = require("telescope.actions.state")
      local fb = require("telescope").extensions.file_browser
      local lga = require("telescope").extensions.live_grep_args
      local current_line = action_state.get_current_line()

      fb.file_browser({
        files = false,
        depth = 1,
        hide_parent_dir = true,
        attach_mappings = function(prompt_bufnr)
          require("telescope.actions").select_default:replace(function()
            local entry_path = action_state.get_selected_entry().Path
            local dir = entry_path:is_dir() and entry_path or entry_path:parent()
            local relative = dir:make_relative(vim.fn.getcwd())
            local absolute = dir:absolute()

            lga.live_grep_args({
              results_title = relative .. "/",
              cwd = absolute,
              default_text = current_line,
            })
          end)

          return true
        end,
      })
    end

    local ts_select_dir_for_find_files = function(prompt_bufnr)
      local action_state = require("telescope.actions.state")
      local fb = require("telescope").extensions.file_browser
      local current_line = action_state.get_current_line()

      fb.file_browser({
        files = false,
        depth = 1,
        hide_parent_dir = true,
        attach_mappings = function(prompt_bufnr)
          require("telescope.actions").select_default:replace(function()
            local entry_path = action_state.get_selected_entry().Path
            local dir = entry_path:is_dir() and entry_path or entry_path:parent()
            local relative = dir:make_relative(vim.fn.getcwd())
            local absolute = dir:absolute()

            telescope_builtin.find_files({
              results_title = relative .. "/",
              cwd = absolute,
              default_text = current_line,
            })
          end)

          return true
        end,
      })
    end


    telescope.setup {
      defaults = {
        mappings = {
          i = {
            ['<C-h>'] = 'which_key',
            ['<esc>'] = actions.close,
            ["<C-s>"] = actions.to_fuzzy_refine
          }
        },
        file_ignore_patterns = { 'node_modules/' },
        wrap_results = true,
        vimgrep_arguments = {
          'rg',
          '--color=never',
          '--no-heading',
          '--with-filename',
          '--line-number',
          '--column',
          '--smart-case',
          '--hidden',
        },
      },
      pickers = {
        find_files = {
          find_command = { 'rg', '--files', '--hidden', '-g', '!.git' },
          mappings = {
            i = {
              ["<C-f>"] = ts_select_dir_for_find_files,
            },
          }
        },
        live_grep = {
          file_ignore_patterns = { 'node_modules', '.git' },
          mappings = {
            i = {
              ["<C-f>"] = ts_select_dir_for_grep,
            },
          }
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
        diagnostics = {
          line_width = 'full',
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
      },
      extensions = {
        live_grep_args = {
          file_ignore_patterns = { 'node_modules', '.git' },
          auto_quoting = false,
          mappings = {
            i = {
              ["<C-k>"] = lga_actions.quote_prompt(),
              ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
              ["<C-f>"] = ts_select_dir_for_grep
            },
          },
        }
      }
    }
    telescope.load_extension('file_browser')
    telescope.load_extension('live_grep_args')

    local function find_files_without_test()
      telescope_builtin.find_files({
        find_command = { 'rg', '--files', '--hidden', '-g', '!.git', '-g', '!tests', '-g', '!*test.ts', '-g', '!*test.tsx' }
      })
    end

    local function live_grep_without_test()
      telescope_builtin.live_grep({
        file_ignore_patterns = { 'node_modules', '.git' },
        additional_args = { '--hidden', '-g', '!tests', '-g', '!*test.ts', '-g', '!*test.tsx' }
      })
    end

    vim.keymap.set('n', '<leader>ff', function() telescope_builtin.find_files() end, { desc = 'Find files' })
    vim.keymap.set('n', '<leader>fF', find_files_without_test, { desc = 'Find files without test' })
    vim.keymap.set('n', '<leader><leader>', function() telescope_builtin.find_files() end, { desc = 'Find files' })
    -- vim.keymap.set('n', '<leader>fg', function() telescope_builtin.live_grep() end, { desc = 'Live grep' })
    vim.keymap.set('n', '<leader>fg', function() require('telescope').extensions.live_grep_args.live_grep_args() end,
      { desc = 'Live grep' })
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
