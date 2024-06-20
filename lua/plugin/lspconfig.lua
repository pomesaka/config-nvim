local function file_exists(path)
  local file = io.open(path, "r")
  if file then
    file:close()
    return true
  else
    return false
  end
end

-- get project root directory (find .git directory)
local function project_root_dir(dir)
  local git_dir = dir .. '/.git'
  if file_exists(git_dir) then
    -- print("found project_root: ", dir)
    return dir
  else
    local parent_dir = vim.fn.fnamemodify(dir, ":h")
    if parent_dir == dir then
      return nil -- no root dir
    else
      return project_root_dir(parent_dir)
    end
  end
end

local project_root = project_root_dir(vim.loop.cwd())

-- sqls settings
local function sqlc_config()
  if project_root then
    local config_file = project_root .. '/.sqls.yaml'
    if file_exists(config_file) then
      -- print("use sqls config: ", config_file)
      return { '-config', config_file }
    end
  end
  return nil
end

return {
  "neovim/nvim-lspconfig",
  tag = "v0.1.8",
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
      -- https://github.com/rust-lang/rust-analyzer/releases
      rust_analyzer = {},
      tsserver = {},
      biome = {},
      -- https://github.com/tailwindlabs/tailwindcss-intellisense
      tailwindcss = {},
      -- https://releases.hashicorp.com/terraform-ls/0.33.2/terraform-ls_0.33.2_darwin_arm64.zip
      terraformls = {},
      -- https://github.com/sqls-server/sqls-server
      sqls = {
        cmd = vim.list_extend({ "sqls" }, sqlc_config() or {}),
        on_attach = function(client, bufnr)
          require('sqls').on_attach(client, bufnr)
          -- there is crazy formatting bug
          --
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
        end,
      },
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
      {
        textDocument = {
          formatting = { dynamicRegistration = true },
          rangeFormatting = { dynamicRegistration = true },
          onTypeFormatting = { dynamicRegistration = true },
        },
      },
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
