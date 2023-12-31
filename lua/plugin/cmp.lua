
return {
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
    'onsails/lspkind.nvim',
  },
  opts = function()
    local cmp = require("cmp")
    local lspkind = require("lspkind")
    return {
      snippet = {
        expand = function(args)
          vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        end,
      },
      window = {
        -- completion = cmp.config.window.bordered(),
        -- documentation = cmp.config.window.bordered(),
      },
      experimental = {
        ghost_text = true,
      },
      mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      }),
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'vsnip' }, -- For vsnip users.
      }, {
        { name = 'buffer' },
        { name = 'path' },
      }),
	    formatting = {
	    	format = lspkind.cmp_format({
	    		mode = "symbol",
	    		maxwidth = 50,
	    		ellipsis_char = "...",
	    	}),
	    },
    }
  end,
}
