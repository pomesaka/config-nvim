return {
  "nvimtools/none-ls.nvim",
  opts = function(_, opts)
    local nls = require("null-ls").builtins
    opts.sources = vim.list_extend(opts.sources or {}, {
      -- nls.formatting.biome,
      -- nls.formatting.biome.with({
      --   args = {
      --     'check',
      --     '--apply-unsafe',
      --     '--skip-errors',
      --     '$FILENAME',
      --   },
      -- }),
    })
  end,
}
