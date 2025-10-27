local ls = require 'luasnip'
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local extras = require 'luasnip.extras'
local rep = extras.rep -- rep(index)
local fmt = require('luasnip.extras.fmt').fmt
local c = ls.choice_node -- c(index, {choices})
local f = ls.function_node -- f(function())
local d = ls.dynamic_node
local sn = ls.snippet_node

vim.keymap.set({ 'i', 's' }, '<C-e>', function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end, { silent = true })

ls.add_snippets('javascript', {
  s('cslgs', fmt([[console.log("{}")]], { i(1) })),
  s('cslg', fmt([[console.log({})]], { i(1) })),
  -- s('cslgc', fmt([[console.log({})]], { c(1, { t 'red', t 'green' }) })),
})

ls.add_snippets('go', {
  s(
    'ie',
    fmt(
      [[
if err != nil {{
	return {}
}}
			  ]],
      { i(1) }
    )
  ),
})
