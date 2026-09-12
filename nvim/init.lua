require("settings")
require("plugins")
require("remaps")

vim.cmd([[colorscheme gruvbox]])
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'typescriptreact', 'c', 'go', 'javascript', 'html', 'javascriptreact', 'vue' },

  callback = function() 
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      vim.treesitter.start() 
  end,
})

