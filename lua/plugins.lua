-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]
return require('packer').startup(function()
  use {
    -- Packer can manage itself
	{'wbthomason/packer.nvim', opt = true},

    -- colorscheme
    -- {'arcticicestudio/nord-vim', opt = true},
	{'shaunsingh/nord.nvim'},
	{'w0ng/vim-hybrid', opt = true},
	'kristijanhusak/vim-hybrid-material',
	'rmehri01/onenord.nvim',
	'EdenEast/nightfox.nvim',

    -- add this line to your .vimrc file
    -- https://raw.githubusercontent.com/mattn/emmet-vim/master/TUTORIAL
	{'mattn/emmet-vim', opt = true},

    -- status line and themes
    -- https://github.com/vim-airline/vim-airline
	'vim-airline/vim-airline',
	'vim-airline/vim-airline-themes',


    -- fuzzy finder
	'nvim-lua/popup.nvim',
	'nvim-lua/plenary.nvim',
    {'nvim-telescope/telescope.nvim', tag = 'nvim-0.6'},

	-- flutter-tools (contains LSP features)
	{
        'akinsho/flutter-tools.nvim',
        requires = {
            'nvim-lua/plenary.nvim',
            'stevearc/dressing.nvim', -- optional for vim.ui.select
        },
    },

    -- LSP
    -- using neovim built-in client
	'neovim/nvim-lspconfig',

    -- floating window navigation
	{'tami5/lspsaga.nvim'},

    -- file tree viewer
	'lambdalisue/fern.vim',
    -- fern font
	'lambdalisue/nerdfont.vim',
	'lambdalisue/fern-renderer-nerdfont.vim',

    -- completion
	'hrsh7th/nvim-cmp',
	'hrsh7th/cmp-nvim-lsp',
	'hrsh7th/cmp-path',
	'hrsh7th/cmp-vsnip',
	'hrsh7th/vim-vsnip',

	-- function signature help
	'ray-x/lsp_signature.nvim',

	-- dart-vim-plugin
    -- 'dart-lang/dart-vim-plugin',

	-- vim-markdown
	'godlygeek/tabular',
	'preservim/vim-markdown',

	-- preview markdown
	'previm/previm',
  }
end)

