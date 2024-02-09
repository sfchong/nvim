return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local lualine = require('lualine')

    local filename = {
      'filename',
      file_status = true, -- displays file status (readonly status, modified status)
      path = 1            -- 0 = just filename, 1 = relative path, 2 = absolute path
    }

    lualine.setup {
      options = {
        icons_enabled = false,
        theme = 'gruvbox-material'
      },
      sections = {
        lualine_c = {
          filename
        },
        lualine_x = { '', '', 'filetype' },
      },
      inactive_sections = {
        lualine_c = {
          filename
        }
      }
    }
  end
}
