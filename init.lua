-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

vim.opt.guicursor = "n-v-c:block-,i-ci-ve:block-blockwait700-blinkoff400-blinkon250,r-cr:hor20,o:hor50"
vim.opt.clipboard = "unnamedplus"
vim.opt.clipboard = "unnamedplus"
vim.opt.mouse = ""
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.list = false
vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.cmd("colorscheme habamax")
vim.defer_fn(function()
  vim.cmd([[hi Normal guibg = #000000]])
end, 0)

vim.api.nvim_set_hl(0, "CursorLine", { bg = "NONE", underline = false }) -- No line highlight
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#87CEEB", bold = true }) -- Light blue line number

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

require("lspconfig").clangd.setup({
  cmd = { "clangd", "--compile-commands-dir=/home/chrinovic/Tech/Linux_Device_Drivers/Drivers/IOCTL" },
})

-- Set in normal mode ('n'), map <leader>d to go to definition
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to Definition" })

-- Map <leader>D to go to declaration
vim.keymap.set("n", "dg", vim.lsp.buf.declaration, { desc = "Go to Declaration" })

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
      insert = { c = { fg = "#ffffff", bg = "#000000" } }, -- Gray for insert mode
      visual = { c = { fg = "#ffffff", bg = "#ADD8E6" } },
      replace = { c = { fg = "#ffffff", bg = "#ff0000" } },
    },
  },
})

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- Add plugins here
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client.name == "clangd" then
      client.server_capabilities.documentFormattingProvider = false
    end
  end,
})
