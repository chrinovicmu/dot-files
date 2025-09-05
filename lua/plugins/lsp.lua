return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      clangd = {
        cmd = {
          "clangd",
          "--function-arg-placeholders=0",
          "--header-insertion=iwyu",
          "--fallback-style=LLVM",
          "--header-insertion-decorators",
          "--suggest-missing-includes",
          "--enable-config",
          "--include-cleaner-stdlib",
          "--offset-encoding=utf-16",
          "--background-index",
          "--completion-style=detailed",
          "--cross-file-rename",
          "--compile-commands-dir=.",
        },
        filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
        root_dir = require("lspconfig.util").root_pattern(
          "compile_commands.json",
          "compile_flags.txt",
          ".clangd",
          ".git",
          "Makefile",
          "CMakeLists.txt"
        ),
        init_options = {
          clangdFileStatus = true,
          usePlaceholders = true,
          completeUnimported = true,
          semanticHighlighting = true,
        },
        capabilities = (function()
          local capabilities = vim.lsp.protocol.make_client_capabilities()
          capabilities.textDocument.completion.completionItem.snippetSupport = true
          return capabilities
        end)(),

        on_attach = function(client, bufnr)
          -- Attach navic
          local navic_ok, navic = pcall(require, "nvim-navic")
          if navic_ok and client.server_capabilities.documentSymbolProvider then
            navic.attach(client, bufnr)
          end
        end,
      },
    },
  },

  dependencies = {
    -- Clangd extensions
    {
      "p00f/clangd_extensions.nvim",
      config = function()
        require("clangd_extensions").setup({
          inlay_hints = {
            inline = vim.fn.has("nvim-0.10") == 1,
            parameter_hints_prefix = "← ",
            type_hints_prefix = "→ ",
            only_current_line = false,
            only_current_line_autocmd = "CursorHold",
            show_parameter_hints = true,
            show_qualified_name = false,
            max_len_align = false,
            max_len_align_padding = 1,
            right_align = false,
            right_align_padding = 7,
            highlight = "Comment",
          },
          ast = {
            role_icons = {
              type = "🄣",
              declaration = "🄓",
              expression = "🄔",
              statement = ";",
              specifier = "🄢",
              ["template argument"] = "🆃",
            },
            kind_icons = {
              Compound = "🄲",
              Recovery = "🅁",
              TranslationUnit = "🅄",
              PackExpansion = "🄿",
              TemplateTypeParm = "🅃",
              TemplateTemplateParm = "🅃",
              TemplateParamObject = "🅃",
            },
          },
        })
      end,
    },

    -- Navic for function/class breadcrumbs
    { "SmiteshP/nvim-navic" },
  },
}
