return { -- You can easily change to a different colorscheme.
  'folke/tokyonight.nvim',
  priority = 1000,
  config = function()
    ---@diagnostic disable-next-line: missing-fields
    require('tokyonight').setup {
      transparent = true,
      styles = {
        sidebars = 'transparent',
        floats = 'transparent',
        comments = { italic = false },
      },
    }
    vim.cmd.colorscheme 'tokyonight-night'
  end,
}
