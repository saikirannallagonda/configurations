
local jdtls_path = os.getenv("HOME") .. "/.local/share/eclipse/jdt-language-server-1.49.0"

local function on_attach(client, bufnr)

  -- Enable LSP omnifunc completion
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = { noremap=true, silent=true }
  local function map(mode, lhs, rhs)
    vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
  end

  -- Go to definition
  map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
  -- Show hover info
  map('n', 'K',  '<cmd>lua vim.lsp.buf.hover()<CR>')
  -- Show implementation
  map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
  -- Show references
  map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
  -- Rename symbol
  map('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')
  -- Code actions (like quickfixes)
  map('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>')
  -- Show line diagnostics in floating window
  map('n', '<leader>d', '<cmd>lua vim.diagnostic.open_float()<CR>')
  -- Jump to next diagnostic
  map('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
  -- Jump to previous diagnostic
  map('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>')
  -- Format buffer (async)
  map('n', '<leader>f', '<cmd>lua vim.lsp.buf.format { async = true }<CR>')
  
  map('i', '<C-n>', '<Cmd>lua vim.select_next_item()<CR>')  -- optionally for cycling
  map('i', '<C-p>', '<Cmd>lua vim.select_prev_item()<CR>')

  -- jdtls specific mappings (if available)

  if client.name == "jdtls" then
    vim.notify("JDTLS is ready and attached to buffer " .. bufnr, vim.log.levels.INFO)
    -- Organize imports
    map('n', '<leader>oi', '<cmd>lua vim.lsp.buf.execute_command({ command = "java.edit.organizeImports" })<CR>')
    -- Extract variable
    map('v', '<leader>ev', '<Esc><Cmd>lua require("jdtls").extract_variable(true)<CR>')
    -- Extract constant
    map('v', '<leader>ec', '<Esc><Cmd>lua require("jdtls").extract_constant(true)<CR>')
    -- Extract method
    map('v', '<leader>em', '<Esc><Cmd>lua require("jdtls").extract_method(true)<CR>')
  end
  
  -- Expand/Jump snippet (if using snippets)
  map('i', '<C-j>', '<cmd>lua require("luasnip").jump(1)<CR>')
  map('i', '<C-k>', '<cmd>lua require("luasnip").jump(-1)<CR>')

end

-- Hover diagnostics popup
vim.o.updatetime = 300

vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    vim.diagnostic.open_float(nil, { focusable = false })
  end,
})

-- Manual LSP completion popup in insert mode with Ctrl+Space
vim.api.nvim_set_keymap('i', '<C-Space>', '<C-x><C-o>', { noremap = true, silent = true })

-- Java: jdtls
vim.api.nvim_create_autocmd('FileType', {
  pattern = { "java" },
  callback = function()
    vim.lsp.start({
      name = "jdtls",
      cmd = {
        "java",
        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",
        "-noverify",
        "-Xmx1G",
        "-XX:+UseG1GC",
        "-XX:+UseStringDeduplication",
        "--add-modules=ALL-SYSTEM",
        "--add-opens", "java.base/java.util=ALL-UNNAMED",
        "--add-opens", "java.base/java.lang=ALL-UNNAMED",
        "-jar", jdtls_path .. "/plugins/org.eclipse.equinox.launcher_1.7.0.v20250519-0528.jar", -- Replace according to your jar filename
        "-configuration", jdtls_path .. "/config_linux",
        "-data", os.getenv("HOME") .. "/.local/share/eclipse-workspace"
      },
      root_dir = require("vim.fs").dirname(vim.fs.find({".git", "pom.xml", "build.gradle", "mvnw","gradlew"}, {upward=true})[1]),
      on_attach = on_attach,
    })
  end,
})

vim.lsp.handlers["$/progress"] = function(_, result, ctx)
  local client_id = ctx.client_id
  local val = result.value
  if val.kind == "begin" then
    vim.notify("JDTLS: " .. (val.title or "Starting") .. "...", vim.log.levels.INFO)
  elseif val.kind == "report" then
    vim.notify("JDTLS: " .. (val.message or val.title or "") .. " (" .. (val.percentage or 0) .. "%)", vim.log.levels.INFO)
  elseif val.kind == "end" then
    vim.notify("JDTLS: Done.", vim.log.levels.INFO)
  end
end

-- C/C++: clangd setup with root detection
vim.api.nvim_create_autocmd('FileType', {
  pattern = { "c", "cpp", "objc", "objcpp" },
  callback = function()
    local root_files = { "compile_commands.json", "compile_flags.txt", "BUILD.bazel", ".git" }
    local root_dir = vim.fs.dirname(vim.fs.find(root_files, { upward = true })[1]) or vim.fn.getcwd()

    vim.lsp.start({
      name = "clangd",
      cmd = { "clangd", "--background-index", "--clang-tidy", "--cross-file-rename" },
      root_dir = root_dir,
      filetypes = { "c", "cpp", "objc", "objcpp" },
      on_attach = on_attach,
    })
  end,
})

-- React / JavaScript / TypeScript: tsserver setup with root detection
vim.api.nvim_create_autocmd('FileType', {
  pattern = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  callback = function()
    local root_files = { "package.json", "tsconfig.json", "jsconfig.json", ".git" }
    local root_dir = vim.fs.dirname(vim.fs.find(root_files, { upward = true })[1]) or vim.fn.getcwd()

    vim.lsp.start({
      name = "tsserver",
      cmd = { "typescript-language-server", "--stdio" },
      root_dir = root_dir,
      filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
      on_attach = on_attach,
    })
  end,
})

