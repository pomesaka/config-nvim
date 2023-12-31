return {
  "NeogitOrg/neogit",
  commit = "a15419e",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "sindrets/diffview.nvim",
    "nvim-telescope/telescope.nvim",
  },
  opts = {
    integrations = {
      telescope = true,
      diffview = true,
    },
  },
  keys = {
    {'<C-g>', '<cmd>Neogit<CR>'},
  },
}
