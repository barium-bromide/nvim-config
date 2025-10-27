vim.bo.expandtab = false
vim.cmd [[
set makeprg=cargo\ clippy\ --\ -Wclippy::all\ -Wclippy::pedantic
]]
