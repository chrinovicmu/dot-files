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
vim.cmd("colorscheme habamax")
vim.defer_fn(function()
  vim.cmd([[hi Normal guibg = #000000]])
end, 0)

vim.lsp.handlers["textDocument/inlayHint"] = function() end

require("lazy").setup("plugins")

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
      normal = { c = { fg = "#ffffff", bg = "#000000" } },
      insert = { c = { fg = "#33C1FF", bg = "#000000" } }, -- Gray for insert mode
      visual = { c = { fg = "#ffffff", bg = "#ADD8E6" } },
      replace = { c = { fg = "#ffffff", bg = "#ff0000" } },
    },
  },
})
