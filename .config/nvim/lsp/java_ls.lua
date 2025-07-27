
-- ~/.config/nvim/lsp/java_ls.lua

local util = require("lspconfig.util")
local home = vim.env.HOME
local mason_jdtls = vim.fn.stdpath("data") .. "/mason/packages/jdtls"
local launcher_jar = vim.fn.glob(mason_jdtls .. "/plugins/org.eclipse.equinox.launcher_*.jar")
local config_os = "linux" -- Change if not on Linux
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = home .. "/.local/share/eclipse/" .. project_name

return {
  cmd = {
    "java",
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-Xmx1g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens", "java.base/java.util=ALL-UNNAMED",
    "--add-opens", "java.base/java.lang=ALL-UNNAMED",
    "-jar", launcher_jar,
    "-configuration", mason_jdtls .. "/config_" .. config_os,
    "-data", workspace_dir,
  },
  filetypes = { "java" },
  root_dir = util.root_pattern(".git", "mvnw", "gradlew", "pom.xml", "build.gradle"),
  settings = {
    java = {
      -- Enable signature help
      signatureHelp = { enabled = true },
      -- Use the fernflower decompiler
      contentProvider = { preferred = "fernflower" },
      completion = {
        favoriteStaticMembers = {},
        filteredTypes = {},
      },
      sources = {
        organizeImports = {
          starThreshold = 9999,
          staticStarThreshold = 9999,
        },
      },
      codeGeneration = {
        toString = {
          template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}"
        },
        useBlocks = true,
      },
      configuration = {
        runtimes = {
          {
            name = "JavaSE-17",
            path = "/usr/lib/jvm/java-17-openjdk/",
            default = true,
          },
        },
      },
    },
  },
  single_file_support = true,
  init_options = {
    bundles = {},
  },
}

