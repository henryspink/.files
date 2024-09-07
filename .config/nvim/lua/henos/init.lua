require("henos.remaps")
require("henos.colours")
require("henos.plugins")

vim.wo.number = true
vim.wo.relativenumber = true
vim.o.tabstop = 4
vim.o.expandtab = true
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.opt.showmode = false

vim.opt.smartindent = true

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.scrolloff = 8
vim.opt.updatetime = 50

vim.g.have_nerd_font = true

vim.opt.mouse = 'a'
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

vim.opt.undofile = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

vim.opt.inccommand = 'split'

vim.opt.cursorline = true

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})



vim.cmd("Neotree filesystem reveal right")












































































