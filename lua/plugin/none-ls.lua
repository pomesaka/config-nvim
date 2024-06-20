return {
  "nvimtools/none-ls.nvim",
  opts = function(_, opts)
    local nls = require("null-ls").builtins
    opts.sources = vim.list_extend(opts.sources or {}, {
      nls.formatting.biome.with({
        only_local = "node_modules/.bin",
        args = {
          'check',
          '--write',
          -- '--unsafe',
          '--stdin-file-path',
          '$FILENAME',
        },
        cwd = function(params)
          local t = vim.fn.fnamemodify(params.bufname, ":p:h")
          print(t)
          return t
        end,
      }),
    })
  end,
}
