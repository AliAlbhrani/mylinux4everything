vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.relativenumber = true
vim.opt.number = true
vim.g.auto_save = false
vim.opt.clipboard = "unnamedplus"
vim.cmd("set tabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set expandtab")
vim.opt.foldmethod = "indent" -- or "syntax" or "expr"
vim.opt.foldlevel = 99        -- Start with all folds open
vim.opt.foldenable = true
vim.filetype.add({
  extension = {
    jsx = "javascriptreact",
  },
})
