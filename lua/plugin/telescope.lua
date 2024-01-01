return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.5",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    {'<leader>ff', '<CMD>Telescope find_files<CR>'},
    {'<leader>fr', '<CMD>Telescope live_grep<CR>'},
    {'<leader>fg', '<CMD>Telescope git_status<CR>'},
    {'<leader>fb', '<CMD>Telescope buffers<CR>'},
    {'<leader>fh', '<CMD>Telescope help_tags<CR>'},
    {'<leader>fd', '<CMD>Telescope diagnostics<CR>'},
    {'<leader>fp', '<CMD>Telescope commands<CR>'},
  },
}
