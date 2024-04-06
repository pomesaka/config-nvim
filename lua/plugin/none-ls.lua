return {
  "nvimtools/none-ls.nvim",
  opts = function(_, opts)
    local nls = require("null-ls").builtins
    opts.sources = vim.list_extend(opts.sources or {}, {
      nls.formatting.biome.with({
        args = {
          'check',
          '--apply-unsafe',
          '--formatter-enabled=true',
          '--organize-imports-enabled=true',
          '--skip-errors',
          '$FILENAME',
        },
      }),
    })
  end,
}
