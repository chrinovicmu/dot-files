local group_styles = {
  -- Normal text styling - using "None" allows terminal background to show through
  ["Normal"] = { fg = "#CCCCCC", bg = "None" },
  -- Floating windows (like completion menus, hover docs)
  ["NormalFloat"] = { fg = "#CCCCCC", bg = "None" },

  -- Syntax highlighting groups
  ["String"] = { fg = "#BBBBBB" },
  ["Comment"] = { fg = "#777777" },

  ["Identifier"] = { fg = "#DDDDDD", bold = true },
  ["Statement"] = { fg = "#EEEEEE", bold = true },
  ["Special"] = { fg = "#BBBBBB", bold = true },

  ["Function"] = { fg = "#FFFFFF" },
  ["Constant"] = { fg = "#CCCCCC" },

  ["Error"] = { fg = "#FFFFFF", bg = "None", bold = true },

  -- Quickfix list current line highlight
  ["QuickFixLine"] = { fg = "#CCCCCC", bold = true },

  -- Popup menu (completion menu) styling
  ["Pmenu"] = { fg = "#EEEEEE", bg = "#151515" },

  -- File browser and prompt styling
  ["Question"] = { fg = "#666666" },
  ["Directory"] = { fg = "#777777" },

  -- Message area (below status line) styling
  ["MsgSeparator"] = { fg = "#EEEEEE", bg = "#444444" },
  ["MoreMsg"] = { fg = "#EEEEEE", bg = "#444444" },

  -- Status line - THIS IS THE LINE YOU NEED TO CHANGE
  -- bg changed from #333333 (gray) to #000000 (black)
  ["StatusLine"] = { fg = "#EEEEEE", bg = "#000000" },

  -- Code folding and matching brackets
  ["Folded"] = { fg = "#444444" },
  ["MatchParen"] = { fg = "#FFFFFF", bold = true },
  ["WinSeparator"] = { fg = "#444444" },

  -- Search highlighting - regular and current match
  ["Search"] = { fg = "#000000", bg = "#777777" },
  ["CurSearch"] = { fg = "#000000", bg = "#AAAAAA" },

  -- LSP/Diagnostic styling
  ["DiagnosticUnnecessary"] = { fg = "#BBBBBB" },

  -- TODO comments highlighting
  ["Todo"] = { fg = "NvimLightYellow", bg = "None", bold = true },

  -- TreeSitter specific groups
  ["@variable"] = { fg = "#CCCCCC" },
  ["@comment.warning"] = { fg = "#000000", bg = "NvimLightYellow", bold = true },
  ["@comment.error"] = { fg = "#000000", bg = "NvimLightRed", bold = true },
  ["@comment.note"] = { fg = "#000000", bg = "#D3EDE7", bold = true },

  -- LSP signature help active parameter
  ["LspSignatureActiveParameter"] = { bg = "None" },
}

-- Loop through all highlight groups and apply them
-- vim.api.nvim_set_hl(0, group_name, style_table)
-- - 0 means apply to current buffer's namespace
-- - group_name is the highlight group name (e.g., "StatusLine")
-- - style_table contains the styling options (fg, bg, bold, etc.)
for group, style in pairs(group_styles) do
  vim.api.nvim_set_hl(0, group, style)
end
