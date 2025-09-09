local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>sb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = 'Telescope help tags' })
vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = 'Telescope grep word under cursor' })
vim.keymap.set('v', '<leader>sw', function()
  -- Exit visual mode and get the selection
  vim.cmd('normal! "vy')
  local selection = vim.fn.getreg('v')
  
  -- Clean up any trailing newlines
  selection = selection:gsub('\n$', '')
  
  builtin.grep_string({ search = selection })
end, { desc = 'Telescope grep selection' })
