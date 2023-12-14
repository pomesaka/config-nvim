local opts = { noremap = true, silent = true }
local keymap = vim.keymap

local setup = function(bufnr)
  local nvim_tree_api = require("nvim-tree.api")
  keymap.set("n", "<C-e>", nvim_tree_api.tree.toggle, opts)
  -- pain
  keymap.set("n", "sj", "<C-w>j", opts)
  keymap.set("n", "sk", "<C-w>k", opts)
  keymap.set("n", "sl", "<C-w>l", opts)
  keymap.set("n", "sh", "<C-w>h", opts)
  keymap.set("n", "sJ", "<C-w>J", opts)
  keymap.set("n", "sK", "<C-w>K", opts)
  keymap.set("n", "sL", "<C-w>L", opts)
  keymap.set("n", "sH", "<C-w>H", opts)

  -- buffer
  keymap.set("n", "fh", ":bprev<CR>", opts)
  keymap.set("n", "fl", ":bnext<CR>", opts)
  keymap.set("n", "fH", ":bfirst<CR>", opts)
  keymap.set("n", "fL", ":blast<CR>", opts)
  keymap.set("n", "fd", ":bdelete<CR>", opts)

  -- tab
  keymap.set("n", "th", "gt", opts)
  keymap.set("n", "tl", "gT", opts)
  keymap.set("n", "tn", ":<C-u>tabnew<CR>", opts)

  -- telescope.nvim
  local telescope = require('telescope.builtin')
  keymap.set('n', '<leader>ff', telescope.find_files, {})
  keymap.set('n', '<leader>fg', telescope.live_grep, {})
  keymap.set('n', '<leader>fb', telescope.buffers, {})
  keymap.set('n', '<leader>fh', telescope.help_tags, {})

  -- diagnostic
  keymap.set('n', '[d', vim.diagnostic.goto_prev)
  keymap.set('n', ']d', vim.diagnostic.goto_next)
  keymap.set('n', '<space>q', vim.diagnostic.setloclist)
end

local lsp_setup = function(ev)
  -- Buffer local mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local opts = { buffer = ev.buf }
  keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
  keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
  keymap.set('n', 'gr', vim.lsp.buf.references, opts)
  keymap.set('n', 'gf', "<cmd>Lspsaga finder<CR>", opts)
  keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  -- keymap.set('n', 'K', "<cmd>Lspsaga hover_doc<CR>", opts)
  keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
  keymap.set('n', '<C-r>', vim.lsp.buf.rename, opts)
  keymap.set('n', 'mD', vim.lsp.buf.type_definition, opts)
  keymap.set({ 'n', 'v' }, '<space>n', vim.lsp.buf.code_action, opts)
end

local nvim_tree_setup = function(bufnr)
  local nvim_tree_api = require("nvim-tree.api")
  -- default mappings
  nvim_tree_api.config.mappings.default_on_attach(bufnr)
  -- remove a default
  keymap.del('n', 's', { buffer = bufnr })
  keymap.del('n', '<C-e>', { buffer = bufnr })
  -- custom mappings
  -- NOTE: could note override default mapping unless remove the mapping
  keymap.set('n', '<C-e>', nvim_tree_api.tree.toggle, opts)
  keymap.set('n', '?',     nvim_tree_api.tree.toggle_help, opts)
end

return {
    setup = setup,
    lsp_setup = lsp_setup,
    nvim_tree_setup = nvim_tree_setup,
}
