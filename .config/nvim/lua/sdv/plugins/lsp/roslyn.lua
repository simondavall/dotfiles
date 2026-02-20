return {
  "seblyng/roslyn.nvim",
  lazy = false,
  ft = { "cs" },
  ---@module 'roslyn.config'
  ---@type RoslynNvimConfig
  opts = {
    filewatching = "roslyn",
  },

  config = function()
    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    vim.lsp.config("roslyn", {
      filetypes = { "cs" },
      capabilities = capabilities,
      on_attach = function(client, bufnr)
        if client.server_capabilities.inlayHintProvider then
          vim.lsp.inlay_hint.enable(true, { bufnr = bufnr }) -- required for inlay hints to work
        end
        -- Disable signature help and inlay hints in Razor (less churn)
        -- if vim.bo[bufnr].filetype == "razor" then
        --   client.server_capabilities.signatureHelpProvider = nil
        --   if client.server_capabilities.inlayHintProvider then
        --     vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
        --   end
        -- end
      end,
      settings = {
        -- razor = {
        --   language_server = {
        --     cohosting_enabled = true,
        --   },
        -- },
        ["csharp|formatting"] = {
          --Sort using directives on format alphabetically.
          dotnet_organize_imports_on_format = true,
        },

        ["csharp|completion"] = {
          --Enables support for showing unimported types and unimported extension methods in completion lists.
          dotnet_show_completion_items_from_unimported_namespaces = true,
          --Perform automatic object name completion for the members that you have recently selected.
          dotnet_show_name_completion_suggestions = true,
        },

        ["csharp|symbol_search"] = {
          --This setting controls how the language server should search for symbols. Search symbols in reference assemblies.
          dotnet_search_reference_assemblies = true
        },
        ["csharp|inlay_hints"] = {
          --Show hints for implicit object creation.
          csharp_enable_inlay_hints_for_implicit_object_creation = false,
          --Show hints for variables with inferred types.
          csharp_enable_inlay_hints_for_implicit_variable_types = true,
          --Show hints for lambda parameter types.
          csharp_enable_inlay_hints_for_lambda_parameter_types = true,
          --Display inline type hints.
          csharp_enable_inlay_hints_for_types = true,
          --Show hints for indexers.
          dotnet_enable_inlay_hints_for_indexer_parameters = true,
          --Show hints for literals.
          dotnet_enable_inlay_hints_for_literal_parameters = true,
          --Show hints for 'new' expressions.
          dotnet_enable_inlay_hints_for_object_creation_parameters = true,
          --Show hints for everything else.
          dotnet_enable_inlay_hints_for_other_parameters = true,
          --Display inline parameter name hints.
          dotnet_enable_inlay_hints_for_parameters = false,
          --Suppress hints when parameter names differ only by suffix.
          dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix = true,
          --Suppress hints when argument matches parameter name.
          dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = true,
          --Suppress hints when parameter name matches the method's intent.
          dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = true,
        },
        ["csharp|code_lens"] = {
          --Enable code lens references.
          dotnet_enable_references_code_lens = true,
        },
        ["csharp|logging"] = {
          logLevel = "Error", -- Only errors will be logged
        },
      },
    })
    vim.lsp.enable("roslyn")
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if not client or client.name ~= "roslyn" then
          return
        end

        local bufnr = args.buf
        if vim.bo[bufnr].filetype == "razor" then
          client.server_capabilities.signatureHelpProvider = nil
        end
      end,
    })
  end,
  init = function()
    -- We add the Razor file types before the plugin loads.
    vim.filetype.add({
      extension = {
        razor = "razor",
        cshtml = "razor",
      },
    })
  end,
}
