-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

vim.opt.guicursor = "n-v-c:block-,i-ci-ve:block-blockwait700-blinkoff400-blinkon250,r-cr:hor20,o:hor50"
vim.o.clipboard = "unnamedplus"
vim.o.clipboard = "unnamedplus"
vim.o.mouse = ""
vim.o.tabstop = 4
vim.opt.list = false
vim.opt.cursorline = false
vim.opt.termguicolors = true
vim.cmd("colorscheme catppuccin")
vim.defer_fn(function()
  vim.cmd([[hi Normal guibg = #000000]])
end, 0)
vim.api.nvim_set_hl(0, "Normal", { bg = "#000000" })

-- Set the Catppuccin colorscheme
vim.cmd("colorscheme catppuccin")

-- Set the global Normal group to have a black background
vim.api.nvim_set_hl(0, "Normal", { bg = "#000000" })

-- Set NeoTree-specific highlight groups to have a black background
vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = "#000000" })
vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { bg = "#000000" })

-- Use an autocommand to enforce highlight settings for all windows
vim.api.nvim_create_autocmd("BufWinEnter", {
  pattern = "*",
  callback = function()
    if vim.bo.filetype ~= "neo-tree" then
      -- For non-NeoTree windows (e.g., the main editing area), use the global Normal group
      vim.wo.winhighlight = "Normal:Normal"
    else
      -- For NeoTree windows, use NeoTree-specific highlight groups
      vim.wo.winhighlight = "Normal:NeoTreeNormal,NormalNC:NeoTreeNormalNC"
    end
  end,
})

vim.lsp.handlers["textDocument/inlayHint"] = function() end

require("lazy").setup("plugins")
require("lspconfig").bashls.setup({})
-- Create a new autocommand group to avoid conflicts
local group = vim.api.nvim_create_augroup("CFileAutocommands", { clear = true })

-- Automatically insert standard headers when a new C file is created
vim.api.nvim_create_autocmd("BufNewFile", {
  group = group,
  pattern = "*.c",
  callback = function()
    -- Ensure we are at the beginning of the file and it's empty
    local line_count = vim.api.nvim_buf_line_count(0)
    if line_count == 1 and vim.api.nvim_buf_get_lines(0, 0, 1, false)[1] == "" then
      vim.api.nvim_buf_set_lines(0, 0, 0, false, {
        "#include <stdio.h>",
        "#include <stdlib.h>",
        "",
      })
    end
  end,
})

-- Autocommand for opening existing .c files (e.g., created by touch)
vim.api.nvim_create_autocmd("BufRead", {
  group = group,
  pattern = "*.c",
  callback = function()
    -- Check if the buffer is empty (line count is 1 and first line is empty)
    local line_count = vim.api.nvim_buf_line_count(0)
    local first_line = vim.api.nvim_buf_get_lines(0, 0, 1, false)[1]
    if line_count == 1 and first_line == "" then
      -- Insert the includes
      vim.api.nvim_buf_set_lines(0, 0, 0, false, {
        "#include <stdio.h>",
        "#include <stdlib.h>",
        "",
      })
      vim.api.nvim_win_set_cursor(0, { 3, 0 })
    end
  end,
})

-- Automatically insert header when needed
vim.api.nvim_create_autocmd("BufWritePre", {
  group = group,
  pattern = "*.c",
  callback = function()
    -- Trigger clangd's header insertion functionality if necessary
    vim.lsp.buf.code_action({
      context = {
        diagnostics = vim.diagnostic.get(0), -- Use vim.diagnostic.get() instead
      },
      only = { "source.organizeImports" }, -- Trigger organizeImports if available
    })
  end,
})
vim.api.nvim_set_keymap("n", "<C-v>", '"+p', { noremap = true, silent = true })
require("lazy").setup({ { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" } })

vim.opt.guicursor = "n-v-c:block,i-ci-ve:block-blinkwait700-blinkoff400-blinkon250"

vim.cmd("highlight Visual guibg=#0000FF guifg=NONE")

require("lazy").setup({
  {
    "boganworld/crackboard.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("crackboard").setup({
        session_key = "",
      })
    end,
  },
})

--vim.cmd([[
--  highlight Function guifg=#A9A9A9 ctermfg=2
--]])

--vim.cmd([[
--  highlight Comment guifg=#505050 ctermfg=235
--]])
require("go").setup()

--vim.cmd([[
--  highlight Type guifg=#707070 ctermfg=246
--]])

require("go").setup()

require("lualine").setup({
  options = {
    theme = {
      normal = {
        a = { fg = "#ffffff", bg = "#000000" }, -- White on black
        b = { fg = "#ffffff", bg = "#000000" },
        c = { fg = "#ffffff", bg = "#000000" },
        x = { fg = "#ffffff", bg = "#000000" },
        y = { fg = "#ffffff", bg = "#000000" },
        z = { fg = "#ffffff", bg = "#000000" },
      },
      insert = {
        a = { fg = "#ffffff", bg = "#000000" },
        b = { fg = "#ffffff", bg = "#000000" },
        c = { fg = "#ffffff", bg = "#000000" },
        x = { fg = "#ffffff", bg = "#000000" },
        y = { fg = "#ffffff", bg = "#000000" },
        z = { fg = "#ffffff", bg = "#000000" },
      },
      visual = {
        a = { fg = "#ffffff", bg = "#000000" },
        b = { fg = "#ffffff", bg = "#000000" },
        c = { fg = "#ffffff", bg = "#000000" },
        x = { fg = "#ffffff", bg = "#000000" },
        y = { fg = "#ffffff", bg = "#000000" },
        z = { fg = "#ffffff", bg = "#000000" },
      },
      replace = {
        a = { fg = "#ffffff", bg = "#000000" },
        b = { fg = "#ffffff", bg = "#000000" },
        c = { fg = "#ffffff", bg = "#000000" },
        x = { fg = "#ffffff", bg = "#000000" },
        y = { fg = "#ffffff", bg = "#000000" },
        z = { fg = "#ffffff", bg = "#000000" },
      },
      command = {
        a = { fg = "#ffffff", bg = "#000000" },
        b = { fg = "#ffffff", bg = "#000000" },
        c = { fg = "#ffffff", bg = "#000000" },
        x = { fg = "#ffffff", bg = "#000000" },
        y = { fg = "#ffffff", bg = "#000000" },
        z = { fg = "#ffffff", bg = "#000000" },
      },
      inactive = {
        a = { fg = "#ffffff", bg = "#000000" },
        b = { fg = "#ffffff", bg = "#000000" },
        c = { fg = "#ffffff", bg = "#000000" },
        x = { fg = "#ffffff", bg = "#000000" },
        y = { fg = "#ffffff", bg = "#000000" },
        z = { fg = "#ffffff", bg = "#000000" },
      },
    },
  },
  sections = {
    -- Left side
    lualine_a = { "mode" }, -- Current mode (e.g., NORMAL, INSERT)
    lualine_b = { "branch" }, -- Git branch
    lualine_c = { "filename" }, -- Current filename
    -- Right side
    lualine_x = {
      {
        "diff",
        colored = true, -- Enable colored diff indicators
        symbols = { -- Custom symbols (requires Nerd Font)
          added = " ",
          modified = " ",
          removed = " ",
        },
        diff_color = { -- Colors for diff indicators
          added = { fg = "#99ffff" }, -- Green for added
          modified = { fg = "#99ffcc" }, -- Yellow for modified
          removed = { fg = "#ff0000" }, -- Red for removed
        },
      },
      "encoding", -- File encoding (e.g., utf-8)
      "fileformat", -- File format (e.g., unix)
      "filetype", -- File type (e.g., lua)
    },
    lualine_y = { "progress" }, -- Percentage through file
    lualine_z = { "location" }, -- Line and column numbers
  },
})
