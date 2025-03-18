return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      clangd = {
        cmd = {
          "clangd",
          "--function-arg-placeholders=0",
          "--header-insertion=iwyu",
          "--fallback-style=none",
          "--header-insertion-decorators",
          "--suggest-missing-includes",
          "--enable-config",
          "--include-cleaner-stdlib",
          "--offset-encoding=utf-16",
        },
        filetypes = { "c", "cpp", "objc", "objcpp" },
        settings = {
          -- Ensure standard system include paths are recognized
          ["clangd.path"] = {
            "/usr/include",
            "/usr/local/include",
          },
        },
        capabilities = vim.lsp.protocol.make_client_capabilities(),
      },
    },
  },
  -- Optional: Add this for more comprehensive include management
  dependencies = {
    {
      "p00f/clangd_extensions.nvim",
      config = function()
        require("clangd_extensions").setup({
          -- More aggressive include insertion
          inlay_hints = {
            inline = vim.fn.has("nvim-0.10") == 1,
          },
        })
      end,
    },
  },
}
