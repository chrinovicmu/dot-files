return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      clangd = {
        cmd = {
          "clangd",
          -- Disable function argument placeholders for cleaner completion
          "--function-arg-placeholders=0",
          -- Use include-what-you-use style for intelligent header management
          "--header-insertion=iwyu",
          -- Don't override project-specific formatting styles
          "--fallback-style=LLVM",
          -- Add visual decorators to show auto-inserted headers
          "--header-insertion-decorators",
          -- Automatically suggest missing #include directives
          "--suggest-missing-includes",
          -- Enable project-specific .clangd configuration files
          "--enable-config",
          -- Clean up unnecessary standard library includes
          "--include-cleaner-stdlib",
          -- Use UTF-16 encoding for better Neovim compatibility
          "--offset-encoding=utf-16",
          -- Enable comprehensive background indexing for better IntelliSense
          "--background-index",
          -- Increase completion detail for better understanding
          "--completion-style=detailed",
          -- Enable cross-references for better code navigation
          "--cross-file-rename",
          -- Add compile commands database search paths
          "--compile-commands-dir=.",
        },
        -- Specify file types that clangd should handle
        filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
        -- Root directory patterns help clangd understand project structure
        root_dir = require("lspconfig.util").root_pattern(
          "compile_commands.json", -- CMake/Ninja build files
          "compile_flags.txt", -- Simple compilation flags
          ".clangd", -- Project-specific clangd config
          ".git", -- Git repository root
          "Makefile", -- Traditional make projects
          "CMakeLists.txt" -- CMake projects
        ),
        -- Initialize clangd with enhanced capabilities
        init_options = {
          -- Enable additional clangd features
          clangdFileStatus = true, -- Show file indexing status
          usePlaceholders = true, -- Use placeholders in snippets
          completeUnimported = true, -- Complete symbols from unimported headers
          semanticHighlighting = true, -- Enhanced syntax highlighting
        },
        -- Configure LSP client capabilities
        capabilities = vim.tbl_deep_extend("force", vim.lsp.protocol.make_client_capabilities(), {
          -- Enable snippet support for better completions
          textDocument = {
            completion = {
              completionItem = {
                snippetSupport = true,
              },
            },
          },
        }),
        -- Custom handler for better clangd integration
        handlers = {
          -- Handle clangd's file status notifications
          ["textDocument/clangd.fileStatus"] = function(_, result, ctx)
            -- Optional: Display indexing status in statusline
            -- You can integrate this with your statusline plugin
          end,
        },
      },
    },
  },
  dependencies = {
    {
      -- Enhanced clangd integration with additional features
      "p00f/clangd_extensions.nvim",
      config = function()
        require("clangd_extensions").setup({
          -- Configure inlay hints for parameter names and types
          inlay_hints = {
            -- Show hints inline (nvim 0.10+) or in virtual text
            inline = vim.fn.has("nvim-0.10") == 1,
            -- Show parameter names in function calls
            parameter_hints_prefix = "← ",
            -- Show return types for auto/decltype
            type_hints_prefix = "→ ",
            -- Additional hint configurations
            only_current_line = false, -- Show hints for entire buffer
            only_current_line_autocmd = "CursorHold", -- Update trigger
            show_parameter_hints = true, -- Enable parameter hints
            show_qualified_name = false, -- Use short type names
            max_len_align = false, -- Don't align hints
            max_len_align_padding = 1, -- Padding for alignment
            right_align = false, -- Left-align hints
            right_align_padding = 7, -- Right alignment padding
            highlight = "Comment", -- Highlight group for hints
          },
          -- AST (Abstract Syntax Tree) viewer configuration
          ast = {
            -- Role icons for different AST node types
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
  },
}
