return {
  'tpope/vim-fugitive',
  vim.keymap.set('n', '<leader>gh', '<cmd>diffget //2 <CR>', { desc = '[G]it diff get left' }),
  vim.keymap.set('n', '<leader>gl', '<cmd>diffget //2 <CR>', { desc = '[G]it diff get right' }),
  vim.keymap.set('n', '<leader>gs', '<cmd>:Git <CR>', { desc = '[G]it status' }),
}
