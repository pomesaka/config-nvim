return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.5",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    { '<leader>ff', '<CMD>lua require("telescope.builtin").find_files()<CR>' },
    { '<leader>fr', '<CMD>lua require("telescope.builtin").live_grep()<CR>' },
    { '<leader>fg', '<CMD>lua require("telescope.builtin").git_status()<CR>' },
    { '<leader>fb', '<CMD>lua require("telescope.builtin").buffers()<CR>' },
    { '<leader>fh', '<CMD>lua require("telescope.builtin").help_tags()<CR>' },
    { '<leader>fd', '<CMD>lua require("telescope.builtin").diagnostics()<CR>' },
    { '<leader>fp', '<CMD>lua require("telescope.builtin").commands()<CR>' },
    { '<leader>fo', '<CMD>lua require("telescope.builtin").oldfiles({only_cwd=true})<CR>' },
  },
}
