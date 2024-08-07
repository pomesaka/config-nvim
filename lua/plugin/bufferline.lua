return {
  "akinsho/bufferline.nvim",
  -- version = "*",
  -- TEMPORALY: for nvim 0.10.0 compatibiliy
  branch = 'main',
  dependencies = "nvim-tree/nvim-web-devicons",
  opts = function()
    local highlights = require("nord").bufferline.highlights({
      italic = true,
      bold = true,
      fill = "#181c24"
    })
    return {
      options = {
        separator_style = "slant",
      },
      highlights = highlights,
    }
  end,
}
