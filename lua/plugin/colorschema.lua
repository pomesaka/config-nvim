-- These plugins should setup before "lukas-reineke/indent-blankline.nvim"

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
  config = function()
    vim.g.nord_contrast = true
    vim.g.nord_borders = false
    vim.g.nord_italic = false
    vim.g.nord_uniform_diff_background = false
    vim.g.nord_bold = false
    vim.cmd [[colorscheme nord]]
  end,
}

local nord = {
  'shaunsingh/nord.nvim',
  lazy = false,
  config = function()
    require('nord').set()

    vim.g.nord_contrast                  = false
    vim.g.nord_borders                   = false
    vim.g.nord_disable_background        = false
    vim.g.nord_cursorline_transparent    = false
    vim.g.nord_enable_sidebar_background = true
    vim.g.nord_italic                    = false
    vim.g.nord_uniform_diff_background   = true
    vim.g.nord_bold                      = false

    -- vim.cmd [[highlight Normal guibg=#06252ER]]
    -- vim.cmd [[highlight NormalNC guibg=#062B36]]
    -- vim.cmd [[highlight NvimTreeNormal guibg=#062B36]]
    -- vim.cmd [[highlight LineNr guibg=#06252ER]]
  end,
}

return nord
