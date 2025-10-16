-- File: ~/.config/nvim/lua/plugins/treesitter.lua
-- This extends/overrides LazyVim's default treesitter configuration

return {
  -- We reference the same plugin that LazyVim uses
  -- By specifying it again, we can override/extend its configuration
  "nvim-treesitter/nvim-treesitter",

  -- The opts table merges with LazyVim's default treesitter options
  -- This is the LazyVim way of extending plugin configurations
  opts = {
    -- Add more languages to ensure_installed
    -- LazyVim already has some, this adds to that list
    ensure_installed = {
      -- Programming languages
      "bash",
      "c",
      "cpp",
      "go",
      "java",
      "python",
      "rust",

      -- Web development
      "html",
      "css",
      "javascript",
      "typescript",
      "tsx",
      "json",
      "yaml",

      -- Lua/Neovim (likely already included by LazyVim)
      "lua",
      "vim",
      "vimdoc",
      "query",

      -- Markdown and documentation
      "markdown",
      "markdown_inline",

      -- Configuration files
      "toml",
      "dockerfile",
      "gitignore",

      -- Other useful parsers
      "regex",
      "sql",

      -- Add any other languages you use!
    },

    -- These are merged with LazyVim's defaults
    highlight = {
      enable = true,
      -- Disable for specific languages if needed
      -- disable = { "latex" },
    },

    indent = {
      enable = true,
      -- Disable for specific languages if indentation is problematic
      -- disable = { "python", "yaml" },
    },

    -- Additional configuration options
    auto_install = true, -- Auto-install parsers for new file types
  },
}
