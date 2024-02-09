return {
  'rmagatti/auto-session',
  config = function()
    local autosession = require('auto-session')

    autosession.setup {
      log_level = 'error',
      auto_session_allowed_dirs = { '~/code/*', '~/dotfiles' },
      auto_session_suppress_dirs = { '~/', '/' },
    }
  end
}
