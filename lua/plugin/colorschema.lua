return {
  {
    "rmehri01/onenord.nvim",
    lazy = false,
    enabled = true,
    config = function()
      vim.cmd[[colorscheme onenord]]
    end,
  },
  {
    "EdenEast/nightfox.nvim",
    lazy = false,
    enabled = false,
    config = function()
      -- vim.cmd[[colorscheme nightfox]]
      -- vim.cmd[[colorscheme nordfox]]
      -- vim.cmd[[colorscheme terafox]]
      vim.cmd[[colorscheme carbonfox]]
    end,
  },
  {
    'nordtheme/vim',
    lazy = false,
    enabled = false,
    priority = 1000,
    config = function()
      vim.cmd[[colorscheme nord]]
      -- Example config in lua
      vim.g.nord_contrast = true
      vim.g.nord_borders = false
      vim.g.nord_italic = false
      vim.g.nord_uniform_diff_background = false
      vim.g.nord_bold = false
    end,
  },
}
