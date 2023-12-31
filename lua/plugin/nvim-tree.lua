return {
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
}
