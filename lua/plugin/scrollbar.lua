return {
  'kevinhwang91/nvim-hlslens',
  dependencies = {
    'petertriho/nvim-scrollbar',
    opts = {
      marks = {
        Cursor = {
            text = "<",
            priority = 0,
            color = "#e0af68",
            highlight = "Normal",
        },
        Search = {
            text = { "|", "=" },
            priority = 1,
            color = "#bc791a",
            highlight = "Search",
        },
        Error = {
            text = { "x", "=" },
            priority = 2,
            highlight = "DiagnosticVirtualTextError",
        },
        GitAdd = {
            text = "+",
            priority = 7,
            color = "#73daca",
            highlight = "GitSignsAdd",
        },
        GitChange = {
            text = "*",
            priority = 7,
            color = "#536c9e",
            highlight = "GitSignsChange",
        },
        GitDelete = {
            text = "▁",
            priority = 7,
            color = "#b2555b",
            highlight = "GitSignsDelete",
        },
      },
    },
    dependencies = {
      {
        "lewis6991/gitsigns.nvim",
        config = function(_, opts)
          require("gitsigns").setup(opts)
          require("scrollbar.handlers.gitsigns").setup()
        end
      },
    }
  },
  config = function()
    require("scrollbar.handlers.search").setup({
      override_lens = function() end,
    })
  end,
}
