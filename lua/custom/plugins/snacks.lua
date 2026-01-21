return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    bigfile = {
      notify = true,
      size = 1.5 * 1024 * 1024, -- 1.5MB

      line_length = 1000, -- average line length (useful for minified files)
      ---@param ctx {buf: number, ft:string}

      setup = function(ctx)
        if vim.fn.exists ':NoMatchParen' ~= 0 then
          vim.cmd [[NoMatchParen]]
        end

        Snacks.util.wo(0, { foldmethod = 'manual', statuscolumn = '', conceallevel = 0 })
        vim.b.completion = false

        vim.b.minianimate_disable = true

        vim.b.minihipatterns_disable = true
        vim.schedule(function()
          if vim.api.nvim_buf_is_valid(ctx.buf) then
            vim.bo[ctx.buf].syntax = ctx.ft
          end
        end)
      end,
    },
    gh = {},
    picker = {
      matcher = {
        fuzzy = true, -- use fuzzy matching
        smartcase = true, -- use smartcase
        ignorecase = true, -- use ignorecase

        sort_empty = false, -- sort results when the search string is empty
        filename_bonus = true, -- give bonus for matching file names (last part of the path)
        file_pos = true, -- support patterns like `file:line:col` and `file:line`
        -- the bonusses below, possibly require string concatenation and path normalization,
        -- so this can have a performance impact for large lists and increase memory usage
        cwd_bonus = false, -- give bonus for matching files in the cwd
        frecency = false, -- frecency bonus
        history_bonus = false, -- give more weight to chronological order
      },
      sort = {

        -- default sort is by score, text length and index
        fields = { 'score:desc', '#text', 'idx' },
      },
      ui_select = true,
      layout = 'telescope',
      sources = {
        gh_issue = {},
        gh_pr = {},
      },
      win = {
        input = {
          keys = {
            ['p'] = { 'focus_preview', mode = { 'n', 'x' } },
          },
        },
      },
    },
    indent = { enabled = true },
    input = {
      icon = ' ',
      icon_hl = 'SnacksInputIcon',
      icon_pos = 'left',
      prompt_pos = 'title',
      win = { style = 'input' },
      expand = true,
    },
    notifier = {
      ---@class snacks.notifier.Config
      ---@field enabled? boolean
      ---@field keep? fun(notif: snacks.notifier.Notif): boolean # global keep function
      ---@field filter? fun(notif: snacks.notifier.Notif): boolean # filter our unwanted notifications (return false to hide)
      timeout = 3000, -- default timeout in ms
      width = { min = 40, max = 0.4 },
      height = { min = 1, max = 0.6 },
      -- editor margin to keep free. tabline and statusline are taken into account automatically

      margin = { top = 0, right = 1, bottom = 0 },
      padding = true, -- add 1 cell of left/right padding to the notification window
      gap = 0, -- gap between notifications
      sort = { 'level', 'added' }, -- sort by level and time
      -- minimum log level to display. TRACE is the lowest
      -- all notifications are stored in history
      level = vim.log.levels.TRACE,
      icons = {
        error = ' ',
        warn = ' ',
        info = ' ',
        debug = ' ',
        trace = ' ',
      },
      keep = function(notif)
        return vim.fn.getcmdpos() > 0
      end,
      ---@type snacks.notifier.style
      style = 'minimal',
      top_down = true, -- place notifications from top to bottom
      date_format = '%R', -- time format for notifications

      -- format for footer when more lines are available
      -- `%d` is replaced with the number of lines.
      -- only works for styles with a border
      ---@type string|boolean
      more_format = ' ↓ %d lines ',
      refresh = 50, -- refresh at most every 50ms
    },
    quickfile = { enabled = true },
    statuscolumn = { enabled = true },
  },
  keys = {
    {
      '<leader>gi',
      function()
        Snacks.picker.gh_issue()
      end,
      desc = 'Github Issues that is open',
    },
    {
      '<leader>gI',
      function()
        Snacks.picker.gh_issue { state = 'all' }
      end,
      desc = 'All Github Issues',
    },
    {
      '<leader>gp',
      function()
        Snacks.picker.gh_pr()
      end,
      desc = 'Github Pull Requests that is open',
    },
    {
      '<leader>gP',
      function()
        Snacks.picker.gh_pr { state = 'all' }
      end,
      desc = 'All Github Pull Requests',
    },
    {
      '<leader>sh',
      function()
        Snacks.picker.help()
      end,
      desc = '[S]earch [H]elp',
    },
    {
      '<leader>sk',
      function()
        Snacks.picker.keymaps()
      end,
      desc = '[S]earch [K]eymaps',
    },
    {
      '<leader>sf',
      function()
        Snacks.picker.files()
      end,
      desc = '[S]earch [F]iles',
    },
    {
      '<leader>sk',
      function()
        Snacks.picker.keymaps()
      end,
      desc = '[S]earch [K]eymaps',
    },
    {
      '<leader>ss',
      function()
        Snacks.picker()
      end,
      desc = '[S]earch [S]elect Pickers',
    },
    {
      '<leader>sg',
      function()
        Snacks.picker.grep()
      end,
      desc = '[S]earch by [G]rep',
    },
    {
      '<leader>sd',
      function()
        Snacks.picker.diagnostics()
      end,
      desc = '[S]earch [D]iagnostics',
    },
    {
      '<leader>sr',
      function()
        Snacks.picker.resume()
      end,
      desc = '[S]earch [R]esume',
    },
    {
      '<leader>s.',
      function()
        Snacks.picker.recent()
      end,
      desc = '[S]earch Recent Files ("." for repeat)',
    },
    {
      '<leader><leader>',
      function()
        Snacks.picker.buffers()
      end,
      desc = '[ ] Find existing buffers',
    },
    {
      '<leader>s/',
      function()
        Snacks.picker.grep_buffers()
      end,
      desc = '[S]earch [/] in Open Files',
    },
    {
      '<leader>/',
      function()
        Snacks.picker.lines {
          layout = {
            preset = 'select',
            -- auto_hide = { 'preview' },
          },
        }
      end,
      desc = '[/] Fuzzily seasrch in current buffer',
    },
    {
      '<leader>sn',
      function()
        Snacks.picker.files { cwd = vim.fn.stdpath 'config' }
      end,
      desc = '[S]earch [N]eovim files',
    },
    {
      '<leader>sw',
      function()
        Snacks.picker.grep_word()
      end,
      desc = '[S]earch current [W]ord',
    },
    {
      'grr',
      function()
        Snacks.picker.lsp_references()
      end,
      desc = '[G]oto [R]eferences',
    },
    {
      'gri',
      function()
        Snacks.picker.lsp_implementations()
      end,
      desc = '[G]oto [I]mplementation',
    },
    {
      'grd',
      function()
        Snacks.picker.lsp_definitions()
      end,
      desc = '[G]oto [D]efinition',
    },
    {
      'gO',
      function()
        Snacks.picker.lsp_symbols()
      end,
      desc = 'Open Document Symbols',
    },
    {
      'gW',
      function()
        Snacks.picker.lsp_workspace_symbols()
      end,
      desc = 'Open Workspace Symbols',
    },
    {
      'grt',
      function()
        Snacks.picker.lsp_type_definitions()
      end,
      desc = '[G]oto [T]ype Definition',
    },
  },
}
