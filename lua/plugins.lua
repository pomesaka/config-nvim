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
    keys = {
      {'gD', vim.lsp.buf.declaration},
      {'gd', vim.lsp.buf.definition},
      {'gi', vim.lsp.buf.implementation},
      {'<C-k>', vim.lsp.buf.signature_helps},
      {'mD', vim.lsp.buf.type_definition},
    },
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
        on_attach = function(bufnr)
          local opts = { noremap = true, silent = true }
          local nvim_tree_api = require("nvim-tree.api")
          -- default mappings
          nvim_tree_api.config.mappings.default_on_attach(bufnr)
          -- remove a default
          vim.keymap.del('n', 's', { buffer = bufnr })
          vim.keymap.del('n', '<C-e>', { buffer = bufnr })
          -- custom mappings
          -- NOTE: could note override default mapping unless remove the mapping
          vim.keymap.set('n', '<C-e>', nvim_tree_api.tree.toggle, opts)
          vim.keymap.set('n', '?',     nvim_tree_api.tree.toggle_help, opts)
        end
      }
    end,
    keys = {
      {"<C-e>", "<cmd>NvimTreeToggle<CR>"},
    },
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
    keys = {
      {'<leader>ff', '<CMD>Telescope find_files<CR>'},
      {'<leader>fg', '<CMD>Telescope live_grep<CR>'},
      {'<leader>fb', '<CMD>Telescope buffers<CR>'},
      {'<leader>fh', '<CMD>Telescope help_tags<CR>'},
    },
  },
  {
    "nvimdev/lspsaga.nvim",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons",
    },
    opts = {
      outline = {
        win_width = 50,
        close_after_jump = true,
      },
      lightbulb = {
        sign = false,
        virtual_text = true,
        enable_in_insert = true,
      },
    },
    keys = {
      {'[d', "<cmd>Lspsaga diagnostic_jump_prev<CR>"},
      {']d', "<cmd>Lspsaga diagnostic_jump_next<CR>"},
      {'gr', "<cmd>Lspsaga finder<CR>"},
      {'K', "<cmd>Lspsaga hover_doc<CR>"},
      {'<C-r>', "<cmd>Lspsaga rename<CR>"},
      {'<C-n>', "<cmd>Lspsaga code_action<CR>", mode = { 'n', 'v' } },
      {'<C-o>', "<cmd>Lspsaga outline<CR>"},
    },
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
      {
        'hrsh7th/vim-vsnip',
        keys = {
          {
            '<Tab>',
            function()
              return vim.fn['vsnip#jumpable'](1) == 1 and '<Plug>(vsnip-jump-next)' or '<Tab>'
            end,
            mode = {'i', 's'}, expr = true, noremap = false
          },
          {
            '<S-Tab>',
            function()
              return vim.fn['vsnip#jumpable'](-1) == 1 and '<Plug>(vsnip-jump-prev)' or '<S-Tab>'
            end,
            mode = {'i', 's'}, expr = true, noremap = false
          },
        },
      },
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
