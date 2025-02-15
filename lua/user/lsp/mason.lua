local status_ok, mason = pcall(require, "mason")
if not status_ok then
  return
end

local status_ok_1, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status_ok_1 then
  return
end

local servers = {
  "cssls",
  "cssmodules_ls",
  "tailwindcss",
  "lua_ls",
  "html",
  "emmet_ls",
  "jdtls",
  "jsonls",
  "solc",
  "tflint",
  "ts_ls",
  "pyright",
  "yamlls",
  "bashls",
  "clangd",
  "rust_analyzer",
  "taplo",
  "intelephense",
  "eslint",
  -- "phpactor"
  "gopls"
}

local settings = {
  ui = {
    border = "rounded",
    icons = {
      package_installed = "◍",
      package_pending = "◍",
      package_uninstalled = "◍",
    },
  },
  log_level = vim.log.levels.INFO,
  max_concurrent_installers = 4,
}

mason.setup(settings)
mason_lspconfig.setup {
  ensure_installed = servers,
  automatic_installation = true,
}

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
  return
end

local opts = {}

for _, server in pairs(servers) do
  opts = {
    on_attach = require("user.lsp.handlers").on_attach,
    capabilities = require("user.lsp.handlers").capabilities,
  }

  server = vim.split(server, "@")[1]

  if server == "jsonls" then
    local jsonls_opts = require("user.lsp.settings.jsonls")
    opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
  end

  if server == "gopls" then
    local gopls_opts = require("user.lsp.settings.gopls")
    opts = vim.tbl_deep_extend("force", gopls_opts, opts)
  end

  if server == "tailwindcss" then
    local tailwindcss = require("user.lsp.settings.tailwindcss")
    opts = vim.tbl_deep_extend("force", tailwindcss, opts)
  end

  if server == "eslint" then
    local eslint = require("user.lsp.settings.eslint")
    opts = vim.tbl_deep_extend("force", eslint, opts)
  end

  if server == "html" then
    local html = require("user.lsp.settings.html")
    opts = vim.tbl_deep_extend("force", html, opts)
  end

  if server == "lua_ls" then
    local sumneko_opts = require "user.lsp.settings.sumneko_lua"
    opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
  end
  if server == "intelephense" then
    local intelephense_opts = require("user.lsp.settings.intelephense")
    opts = vim.tbl_deep_extend("force", intelephense_opts, opts)
  end

  -- if server == "phpactor" then
  --   local phpactor_opts = require("user.lsp.settings.phpactor")
  --   opts = vim.tbl_deep_extend("force", phpactor_opts, opts)
  -- end

  if server == "ts_ls" then
    local tsserver_opts = require "user.lsp.settings.tsserver"
    opts = vim.tbl_deep_extend("force", tsserver_opts, opts)
  end

  if server == "pyright" then
    local pyright_opts = require("user.lsp.settings.pyright")
    opts = vim.tbl_deep_extend("force", pyright_opts, opts)
  end

  if server == "emmet_ls" then
    local emmet_ls_opts = require("user.lsp.settings.emmet_ls")
    opts = vim.tbl_deep_extend("force", emmet_ls_opts, opts)
  end

  if server == "jdtls" then
    local jdts_opts = require("user.lsp.settings.jdtls")
    -- opts = vim.tbl_deep_extend("force", jdts_opts, opts)
    goto continue
  end

  if server == "rust_analyzer" then
    local _ = require("user.lsp.settings.rust")
    -- require("rust-tools").setup(rust_opts)
    goto continue
  end

  if server == "yamlls" then
    local yamlls_opts = require "user.lsp.settings.yamlls"
    opts = vim.tbl_deep_extend("force", yamlls_opts, opts)
  end
  lspconfig[server].setup(opts)
  ::continue::
end

-- TODO: add something to installer later
-- require("lspconfig").motoko.setup {}
