local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local setup = function()
  autocmd("BufWritePre", {
    pattern = "*",
    command = ":%s/\\s\\+$//e",
  })

  autocmd("FileType", {
    pattern = { "lua", "dart", "yaml", "ts", "tsx", "typescriptreact" },
    command = "setlocal shiftwidth=2 tabstop=2",
  })

  -- https://github.com/golang/tools/blob/master/gopls/doc/vim.md#neovim-imports
  autocmd("BufWritePre", {
    pattern = "*.go",
    callback = function()
      local params = vim.lsp.util.make_range_params()
      params.context = { only = { "source.organizeImports" } }
      local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
      for cid, res in pairs(result or {}) do
        for _, r in pairs(res.result or {}) do
          if r.edit then
            local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
            vim.lsp.util.apply_workspace_edit(r.edit, enc)
          end
        end
      end
    end
  })
end

return {
  setup = setup,
}
