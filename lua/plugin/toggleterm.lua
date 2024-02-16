return {
  'akinsho/toggleterm.nvim',
  tag = "v2.9.0",
  opts = {
    size = 40,
    direction = 'horizontal',
  },
  keys = {
    { '<C-f>', '<cmd>ToggleTerm<CR>', mode = { 't', 'i', 'n' } },
    { '<C-[>', '<C-\\><C-n>',         mode = 't' },
    { '<Esc>', '<C-\\><C-n>',         mode = 't' },
  },
}
