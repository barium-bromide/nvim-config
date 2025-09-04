return {
  'uga-rosa/ccc.nvim',
  config = function()
    local ccc = require 'ccc'
    ccc.setup {
      highlighter = {
        auto_enable = true,
        lsp = true,
      },
      inputs = {
        ccc.input.hsl,
        ccc.input.rgb,
        ccc.input.cmyk,
      },
      outputs = {
        ccc.output.css_hsl,
        ccc.output.hex,
        ccc.output.hex_short,
        ccc.output.css_rgb,
      },
      pickers = {
        ccc.picker.css_hsl,
        ccc.picker.hex,
        ccc.picker.css_rgb,
        ccc.picker.css_hwb,
        ccc.picker.css_lab,
        ccc.picker.css_lch,
        ccc.picker.css_oklab,
        ccc.picker.css_oklch,
      },
      recognize = {
        input = true,
        output = true,
      },
    }
  end,
  vim.keymap.set('n', '<leader>p', '<cmd>:CccPick<CR>', { desc = '[P]ick Colors' }),
}
