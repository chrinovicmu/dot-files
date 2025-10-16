return {
  -- Gruvbox theme
  {
    "morhetz/gruvbox",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("gruvbox")
    end,
  },

  -- VSCode theme
  {
    "Mofiqul/vscode.nvim",
    lazy = true,
    config = function()
      require("vscode").setup({
        transparent = false,
        italic_comments = true,
      })
    end,
  },

  -- Habamax theme (lush-based)
  {
    "ntk148v/habamax.nvim",
    dependencies = { "rktjmp/lush.nvim" },
    lazy = true,
  },

  -- Kanagawa Paper theme
  {
    "thesimonho/kanagawa-paper.nvim",
    lazy = true,
    priority = 1000,
    opts = {},
  },

  -- Theme toggle keybinding
  {
    "nvim-lua/plenary.nvim", -- included in LazyVim by default, but kept for safety
    config = function()
      local themes = { "gruvbox", "vscode", "habamax", "kanagawa-paper" }
      local index = 1

      vim.keymap.set("n", "<leader>tt", function()
        index = index + 1
        if index > #themes then
          index = 1
        end
        local theme = themes[index]
        vim.cmd.colorscheme(theme)
        print("Switched to " .. theme)
      end, { desc = "Toggle between installed colorschemes" })
    end,
  },
}
