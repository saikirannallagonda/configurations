return {
  cmd = { "json-lsp", "--stdio" },
  filetypes = { "json", "jsonc" },
  root_dir = require("lspconfig.util").root_pattern(".git", "package.json"),
  settings = {
    json = {
      validate = { enable = true },
      -- Optionally add schemas or other settings here
      -- schemas = require('schemastore').json.schemas(),
      -- schemaStore = { enable = true, url = "..." },
    }
  }
}

