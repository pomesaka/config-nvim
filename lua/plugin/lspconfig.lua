return {
  "neovim/nvim-lspconfig",
  tag = "v0.1.7",
  keys = {
    {'gD', vim.lsp.buf.declaration},
    {'gd', vim.lsp.buf.definition},
    {'gi', vim.lsp.buf.implementation},
    {'<C-k>', vim.lsp.buf.signature_helps},
    {'mD', vim.lsp.buf.type_definition},
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
    },
    setup = {},
  },
  config = function(_, opts)
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
  end,
}
