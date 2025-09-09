-- Install with your package manager:
-- lazy.nvim:
-- {
--   'Exafunction/codeium.vim',
--   event = 'BufEnter'
-- }

-- Codeium configuration
vim.g.codeium_disable_bindings = 1

-- Custom keymaps for Codeium
vim.keymap.set('i', '<C-g>', function() return vim.fn['codeium#Accept']() end, { expr = true, silent = true })
vim.keymap.set('i', '<c-;>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true, silent = true })
vim.keymap.set('i', '<c-,>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true, silent = true })
vim.keymap.set('i', '<c-x>', function() return vim.fn['codeium#Clear']() end, { expr = true, silent = true })

-- Optional: Manual trigger
vim.keymap.set('i', '<C-Space>', function() return vim.fn['codeium#Complete']() end, { expr = true, silent = true })

-- Show Codeium status in statusline (optional)
vim.g.codeium_enabled = true
