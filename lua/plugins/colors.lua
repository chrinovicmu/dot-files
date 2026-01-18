return {
  -- Gruvbox (Lua, HARD contrast)
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("gruvbox").setup({
        contrast = "hard",
        italic = {
          strings = false,
          comments = true,
          operators = false,
          folds = true,
        },
        transparent_mode = false,
      })

      vim.o.background = "dark"
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

  -- Habamax
  {
    "ntk148v/habamax.nvim",
    dependencies = { "rktjmp/lush.nvim" },
    lazy = true,
  },

  -- Kanagawa Paper
  {
    "thesimonho/kanagawa-paper.nvim",
    lazy = true,
    priority = 1000,
    opts = {},
  },

  -- Theme toggle
  {
    "nvim-lua/plenary.nvim",
    config = function()
      local themes = { "gruvbox", "vscode", "habamax", "kanagawa-paper" }
      local index = 1

      vim.keymap.set("n", "<leader>tt", function()
        index = index + 1
        if index > #themes then
          index = 1
        end

        -- reconfigure gruvbox when switching back
        if themes[index] == "gruvbox" then
          require("gruvbox").setup({
            contrast = "hard",
          })
          vim.o.background = "dark"
        end

        vim.cmd.colorscheme(themes[index])
        print("Switched to " .. themes[index])
      end, { desc = "Toggle between installed colorschemes" })
    end,
  },
}
