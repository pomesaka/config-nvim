return {
  "nvimdev/lspsaga.nvim",
  -- broken with nvim v0.10.0: "e646183662b7e9b1f3b9d9616116a6a8167e57ff",
  -- commit = "4e2b91c",
  commit = "ad61778283f26a9fa2c5a8d2f0aca52ba49f32f3",
  -- branch = "main",
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
      enable = true,
      sign = false,
      debounce = 40,
      virtual_text = true,
      enable_in_insert = true,
    },
    diagnostic = {
      diagnostic_only_current = true,
    },
  },
  keys = {
    { '[d',    "<cmd>Lspsaga diagnostic_jump_prev<CR>" },
    { ']d',    "<cmd>Lspsaga diagnostic_jump_next<CR>" },
    { 'gr',    "<cmd>Lspsaga finder<CR>" },
    { 'K',     "<cmd>Lspsaga hover_doc<CR>" },
    { '<C-r>', "<cmd>Lspsaga rename<CR>" },
    { '<C-n>', "<cmd>Lspsaga code_action<CR>",         mode = { 'n', 'v' } },
    { '<C-o>', "<cmd>Lspsaga outline<CR>" },
  },
}
