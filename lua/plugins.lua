-- https://github.com/folke/lazy.nvim

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local setup = function()
  require("lazy").setup({
    { "rmehri01/onenord.nvim" },
    require("plugins.bufferline"),
    require("plugins.indent-blankline"),
    require("plugins.lspconfig"),
    require("plugins.nvim-tree"),
    require("plugins.telescope"),
    require("plugins.lspsaga"),
    require("plugins.cmp"),
  })
end

return {
    setup = setup,
}
