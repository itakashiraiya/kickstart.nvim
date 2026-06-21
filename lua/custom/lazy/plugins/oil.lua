return {
  'stevearc/oil.nvim',
  config = function()
    require('oil').setup {
      vim.keymap.set('n', '<leader>o', require('oil').open, { desc = 'open [o]il' }),
      restore_cursor = true,
      skip_confirm_for_simple_edits = true,
      columns = { 'icon' },
    }
  end,
}
