return {
  "seblyng/roslyn.nvim",
  --@module 'roslyn.config'
  --@type RoslynNvimConfig
  ft = { "cs", "razor" },
  opts = {
    -- "auto" | "roslyn" | "off"
    --
    -- - "auto": Does nothing for filewatching, leaving everything as default
    -- - "roslyn": Turns off neovim filewatching which will make roslyn do the filewatching
    -- - "off": Hack to turn off all filewatching. (Can be used if you notice performance issues)
    filewatching = "auto",

    -- Optional function that takes an array of targets as the only argument. Return the target you
    -- want to use. If it returns `nil`, then it falls back to guessing the target like normal
    -- Example:
    --
    -- choose_target = function(target)
    --     return vim.iter(target):find(function(item)
    --         if string.match(item, "Foo.sln") then
    --             return item
    --         end
    --     end)
    -- end
    choose_target = nil,

    -- Optional function that takes the selected target as the only argument.
    -- Returns a boolean of whether it should be ignored to attach to or not
    --
    -- I am for example using this to disable a solution with a lot of .NET Framework code on mac
    -- Example:
    --
    -- ignore_target = function(target)
    --     return string.match(target, "Foo.sln") ~= nil
    -- end
    ignore_target = nil,

    -- Whether or not to look for solution files in the child of the (root).
    -- Set this to true if you have some projects that are not a child of the
    -- directory with the solution file
    broad_search = false,

    -- Whether or not to lock the solution target after the first attach.
    -- This will always attach to the target in `vim.g.roslyn_nvim_selected_solution`.
    -- NOTE: You can use `:Roslyn target` to change the target
    lock_target = false,

    -- If the plugin should silence notifications about initialization
    silent = false,
  },

  -- ADD THIS:

  lazy = false,
  config = function()
    -- Use one of the methods in the Integration section to compose the command.
    -- require("mason-registry")

    -- local rzls_path = vim.fn.expand("$MASON/packages/rzls/libexec")
    -- local cmd = {
    -- "roslyn",
    -- "--stdio",
    -- "--logLevel=Information",
    -- "--extensionLogDirectory=" .. vim.fs.dirname(vim.lsp.get_log_path()),
    -- "--razorSourceGenerator=" .. vim.fs.joinpath(rzls_path, "Microsoft.CodeAnalysis.Razor.Compiler.dll"),
    -- "--razorDesignTimePath=" .. vim.fs.joinpath(rzls_path, "Targets", "Microsoft.NET.Sdk.Razor.DesignTime.targets"),
    -- "--extension",
    -- vim.fs.joinpath(rzls_path, "RazorExtension", "Microsoft.VisualStudioCode.RazorExtension.dll"),
    -- }

    vim.lsp.config("roslyn", {
      -- cmd = cmd,
      -- handlers = require("rzls.roslyn_handlers"),
      settings = {
        ["csharp|formatting"] = {
          --Sort using directives on format alphabetically.
          --Expected values: true, false
          dotnet_organize_imports_on_format = true,
        },

        ["csharp|inlay_hints"] = {
          -- Note: These won't have any effect if you don't enable inlay hints in your config.
          -- Check :h vim.lsp.inlay_hint.enable().

          --Show hints for implicit object creation.
          --Expected values: true, false
          csharp_enable_inlay_hints_for_implicit_object_creation = true,
          --Show hints for variables with inferred types.
          --Expected values: true, false
          csharp_enable_inlay_hints_for_implicit_variable_types = true,
          --Show hints for lambda parameter types.
          --Expected values: true, false
          csharp_enable_inlay_hints_for_lambda_parameter_types = true,
          --Display inline type hints.
          --Expected values: true, false
          csharp_enable_inlay_hints_for_types = true,
          --Show hints for indexers.
          --Expected values: true, false
          dotnet_enable_inlay_hints_for_indexer_parameters = true,
          --Show hints for literals.
          --Expected values: true, false
          dotnet_enable_inlay_hints_for_literal_parameters = true,
          --Show hints for 'new' expressions.
          --Expected values: true, false
          dotnet_enable_inlay_hints_for_object_creation_parameters = true,
          --Show hints for everything else.
          --Expected values: true, false
          dotnet_enable_inlay_hints_for_other_parameters = true,
          --Display inline parameter name hints.
          --Expected values: true, false
          dotnet_enable_inlay_hints_for_parameters = true,
          --Suppress hints when parameter names differ only by suffix.
          --Expected values: true, false
          dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix = true,
          --Suppress hints when argument matches parameter name.
          --Expected values: true, false
          dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = true,
          --Suppress hints when parameter name matches the method's intent.
          --Expected values: true, false
          dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = true,
        },
        ["csharp|code_lens"] = {
          --Enable code lens references.
          --Expected values: true, false
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
