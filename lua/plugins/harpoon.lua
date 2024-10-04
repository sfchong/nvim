return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = {
    { 'nvim-lua/plenary.nvim' },
    { 'nvim-telescope/telescope.nvim' }
  },
  config = function()
    local harpoon = require('harpoon')

    harpoon:setup()

    -- basic telescope configuration
    local conf = require('telescope.config').values
    local function toggle_telescope(harpoon_files)
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end

      require('telescope.pickers').new({}, {
        prompt_title = 'Harpoon',
        finder = require('telescope.finders').new_table({
          results = file_paths,
        }),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
      }):find()
    end

    vim.keymap.set('n', '<leader>pa', function() harpoon:list():add() end, { desc = 'Harpoon add file' })
    -- vim.keymap.set('n', '<leader>pp', function() toggle_telescope(harpoon:list()) end, { desc = 'Harpoon menu' })
    vim.keymap.set('n', '<leader>pp', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
      { desc = 'Harpoon menu' })
    vim.keymap.set('n', '<leader>p,', function() harpoon:list():prev() end, { desc = 'Harpoon previous file' })
    vim.keymap.set('n', '<leader>pn', function() harpoon:list():next() end, { desc = 'Harpoon next file' })

    for i = 1, 9, 1 do
      vim.keymap.set('n', '<leader>' .. i, function() harpoon:list():select(i) end, { desc = 'Harpoon select ' .. i })
    end
  end
}
