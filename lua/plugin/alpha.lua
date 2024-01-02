local header = {
  "                                                     ",
  "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
  "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
  "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
  "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
  "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
  "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
  "                                                     ",
}
return {
  'goolord/alpha-nvim',
  dependencies = {
    "nvim-tree/nvim-tree.lua",
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    local status, alpha = pcall(require, "alpha")
    if not status then
      return
    end
    local dashboard = require("alpha.themes.dashboard")
    dashboard.section.header.val = header
    dashboard.section.buttons.val = {
      dashboard.button("e", "  NvimTree", ":NvimTreeToggle <CR>"),
      dashboard.button("n", "  New file", ":ene <BAR> startinsert <CR>"),
      dashboard.button("o", "  Recent file", ":Telescope oldfiles <CR>"),
      dashboard.button("g", "🛠️  Git status", ":Telescope git_status <CR>"),
      dashboard.button("f", "󰥨  Find file", ":Telescope find_files <CR>"),
      dashboard.button("r", "󰱼  Find text", ":Telescope live_grep <CR>"),
      dashboard.button("s", "  Settings", ":e $MYVIMRC | :cd %:p:h | split . | wincmd k | pwd<CR>"),
      dashboard.button("q", "  Quit", ":qa<CR>"),
    }
    local function footer()
      local datetime = os.date(" %Y-%m-%d   %H:%M:%S")
      local version = vim.version()
      local version_info = "   v" .. version.major .. "." .. version.minor .. "." .. version.patch
      return datetime .. "  ⚡" .. version_info
    end
    dashboard.section.footer.val = footer()
    alpha.setup(dashboard.opts)
    vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
  end
}
