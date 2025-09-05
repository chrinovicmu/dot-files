-- Make .cu/.cuh files automatically use CUDA filetype
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.cu", "*.cuh" },
  callback = function()
    vim.bo.filetype = "cuda"
  end,
})
