local buffer = require('astronvim.utils.buffer')

function NavBuffer(direction)
  buffer.nav(direction * (vim.v.count > 0 and vim.v.count or 1))
end

return {
  highlights = {
    -- apply highlight group to all colorschemes (include the default_theme)
    init = {
      -- set the transparency for all of these highlight groups
      -- Normal = { bg = "NONE", ctermbg = "NONE" },
      -- NormalNC = { bg = "NONE", ctermbg = "NONE" },
      -- CursorColumn = { cterm = {}, ctermbg = "NONE", ctermfg = "NONE" },
      -- CursorLine = { cterm = {}, ctermbg = "NONE", ctermfg = "NONE" },
      -- CursorLineNr = { cterm = {}, ctermbg = "NONE", ctermfg = "NONE" },
      -- LineNr = {},
      -- SignColumn = {},
      -- StatusLine = {},
      -- NeoTreeNormal = { bg = "NONE", ctermbg = "NONE" },
      -- NeoTreeNormalNC = { bg = "NONE", ctermbg = "NONE" },
    },
  },
  lsp = {
    formatting = {
      format_on_save = {
        enabled = true,
        ignore_filetypes = {
          'python',
        },
      },
    },
  },
  mappings = {
    n = {
      ['<tab>'] = { function() NavBuffer(1) end, desc = 'Next tab' },
      ['<S-tab>'] = { function() NavBuffer(-1) end, desc = 'Prev tab' },
      ['<F11>'] = { '<cmd>ToggleTerm<cr>', desc = 'Toggle terminal' },
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
    {
      'APZelos/blamer.nvim',
      init = function()
        vim.g.blamer_enabled = true
      end,
      lazy = false,
    },
    {
      'github/copilot.vim',
      init = function()
        vim.g.copilot_no_tab_map = true
        vim.api.nvim_set_keymap("i", "<C-j>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
      end,
      lazy = false,
    },
    {
      'CopilotC-Nvim/CopilotChat.nvim',
      branch = 'release',
      opts = {
        show_help = "yes",         -- Show help text for CopilotChatInPlace, default: yes
        debug = false,             -- Enable or disable debug mode, the log file will be in ~/.local/state/nvim/CopilotChat.nvim.log
        disable_extra_info = 'no', -- Disable extra information (e.g: system prompt) in the response.
        -- language = "English" -- Copilot answer language settings when using default prompts. Default language is English.
        -- proxy = "socks5://127.0.0.1:3000", -- Proxies requests via https or socks.
        -- temperature = 0.1,
      },
      build = function()
        vim.notify("Please update the remote plugins by running ':UpdateRemotePlugins', then restart Neovim.")
      end,
      event = "VeryLazy",
      lazy = false,
    },
  },
}
