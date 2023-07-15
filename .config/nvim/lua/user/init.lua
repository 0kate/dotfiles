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
    },
  },
}
