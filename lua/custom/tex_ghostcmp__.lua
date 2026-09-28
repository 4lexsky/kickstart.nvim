-- ~/.config/nvim/lua/custom/tex_ghostcmp.lua
-- Experimental Copilot-style inline ghost completion for TeX

local cmp = require 'cmp'
local types = require 'cmp.types'

local ls = require 'luasnip'
local s, t, i = ls.snippet, ls.text_node, ls.insert_node

ls.add_snippets('tex', {
  s('xx', { t '\\begin{equation}', i(1), t '\\end{equation}' }),
})

cmp.setup.filetype({ 'tex', 'plaintex' }, {
  experimental = { ghost_text = { hl_group = 'CmpGhostText' } },
  mapping = cmp.mapping.preset.insert {
    ['<Tab>'] = cmp.mapping.confirm { select = true },
    ['<C-e>'] = cmp.mapping.complete {},
  },
  -- keep popup visible for testing
  window = { completion = cmp.config.window.bordered() },
  sources = {
    { name = 'luasnip', keyword_length = 2 },
    { name = 'buffer', keyword_length = 2 },
  },
})
-- cmp.setup.filetype('tex', {
--   completion = {
--     autocomplete = { types.cmp.TriggerEvent.TextChanged },
--   },
--   experimental = {
--     ghost_text = { hl_group = 'CmpGhostText' },
--   },
--   window = { completion = cmp.config.disable },
--   mapping = cmp.mapping.preset.insert {
--     ['<Tab>'] = cmp.mapping.confirm { select = true },
--     ['<C-Space>'] = cmp.mapping.complete {},
--     ['<Esc>'] = cmp.mapping.abort(),
--   },
--   sources = cmp.config.sources {
--     { name = 'luasnip', keyword_length = 2 },
--     { name = 'buffer', keyword_length = 2 },
--     { name = 'path' },
--     -- Uncomment if installed:
--     -- { name = 'latex_symbols' },
--     { name = 'vimtex' },
--   },
-- })
--
vim.api.nvim_set_hl(0, 'CmpGhostText', { link = 'Comment', italic = true })
