require("plugins")
vim.api.nvim_exec([[
  augroup MyAutoCmd
    autocmd!
    autocmd BufWritePost plugins.lua PackerCompile
  augroup END
]], false)

-- nvim-cmp setup
local cmp = require'cmp'

cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
    end,
  },
  mapping = {
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' }, -- For vsnip users.
  }, {
      { name = 'path' },
  })
})

-- Golang LSP client settings.
--
-- See: https://github.com/golang/tools/blob/master/gopls/doc/vim.md#neovim
require('lspsaga').init_lsp_saga {
  max_preview_lines = 10,
  border_style = "round",
  rename_prompt_populate = false,
}

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('LspKeymap' ,{}),
  callback = function(ev)
    local opts = { buffer = ev.buf, noremap=true, silent=true }
    vim.keymap.set("n", "gh",         "<cmd>lua require'lspsaga.provider'.lsp_finder()<CR>", opts)
    vim.keymap.set("n", "gh",         "<cmd>lua require'lspsaga.provider'.lsp_finder()<CR>", opts)
    vim.keymap.set("n", "<leader>n",  "<cmd>lua require('lspsaga.codeaction').code_action()<CR>", opts)
    vim.keymap.set("v", "<leader>n",  ":<C-U>lua require('lspsaga.codeaction').range_code_action()<CR>", opts)
    vim.keymap.set("n", "K",          "<cmd>lua require('lspsaga.hover').render_hover_doc()<CR>", opts)
    vim.keymap.set("n", "<C-k>",      "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>", opts)
    vim.keymap.set("n", "<C-j>",      "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>", opts)
    vim.keymap.set("n", "gr",         "<cmd>lua require('lspsaga.rename').rename()<CR>", opts)
    vim.keymap.set("n", "gd",         "<cmd>lua require('lspsaga.provider').preview_definition()<CR>", opts)
    vim.keymap.set("n", "<leader>d",  "<cmd>lua require('lspsaga.diagnostic').show_line_diagnostics()<CR>", opts)
    vim.keymap.set("n", "[d",         "<cmd>lua require('lspsaga.diagnostic').navigate('prev')()<CR>", opts)
    vim.keymap.set("n", "]d",         "<cmd>lua require('lspsaga.diagnostic').navigate('next')()<CR>", opts)
    vim.keymap.set('n', 'gD',         "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
  end,
})

require('telescope').setup{}

lspconfig = require("lspconfig")

local on_attach = function(_, bufnr)
  require("lsp_signature").on_attach({
    bind = true, -- This is mandatory, otherwise border config won't get registered.
    handler_opts = {
      border = "rounded"
    }
  }, bufnr)
end

-- Setup capabilities.
-- local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
local capabilities = require('cmp_nvim_lsp').default_capabilities()

lspconfig.gopls.setup {
  cmd = {"gopls", "serve"},
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
        fillstruct = true,
      },
      staticcheck = true,
    },
  },
}

lspconfig.pylsp.setup{
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    pylsp = {
      plugins = {
        pycodestyle = {
          ignore = {'W391'},
          maxLineLength = 100
        }
      }
    }
  }
}

lspconfig.tsserver.setup {
  capabilities = capabilities,
  on_attach = on_attach,
}

require('flutter-tools').setup {
  flutter_lookup_cmd = "asdf where flutter",
  widget_guides = {
    enabled = true,
  },
  closing_tags = {
	  prefix = "<<= ",
	  enabled = true
  },
  lsp = {
	  on_attach = on_attach,
	  capabilities = capabilities,
  },
}

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
-- _G.tab_complete = function()
--   if vim.fn.pumvisible() == 1 then
--     return t "<C-n>"
--   elseif check_back_space() then
--     return t "<Tab>"
--   else
--     return vim.fn['compe#complete']()
--   end
-- end
-- _G.s_tab_complete = function()
--   if vim.fn.pumvisible() == 1 then
--     return t "<C-p>"
--   else
--     return t "<S-Tab>"
--   end
-- end

-- vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
-- vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
-- vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
-- vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})



-- Configuring LSP Diagnostic Display
-- https://github.com/nvim-lua/diagnostic-nvim/issues/73
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    -- This will disable virtual text, like doing:
    -- let g:diagnostic_enable_virtual_text = 0
    virtual_text = false,

    -- This is similar to:
    -- let g:diagnostic_show_sign = 1
    -- To configure sign display,
    --  see: ":help vim.lsp.diagnostic.set_signs()"
    signs = true,

    -- This is similar to:
    -- "let g:diagnostic_insert_delay = 1"
    update_in_insert = false,
  }
)

-- dart.lua
vim.g.dart_style_guide = 2
-- vim.g.dart_format_on_save = 1

-- nord.nvim
vim.g.nord_contrast = true
vim.g.nord_borders = true
vim.g.nord_disable_background = false
vim.g.nord_italic = false

-- previm/previm
vim.g.previm_open_cmd = 'open -a Google\\ Chrome'

-- require('nord').set()

-- onenord.nvim
local onenord = require('onenord')
onenord.setup({
  borders = true, -- Split window borders
  fade_nc = true, -- Fade non-current windows, making them more distinguishable
  styles = {
    comments = "NONE", -- Style that is applied to comments: see `highlight-args` for options
    strings = "NONE", -- Style that is applied to strings: see `highlight-args` for options
    keywords = "NONE", -- Style that is applied to keywords: see `highlight-args` for options
    functions = "NONE", -- Style that is applied to functions: see `highlight-args` for options
    variables = "NONE", -- Style that is applied to variables: see `highlight-args` for options
    diagnostics = "underline", -- Style that is applied to diagnostics: see `highlight-args` for options
  },
  disable = {
    background = false, -- Disable setting the background color
    cursorline = false, -- Disable the cursorline
    eob_lines = true, -- Hide the end-of-buffer lines
  },
  custom_highlights = {}, -- Overwrite default highlight groups
  custom_colors = {}, -- Overwrite default colors
})

-- nightfox.nvim
local nightfox = require('nightfox')
nightfox.setup({
  fox = "nordfox", -- change the colorscheme to use nordfox
  styles = {
    -- comments = "italic", -- change style of comments to be italic
    keywords = "bold", -- change style of keywords to be bold
    functions = "italic,bold" -- styles can be a comma separated list
  },
  inverse = {
    match_paren = true, -- inverse the highlighting of match_parens
  },
  colors = {
    red = "#FF000", -- Override the red color for MAX POWER
    bg_alt = "#000000",
  },
  hlgroups = {
    TSPunctDelimiter = { fg = "${red}" }, -- Override a highlight group with the color red
    LspCodeLens = { bg = "#000000", style = "italic" },
  }
})
-- Load the configuration set above and apply the colorscheme
-- nightfox.load()
