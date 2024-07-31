return {
  'numToStr/Comment.nvim',
  dependencies = { 'JoosepAlviste/nvim-ts-context-commentstring' },
  config = function()
    local comment = require('Comment')
    comment.setup({
      toggler = {
        ---Line-comment toggle keymap
        line = '<leader>/',
        ---Block-comment toggle keymap
        block = 'gbc',
      },
      ---LHS of operator-pending mappings in NORMAL and VISUAL mode
      opleader = {
        ---Line-comment keymap
        line = '<leader>/',
        ---Block-comment keymap
        block = 'gb',
      },
      pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook()
    })
  end
}
