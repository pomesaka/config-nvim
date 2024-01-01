return {
  'sindrets/diffview.nvim',
  opts = function ()
    local actions = require("diffview.actions")
    return {
      keymaps = {
        view = {
          { "n", "<leader>gg", "<cmd>DiffviewClose<CR>",    { desc = "Close diffview files" } },
        },
        file_panel = {
          { "n", "s",          nil },
          { "n", "S",          nil },
          { "n", "a",          actions.toggle_stage_entry, { desc = "Stage / unstage the selected entry" } },
          { "n", "A",          actions.stage_all,          { desc = "Stage all entries" } },
          { "n", "<leader>gg", "<cmd>DiffviewClose<CR>",    { desc = "Close diffview files" } },
        },
      },
    }
  end,
  keys = {
    { "<leader>gg", "<cmd>DiffviewOpen<CR>",   { desc = "Open diffview" } },
  },
}
