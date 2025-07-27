return {
  cmd = { "css-ls", "--stdio" },
  filetypes = { "css", "scss", "less" },
  root_dir = require("lspconfig.util").root_pattern(".git", "package.json"),
}

