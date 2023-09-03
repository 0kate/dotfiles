local buffer = require('astronvim.utils.buffer')

function nav_buffer(direction)
  buffer.nav(direction * (vim.v.count > 0 and vim.v.count or 1))
end

return {
  mappings = {
    n = {
      ['<tab>'] = { function() nav_buffer(1) end, desc = 'Next tab' },
      ['<S-tab>'] = { function() nav_buffer(-1) end, desc = 'Prev tab' },
      ['<C-9>'] = { '<cmd>ToggleTerm<cr>', desc = 'Toggle terminal' },
      ['<leader>hf'] = { '<cmd>HopChar1<cr>', desc = 'Hop char 1' },
      ['<leader>hw'] = { '<cmd>HopWord<cr>', desc = 'Hop word' },
    },
  },
  plugins = {
    {
      'phaazon/hop.nvim',
      config = function()
        require('hop').setup()
      end,
      lazy = false,
    },
  },
}
