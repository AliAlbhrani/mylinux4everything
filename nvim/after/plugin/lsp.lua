-- LuaSnip setup (install with your package manager first)
local luasnip = require('luasnip')
local cmp = require('cmp')

-- Load snippets from friendly-snippets
require('luasnip.loaders.from_vscode').lazy_load()

-- LuaSnip configuration
luasnip.setup({
  history = true,
  updateevents = "TextChanged,TextChangedI",
  enable_autosnippets = true,
})

-- nvim-cmp setup for completion and snippets
cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }, {
    { name = 'buffer' },
    { name = 'path' },
  }),
  formatting = {
    format = function(entry, vim_item)
      -- Show source
      vim_item.menu = ({
        nvim_lsp = "[LSP]",
        luasnip = "[Snip]",
        buffer = "[Buf]",
        path = "[Path]",
      })[entry.source.name]
      return vim_item
    end
  },
})

-- Alternative keymaps for snippet navigation (if you prefer these)
vim.keymap.set({ "i", "s" }, "<C-L>", function() luasnip.jump(1) end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-J>", function() luasnip.jump(-1) end, { silent = true })

local function set_lsp_keymaps(bufnr)
  local opts = { buffer = bufnr, silent = true, noremap = true }

  -- Navigation
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
  vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, opts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)

  -- Documentation
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)

  -- Workspace
  vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
  vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
  vim.keymap.set('n', '<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, opts)

  -- Code actions
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
  vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)

  -- Formatting
  vim.keymap.set('n', '<leader>f', function()
    vim.lsp.buf.format { async = true }
  end, opts)

  -- Diagnostics - all types
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)

  -- Diagnostics - errors only
  vim.keymap.set('n', '[e', function()
    vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
  end, opts)
  vim.keymap.set('n', ']e', function()
    vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
  end, opts)

  -- Diagnostics - warnings only
  vim.keymap.set('n', '[w', function()
    vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.WARN })
  end, opts)
  vim.keymap.set('n', ']w', function()
    vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.WARN })
  end, opts)
end

-- Create LSP capabilities with snippet support
local function create_capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  return capabilities
end

-- Configure LSP servers with snippet support
vim.lsp.config('gopls', {
  cmd = { 'gopls' },
  filetypes = { 'go' },
  capabilities = create_capabilities(),
  on_attach = function(client, bufnr)
    set_lsp_keymaps(bufnr)
    -- Additional Go-specific setup can go here
  end,
})

vim.lsp.config('luals', {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  root_markers = { '.luarc.json', '.luarc.jsonc' },
  capabilities = create_capabilities(),
  on_attach = function(client, bufnr)
    set_lsp_keymaps(bufnr)
    -- Additional Lua-specific setup can go here
  end,
})

-- Configure diagnostics display
vim.diagnostic.config({
  -- Show diagnostics in virtual text (inline)
  virtual_text = {
    enabled = true,
    source = "if_many", -- Show source if multiple LSPs are attached
    prefix = "●", -- Prefix character for virtual text
  },

  -- Show diagnostics in signs column
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "✘",
      [vim.diagnostic.severity.WARN] = "▲",
      [vim.diagnostic.severity.HINT] = "⚑",
      [vim.diagnostic.severity.INFO] = "»",
    },
  },

  -- Update diagnostics while typing (can be resource intensive)
  update_in_insert = false,

  -- Show diagnostics in floating window on cursor hold
  float = {
    focusable = false,
    close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
    border = 'rounded',
    source = 'always',
    prefix = '',
  },

  -- Underline problematic text
  underline = true,

  -- Sort diagnostics by severity
  severity_sort = true,
})

-- Automatically show diagnostics in floating window on cursor hold
vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    local opts = {
      focusable = false,
      close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
      border = 'rounded',
      source = 'always',
      prefix = '',
      scope = 'cursor',
    }
    vim.diagnostic.open_float(nil, opts)
  end
})

local format_on_save_group = vim.api.nvim_create_augroup("FormatOnSave", { clear = true })

vim.api.nvim_create_autocmd("BufWritePre", {
  group = format_on_save_group,
  pattern = "*",
  callback = function()
    -- Check if LSP client supports formatting
    local clients = vim.lsp.get_active_clients({ bufnr = 0 })
    for _, client in pairs(clients) do
      if client.server_capabilities.documentFormattingProvider then
        vim.lsp.buf.format({
          async = false,
          timeout_ms = 2000,
        })
        return
      end
    end
  end,
})
-- Enable the LSP servers
vim.lsp.enable('gopls')
vim.lsp.enable('luals')
