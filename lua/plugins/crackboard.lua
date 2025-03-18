--return {
--  "boganworld/crackboard.nvim",
--  dependencies = { "nvim-lua/plenary.nvim" },
--  config = function()
--    require("crackboard").setup({
--      session_key = "dd79c8ce01b772590946381cfdc5573ecbd49c2e40208dbb349d49208955af1e",
--   })
--  end,
--}

return {
  "boganworld/crackboard.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("crackboard").setup({
      session_key = "dd79c8ce01b772590946381cfdc5573ecbd49c2e40208dbb349d49208955af1e",
    })
  end,
}
