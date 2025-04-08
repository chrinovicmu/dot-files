return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        rust_analyzer = {
          mason = false, -- LazyVim uses Mason by default; set to false since you installed rust-analyzer manually
          settings = {
            ["rust-analyzer"] = {
              checkOnSave = {
                command = "clippy", -- Use Clippy for linting on save
              },
              diagnostics = {
                enable = true,
              },
              cargo = {
                allFeatures = true, -- Analyze with all features enabled
              },
            },
          },
        },
      },
    },
  },
}
