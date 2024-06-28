local onenord = {
  "rmehri01/onenord.nvim",
  lazy = false,
  config = function()
    vim.cmd [[colorscheme onenord]]
  end,
}

local nightfox = {
  "EdenEast/nightfox.nvim",
  lazy = false,
  config = function()
    vim.cmd [[colorscheme nightfox]]
    -- vim.cmd [[colorscheme nordfox]]
    -- vim.cmd [[colorscheme terafox]]
    -- vim.cmd [[colorscheme carbonfox]]
  end,
}

local nordtheme = {
  'nordtheme/vim',
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd [[colorscheme nord]]
    -- Example config in lua
    vim.g.nord_contrast = true
    vim.g.nord_borders = false
    vim.g.nord_italic = false
    vim.g.nord_uniform_diff_background = false
    vim.g.nord_bold = false
  end,
}

return nightfox
