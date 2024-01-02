return {
  "nvimdev/lspsaga.nvim",
  commit = "4e2b91c",
  event = "LspAttach",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
    "neovim/nvim-lspconfig",
  },
  opts = {
    outline = {
      win_width = 50,
      close_after_jump = true,
    },
    lightbulb = {
      sign = false,
      virtual_text = true,
      enable_in_insert = true,
    },
    diagnostic = {
      diagnostic_only_current = true,
    },
  },
  keys = {
    {'[d', "<cmd>Lspsaga diagnostic_jump_prev<CR>"},
    {']d', "<cmd>Lspsaga diagnostic_jump_next<CR>"},
    {'gr', "<cmd>Lspsaga finder<CR>"},
    {'K', "<cmd>Lspsaga hover_doc<CR>"},
    {'<C-r>', "<cmd>Lspsaga rename<CR>"},
    {'<C-n>', "<cmd>Lspsaga code_action<CR>", mode = { 'n', 'v' } },
    {'<C-o>', "<cmd>Lspsaga outline<CR>"},
  },
}
