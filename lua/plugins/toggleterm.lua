return {
  'akinsho/toggleterm.nvim',
  version = '*',
  config = function()
    require('toggleterm').setup {
      open_mapping = [[<leader>\]],
      size = 16,
      insert_mappings = false, -- whether or not the open mapping applies in insert mode
      -- direction = 'float',
    }
  end,
}
