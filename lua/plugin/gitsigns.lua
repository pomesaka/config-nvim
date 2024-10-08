return {
  "lewis6991/gitsigns.nvim",
  commit = "d195f0c",
  opts = {
    signcolumn = true,
    signs = {
      add          = { text = '+' },
      change       = { text = '*' },
      delete       = { text = '_' },
      changedelete = { text = '~' },
      untracked    = { text = '|' },
    },
  },
  keys = {
    -- Navigation
    { ']g', '<cmd>Gitsigns next_hunk<CR>' },
    { '[g', '<cmd>Gitsigns prev_hunk<CR>' },

    -- Actions
    -- {'<leader>ga', '<cmd>Gitsigns stage_hunk<CR>', mode = {'n', 'v'}},
    -- {'<leader>gr', '<cmd>Gitsigns reset_hunk<CR>', mode = {'n', 'v'}},
    -- {'<leader>gA', '<cmd>Gitsigns stage_buffer<CR>'},
    -- {'<leader>gu', '<cmd>Gitsigns undo_stage_hunk<CR>'},
    -- {'<leader>gR', '<cmd>Gitsigns reset_buffer<CR>'},
    { 'gp', '<cmd>Gitsigns preview_hunk<CR>' },
    { 'gb', '<cmd>lua require"gitsigns".blame_line{full=true}<CR>' },
    { 'gs', '<cmd>Gitsigns diffthis<CR>' },
    { 'gS', '<cmd>lua require"gitsigns".diffthis("~")<CR>' },
  },
}
