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

  -- diagnostic
  -- keymap.set('n', '[d', vim.diagnostic.goto_prev)
  -- keymap.set('n', ']d', vim.diagnostic.goto_next)
  keymap.set('n', '<space>q', vim.diagnostic.setloclist)
end

return {
    setup = setup,
}
