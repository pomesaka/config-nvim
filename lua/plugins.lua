-- https://github.com/folke/lazy.nvim

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local dependencies = {
  {
    "neovim/nvim-lspconfig",
    tag = "v0.1.7",
  },
  {
    "nvim-tree/nvim-tree.lua",
    commit = "141c0f97c35f274031294267808ada59bb5fb08e",
    opts = function(_, _)
      return {
        sort = {
          sorter = "case_sensitive",
        },
        view = {
          width = 30,
        },
        renderer = {
          group_empty = true,
        },
        filters = {
          dotfiles = true,
        },
        on_attach = require("keymaps").nvim_tree_setup,
      }
    end,
  },
  { "rmehri01/onenord.nvim" },
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    opts = {},
  },
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  {
    "nvimdev/lspsaga.nvim",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons",
    },
    opts = {},
  },
  {
    "hrsh7th/nvim-cmp",
    commit = "538e37ba87284942c1d76ed38dd497e54e65b891",
    dependencies = {
      'neovim/nvim-lspconfig',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-vsnip',
      'hrsh7th/vim-vsnip',
    },
    opts = function(_, _)
      return require("plugins.cmp").opts
    end,
  },
  {
	  "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
   	opts = function(_, opts)
  		return require("indent-rainbowline").make_opts(opts)
  	end,
  	dependencies = {
  		"TheGLander/indent-rainbowline.nvim",
  	},
  },
}

local setup = function()
  require("lazy").setup(dependencies)

  -- LSP configs
  local lspconfig = require("lspconfig")
  local capabilities = require("plugins.cmp").capabilities

  lspconfig.gopls.setup({
    capabilities = capabilities,
    settings = {
      gopls = {
        analyses = {
          unusedparams = true,
        },
        usePlaceholders = true,
        staticcheck = true,
        gofumpt = true,
      },
    },
  })
  lspconfig.pyright.setup{
    capabilities = capabilities,
  }
  lspconfig.lua_ls.setup{}
end

return {
    setup = setup,
}
