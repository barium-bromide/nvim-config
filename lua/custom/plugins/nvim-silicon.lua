return {
  'michaelrommel/nvim-silicon',
  lazy = true,
  cmd = 'Silicon',
  main = 'nvim-silicon',
  opts = {
    -- Configuration here, or leave empty to use defaults
    line_offset = function(args)
      return args.line1
    end,
  },
  vim.keymap.set('v', '<leader>cs', function()
    require('nvim-silicon').clip()
  end, { desc = '[c]ode screenshot to clipboard' }),
  vim.keymap.set('v', '<leader>cf', function()
    require('nvim-silicon').file()
  end, { desc = '[c]ode screenshot to file' }),
}
