return {
  cmd = { "html-ls", "--stdio" },
  filetypes = { "html" },
  root_dir = require("lspconfig.util").root_pattern(".git", "index.html"),
}

