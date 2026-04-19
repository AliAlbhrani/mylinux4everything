-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
    requires = { { 'nvim-lua/plenary.nvim' } }
  }
  use { "catppuccin/nvim", as = "catppuccin" }
  use { "nvim-treesitter/nvim-treesitter",
    requires = "nvim-treesitter/nvim-treesitter-textobjects",
    branch = 'master', run = ":TSUpdate"
  }
  use({
    "stevearc/oil.nvim",
    config = function()
      require("oil").setup()
    end,
  })
  use { 'akinsho/bufferline.nvim', tag = "*", requires = 'nvim-tree/nvim-web-devicons' }
  use {
    "kdheepak/lazygit.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
    },
  }
  use { 'mbbill/undotree' }
  use { "mason-org/mason.nvim" }
  use({
    "L3MON4D3/LuaSnip",
    -- follow latest release.
    tag = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    dependencies = { "rafamadriz/friendly-snippets" },
    -- install jsregexp (optional!:).
    run = "make install_jsregexp"
  })
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'rafamadriz/friendly-snippets'
    }
  }
  use { "rafamadriz/friendly-snippets" }
  use { "Exafunction/codeium.vim" }
  -- use {"gelguy/wilder.nvim"}
  use {
    "folke/noice.nvim",
    requires = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    }
  }
  use {
    'goolord/alpha-nvim',
    requires = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('alpha').setup(require('alpha.themes.dashboard').config)
    end
  }
  use 'lewis6991/gitsigns.nvim'
  use 'APZelos/blamer.nvim'
  use {
    "Zeioth/hot-reload.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    event = "BufEnter",
    config = function()
      local config_dir = vim.fn.stdpath("config") .. "/lua/base/"
      return {
        -- Files to be hot-reloaded when modified.
        reload_files = {
          config_dir .. "1-options.lua",
          config_dir .. "4-mappings.lua"
        },
        -- Things to do after hot-reload trigger.
        reload_callback = function()
          vim.cmd(":silent! colorscheme " .. vim.g.default_colorscheme) -- nvim     colorscheme reload command.
          vim.cmd(":silent! doautocmd ColorScheme")                     -- heirline colorscheme reload event.
        end
      }
    end
  }
  use 'nvim-lualine/lualine.nvim'
  use 'psliwka/vim-smoothie'
  use {
    'nvim-treesitter/nvim-treesitter-context',
    requires = { 'nvim-treesitter/nvim-treesitter' }
  }
  use {
    'kristijanhusak/vim-dadbod-ui',
    requires = {
      { 'tpope/vim-dadbod' },
      { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' } }, -- Optional
    },
    command = {
      'DBUI',
      'DBUIToggle',
      'DBUIAddConnection',
      'DBUIFindBuffer',
    },
    config = function()
      vim.g.db_ui_use_nerd_fonts = 1
    end,
  }
  use {
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup {
        {
          -- Manual mode doesn't automatically change your root directory, so you have
          -- the option to manually do so using `:ProjectRoot` command.
          manual_mode = false,

          -- Methods of detecting the root directory. **"lsp"** uses the native neovim
          -- lsp, while **"pattern"** uses vim-rooter like glob pattern matching. Here
          -- order matters: if one is not detected, the other is used as fallback. You
          -- can also delete or rearangne the detection methods.
          detection_methods = { "lsp", "pattern" },

          -- All the patterns used to detect root dir, when **"pattern"** is in
          -- detection_methods
          patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", "go.mod" },

          -- Table of lsp clients to ignore by name
          -- eg: { "efm", ... }
          ignore_lsp = {},

          -- Don't calculate root dir on specific directories
          -- Ex: { "~/.cargo/*", ... }
          exclude_dirs = {},

          -- Show hidden files in telescope
          show_hidden = true,

          -- When set to false, you will get a message when project.nvim changes your
          -- directory.
          silent_chdir = false,

          -- What scope to change the directory, valid options are
          -- * global (default)
          -- * tab
          -- * win
          scope_chdir = 'global',

          -- Path where project.nvim will store the project history for use in
          -- telescope
          datapath = vim.fn.stdpath("data"),
        }
      }
    end
  }
  use "stevearc/conform.nvim"
end)
