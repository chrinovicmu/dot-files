return {
  "hrsh7th/nvim-cmp",
  opts = function(_, opts)
    local cmp = require("cmp")
    opts.mapping = cmp.mapping.preset.insert()
    opts.sources = cmp.config.sources({
      { name = "nvim_lsp", keyword_length = 2, option = { completeopt = "menu,menuone,noselect" } },
    })
    opts.experimental = { ghost_text = false } -- Disable ghost text hints
  end,
}
