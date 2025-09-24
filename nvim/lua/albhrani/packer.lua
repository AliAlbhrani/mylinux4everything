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
end)
