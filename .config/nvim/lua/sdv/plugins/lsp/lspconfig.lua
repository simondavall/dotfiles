return {
  "neovim/nvim-lspconfig",
  lazy = "false",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
    { "folke/neodev.nvim", opts = {} },
    { "b0o/schemastore.nvim" },
  },
  config = function()
    --local lspconfig = require("lspconfig")
    --local mason_lspconfig = require("mason-lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")
    local keymap = vim.keymap -- for conciseness
    -- used to enable autocompletion (assign to every lsp server config)
    local capabilities = cmp_nvim_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities())

    vim.lsp.config("lua_ls", {
      capabilities = capabilities,
      cmd = { "lua-language-server" },
      filetypes = { "lua" },
      root_markers = {
        ".luarc.json",
        ".luarc.jsonc",
        ".luacheckrc",
        ".stylua.toml",
        "stylua.toml",
        "selene.toml",
        "selene.yml",
        ".git",
      },
      settings = {
        Lua = {
          -- make the language server recognize "vim" global
          diagnostics = {
            globals = { "vim", "globals", "max_line_length", "ignore" },
          },
          completion = {
            callSnippet = "Replace",
          },
          workspace = {
            library = vim.api.nvim_get_runtime_file("", true),
            checkThirdParty = false,
          },
        },
      },
    })

    vim.lsp.config("gopls", {
      capabilities = capabilities,
      cmd = { "gopls" },
      filetypes = { "go", "gomod", "gowork", "gotmpl" },
      settings = {
        gopls = {
          completeUnimported = true,
          usePlaceholders = true,
          staticcheck = true,
          analyses = {
            unusedparams = true,
            nilness = true,
            unusedwrite = true,
          },
          hints = {
            assignVariableTypes = true,
            parameterNames = true,
            compositeLiteralFields = true,
          },
        },
      },
    })

    vim.lsp.config("clangd", {
      capabilities = capabilities,
      -- cmd = { "clangd", "--background-index" },
      cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy",
        "--header-insertion=iwyu",
        "--completion-style=detailed",
        "--function-arg-placeholders=true",
        "--fallback-style=llvm",
        "--log=error", -- 'info', ' verbose', 'public'
        "--query-driver=/usr/bin/**/clang-*,/bin/clang,/bin/clang++,/usr/bin/gcc,/usr/bin/g++",
      },
      root_markers = { "compile_commands.json", "compile_flags.txt", "makefile", ".git" },
      filetypes = { "c", "cpp", "cuda", "objc", "objcpp" },
      init_options = {
        usePlaceholders = true,
        completeUnimported = true,
        clangdFileStatus = true,
      },
      on_attach = function(client, _)
        client.server_capabilities.signatureHelpProvider = false
        -- on_attach(client, bufnr)
      end,
      settings = {
        ["clangd"] = {
          fallbackFlags = { "--std=c11" }, -- or '--std=c23' for latest C standard
          compilationDatabasePath = "build", -- if using a build directory
        },
      },
    })

    vim.lsp.config("html-ls", {
      capabilities = capabilities,
      cmd = { "vscode-html-language-server", "--stdio" },
      filetypes = {
        "html",
        "blade",
        "javascriptreact",
        "typescriptreact",
        "svelte",
      },
      on_attach = function(client, bufnr)
        local name = vim.api.nvim_buf_get_name(bufnr)
        if name:match("__virtual") then
          client.stop()
        end
      end,
      root_markers = { "index.html", ".git" },
      init_options = { provideFormatter = true },
    })

    vim.lsp.config("ruff", {
      init_options = {
        settings = {
          logLevel = "error",
          -- Disable Ruff's linting if using pyright for diagnostics
          lint = { enable = false },
          -- Optional: customize formatting
          format = { lineLength = 88 },
        },
      },
      -- Disable hover in favor of pyright
      on_attach = function(client, _)
        client.server_capabilities.hoverProvider = false
      end,
    })

    vim.lsp.config("pyright", {
      settings = {
        pyright = {
          disableOrganizeImports = true, -- Let Ruff handle imports
        },
        python = {
          analysis = {
            typeCheckingMode = "basic",
            diagnosticMode = "openFilesOnly",
          },
        },
      },
    })

    vim.lsp.config("jsonls", {
      capabilities = capabilities,
      filetypes = { "json" },
      settings = {
        json = {
          format = { enable = true },
          validate = { enable = true },
        },
      },
      -- Optional: Lazy-load schemastore for JSON schema validation
      before_init = function(_, new_config)
        new_config.settings.json.schemas = new_config.settings.json.schemas or {}
        vim.list_extend(new_config.settings.json.schemas, require("schemastore").json.schemas())
      end,
    })

    vim.lsp.config("tsserver", {
      cmd = { "typescript-language-server", "--stdio" },
      filetypes = {
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescriptreact",
        "typescript.tsx",
      },
      root_dir = vim.fs.root(0, { "package.json", "tsconfig.json", "jsconfig.json", ".git" }),
      -- Optional: pass capabilities and on_attach if defined
      capabilities = capabilities,
      -- on_attach = on_attach,
      init_options = {
        preferences = {
          disableSuggestions = false,
        },
      },
      handlers = {
        ["textDocument/publishDiagnostics"] = function(_, result, ctx)
          if result.diagnostics then
            result.diagnostics = vim.tbl_filter(function(diag)
              return diag.code ~= 80001
            end, result.diagnostics)
          end
          vim.lsp.diagnostic.on_publish_diagnostics(_, result, ctx)
        end,
      },
    })

    vim.lsp.enable({
      "gopls",
      "lua_ls",
      "clangd",
      "html-ls",
      "jsonls",
      "ruff",
      "pyright",
      "tsserver",
    })

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        local opts = { buffer = ev.buf, silent = true }
        local telescope = require("telescope.builtin")

        opts.desc = "Displays all references (usages) of a symbol across the current project/workspace."
        keymap.set("n", "gR", telescope.lsp_references, opts)

        opts.desc = "Go to declaration"
        keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

        opts.desc = "Show the definition(s) of the word under the cursor"
        keymap.set("n", "gd", telescope.lsp_definitions, opts)

        opts.desc = "Show the implementation(s) of the word under the cursor"
        keymap.set("n", "gi", telescope.lsp_implementations, opts)

        opts.desc = "Show the definition(s) of the type of the word under the cursor"
        keymap.set("n", "gt", telescope.lsp_type_definitions, opts)

        opts.desc = "Show documentation for what is under cursor"
        keymap.set("n", "gk", vim.lsp.buf.hover, opts)

        opts.desc = "See available code actions for the word under the cursor"
        keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

        opts.desc = "Smart rename"
        keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

        opts.desc = "Restart LSP"
        keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)

        opts.desc = "Lists Diagnostics for all open buffers."
        keymap.set("n", "<leader>da", telescope.diagnostics, opts)

        opts.desc = "Lists Diagnostics for current buffer."
        keymap.set("n", "<leader>dd", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

        opts.desc = "Show line diagnostics"
        keymap.set("n", "<leader>dh", vim.diagnostic.open_float, opts)

        opts.desc = "Go to previous diagnostic"
        keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)

        opts.desc = "Go to next diagnostic"
        keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
      end,
    })

    -- Change the Diagnostic symbols in the sign column (gutter)
    local diagnostic_config = {
      signs = {
        active = true,
        values = {
          { name = "DiagnosticSignError", text = " " },
          { name = "DiagnosticSignWarn", text = " " },
          { name = "DiagnosticSignHint", text = "󰠠 " },
          { name = "DiagnosticSignInfo", text = " " },
        },
      },
      virtual_lines = false,
      update_in_insert = false,
      underline = true,
      severity_sort = true,
      float = {
        focusable = true,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
      },
    }

    vim.diagnostic.config(diagnostic_config)
  end,
}
