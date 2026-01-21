return {
  'stevearc/quicker.nvim',
  ft = 'qf',
  ---@module "quicker"
  ---@type quicker.SetupOptions
  config = function()
    require('quicker').setup()
  end,
  vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' }),
}
