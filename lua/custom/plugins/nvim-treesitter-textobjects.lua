return {
  'nvim-treesitter/nvim-treesitter-textobjects',
  lazy = true,
  config = function()
    require('nvim-treesitter.configs').setup {
      textobjects = {

        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ['am'] = '@function.outer',

            ['im'] = '@function.inner',
            ['ac'] = '@class.outer',
            ['ic'] = '@class.inner',
          },
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
              { [']m'] = '@function.outer', desc = 'next method/function def start' },
              { [']]'] = '@class.outer', desc = 'next class start' },
            },
            goto_next_end = { { [']M'] = '@function.outer', desc = 'next method/function def end' }, { [']['] = '@class.outer', desc = 'next class end' } },
            goto_previous_start = {
              { ['[m'] = '@function.outer', desc = 'previous method/function def start' },
              { ['[['] = '@class.outer', desc = 'previous class start' },
            },
            goto_previous_end = {
              { ['[M'] = '@function.outer', desc = 'previous method/function def end' },
              { ['[]'] = '@class.outer', desc = 'previous class end' },
            },
          },
        },
      },
    }
  end,
}
