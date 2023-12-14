local globals = {
    mapleader = " ",

    -- https://github.com/nvim-tree/nvim-tree.lua?tab=readme-ov-file#setup
    loaded_netrw = 1,
    loaded_netrwPlugin = 1,
}

local options = {
    autoindent = true,
    backup = false,
    clipboard = "unnamed",
    cursorline = true,
    cursorcolumn = true,
    expandtab = true,
    foldenable = false,
    hls = true,
    hidden = true,
    langmenu = "utf-8",
    number = true,
    mouse = "a",
    smartindent = true,
    shiftwidth = 0,
    showmatch = true,
    splitright = true,
    tabstop = 4,
    --undofile = true,
    --undodir = "$HOME/.nvim/undo",

    -- https://github.com/nvim-tree/nvim-tree.lua?tab=readme-ov-file#setup
    termguicolors = true,
}

local setup = function()
  vim.opt.shortmess:append("c")

  for k, v in pairs(globals) do
      vim.g[k] = v
  end

  for k, v in pairs(options) do
      vim.opt[k] = v
  end
end

return {
  setup = setup,
}
