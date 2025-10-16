-- File: ~/.config/nvim/lua/plugins/clangd.lua
-- This integrates clangd into LazyVim's LSP management system

return {
  -- Hook into the nvim-lspconfig plugin that LazyVim uses
  {
    "neovim/nvim-lspconfig",
    opts = {
      -- Configure servers here - LazyVim will apply this configuration
      servers = {
        clangd = {
          -- These are the settings that will be passed to lspconfig.clangd.setup()

          -- Command to run clangd with optimizations
          cmd = {
            "clangd",
            "--background-index", -- Index project in background for faster lookups
            "--clang-tidy", -- Enable clang-tidy diagnostics
            "--cross-file-rename", -- Allow renaming across files
            "--completion-style=detailed", -- More detailed completion items
          },

          -- File types that should trigger clangd
          filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },

          -- Root directory detection patterns (in order of priority)
          -- This tells LSP where your "project root" is
          root_dir = function(fname)
            local util = require("lspconfig.util")
            -- Look for these files/dirs to identify project root
            return util.root_pattern(
              ".clangd", -- clangd config file
              ".clang-tidy", -- clang-tidy config
              ".clang-format", -- clang-format config
              "compile_commands.json", -- CMake/build system compilation database
              "compile_flags.txt", -- Simple compilation flags file
              ".git" -- Git repository root
            )(fname) or util.find_git_ancestor(fname)
          end,

          -- Capabilities - what features the server supports
          -- LazyVim's cmp-nvim-lsp will automatically enhance this
          capabilities = {
            offsetEncoding = { "utf-16" }, -- clangd uses UTF-16, prevent encoding issues
          },

          -- Initialization options sent to clangd on startup
          init_options = {
            clangdFileStatus = true, -- Show file status in UI
            usePlaceholders = true, -- Use placeholders in function completions
            completeUnimported = true, -- Suggest completions from unimported headers
            semanticHighlighting = true, -- Enable semantic token highlighting
          },

          -- Callback function executed when clangd attaches to a buffer
          on_attach = function(client, bufnr)
            -- Set up buffer-local keymaps for LSP functions
            local opts = { buffer = bufnr, noremap = true, silent = true }

            -- Jump to definition (where symbol is defined)
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)

            -- Jump to declaration (where symbol is declared, e.g., .h file)
            vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

            -- Show hover documentation (type info, docs)
            vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

            -- Jump to implementation (useful for virtual functions)
            vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)

            -- Show signature help (function parameter hints)
            vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)

            -- Rename symbol across project
            vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

            -- Show code actions (fixes, refactorings)
            vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)

            -- Show all references to symbol
            vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)

            -- Format buffer with clangd
            vim.keymap.set("n", "<leader>cf", function()
              vim.lsp.buf.format({ async = true })
            end, opts)

            -- Switch between header/source (clangd-specific)
            vim.keymap.set("n", "<leader>ch", "<cmd>ClangdSwitchSourceHeader<cr>", opts)
          end,
        },
      },

      -- Setup handlers - this ensures clangd actually starts
      setup = {
        clangd = function(_, opts)
          -- This function is called when setting up clangd
          -- Return true to indicate we're handling the setup
          local lspconfig = require("lspconfig")
          lspconfig.clangd.setup(opts)
          return true
        end,
      },
    },
  },

  -- Optional: Add clangd extensions for extra features
  {
    "p00f/clangd_extensions.nvim",
    dependencies = { "neovim/nvim-lspconfig" },
    opts = {
      -- Extensions configuration
      inlay_hints = {
        inline = false, -- Don't show inline hints (can be noisy)
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
      },
      memory_usage = {
        border = "rounded",
      },
      symbol_info = {
        border = "rounded",
      },
    },
  },
}
