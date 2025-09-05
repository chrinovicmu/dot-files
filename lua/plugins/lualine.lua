return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "SmiteshP/nvim-navic" },
  config = function()
    local navic_ok, navic = pcall(require, "nvim-navic")

    -- =========================
    -- Setup lualine
    -- =========================
    require("lualine").setup({
      options = {
        theme = {
          normal = { a = { bg = "#87CEFA", fg = "#000000", gui = "bold" } },
          insert = { a = { bg = "#90EE90", fg = "#000000", gui = "bold" } },
          visual = { a = { bg = "#FFB6C1", fg = "#000000", gui = "bold" } },
          replace = { a = { bg = "#FFA07A", fg = "#000000", gui = "bold" } },
          command = { a = { bg = "#FFD700", fg = "#000000", gui = "bold" } },
        },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch" },
        lualine_c = {
          "filename",
          {
            function()
              if navic_ok and navic.is_available() then
                return navic.get_location()
              else
                return ""
              end
            end,
            cond = function()
              return navic_ok and navic.is_available()
            end,
            color = { fg = "#444444" },
          },
        },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
      -- =========================
      -- Enable winbar for breadcrumbs
      -- =========================
      winbar = {
        lualine_c = {
          {
            function()
              if navic_ok and navic.is_available() then
                return navic.get_location()
              else
                return ""
              end
            end,
            cond = function()
              return navic_ok and navic.is_available()
            end,
            color = { fg = "#FFD700", gui = "bold" }, -- gold breadcrumbs
          },
        },
        lualine_x = {},
      },
    })

    -- Optional: highlight winbar text
    vim.api.nvim_set_hl(0, "WinBar", { fg = "#FFD700", bg = "#1e222a", bold = true })
  end,
}
