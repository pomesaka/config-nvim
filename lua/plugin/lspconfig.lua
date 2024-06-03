return {
  "neovim/nvim-lspconfig",
  tag = "v0.1.7",
  keys = {
    { 'gD',    vim.lsp.buf.declaration },
    { 'gd',    vim.lsp.buf.definition },
    { 'gi',    vim.lsp.buf.implementation },
    { '<C-k>', vim.lsp.buf.signature_helps },
    { 'mD',    vim.lsp.buf.type_definition },
  },
  dependencies = {
    {
      "j-hui/fidget.nvim",
      opts = {},
    },
  },
  opts = {
    servers = {
      gopls = {
        settings = {
          gopls = {
            analyses = {
              unusedparams = true,
            },
            usePlaceholders = true,
            staticcheck = true,
            gofumpt = true,
          },
        },
      },
      pyright = {},
      lua_ls = {},
      --      dartls = {},
      rust_analyzer = {},
      tsserver = {},
      biome = {},
      terraformls = {},
    },
    setup = {},
  },
  config = function(_, opts)
    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
      vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = false }
    )
    local servers = opts.servers
    local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
    local capabilities = vim.tbl_deep_extend(
      "force",
      {},
      vim.lsp.protocol.make_client_capabilities(),
      has_cmp and cmp_nvim_lsp.default_capabilities() or {},
      opts.capabilities or {}
    )

    local lspconfig = require('lspconfig')
    for server, settings in pairs(servers) do
      local server_opts = vim.tbl_deep_extend("force", {
        capabilities = vim.deepcopy(capabilities),
      }, settings or {})

      lspconfig[server].setup(server_opts)
    end
    vim.api.nvim_create_autocmd(
      "BufWritePre", {
        callback = function()
          vim.lsp.buf.format({
            async = false,
            -- disable tsserver formatter, use biome
            filter = function(client)
              return client.name ~= "tsserver"
            end
          })
        end
      })
  end,
}
