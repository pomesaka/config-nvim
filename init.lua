" ===== lua script ======
require("options").setup()
require("plugins").setup()
require("keymaps").setup()
require("autocmds").setup()

" ===== theme =====
vim.cmd "colorscheme onenord"
