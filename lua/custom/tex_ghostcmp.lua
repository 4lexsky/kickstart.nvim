-- Safe isolated test: Copilot-style ghost suggestions for TeX
local cmp = require 'cmp'
local types = require 'cmp.types'
local ls = require 'luasnip'
local s, t, i = ls.snippet, ls.text_node, ls.insert_node
require('luasnip.loaders.from_lua').load { paths = vim.fn.stdpath 'config' .. '/lua/custom/snippets' }
-- Minimal TeX snippets to guarantee candidates
ls.add_snippets('tex', {
  s('sec', { t '\\section{', i(1, 'title'), t '}' }),
  s('beg', { t '\\begin{', i(1, 'env'), t { '}', '\t' }, i(0), t { '', '\\end{' }, i(1), t '}' }),
})

cmp.setup.filetype({ 'tex', 'plaintex' }, {
  completion = { autocomplete = { types.cmp.TriggerEvent.TextChanged } },
  experimental = { ghost_text = { hl_group = 'CmpGhostText' } },
  -- show popup while debugging; hide later
  -- window = { completion = cmp.config.window.bordered() },
  window = { completion = cmp.config.disable },
  mapping = cmp.mapping.preset.insert {
    ['<Tab>'] = cmp.mapping.confirm { select = true },
    ['<C-j>'] = cmp.mapping.complete {}, -- manual trigger (safe on macOS)
    ['<Esc>'] = cmp.mapping.abort(),
  },
  sources = cmp.config.sources {
    { name = 'nvim_lsp' }, -- <-- enable texlab completions
    { name = 'luasnip', keyword_length = 2 },
    { name = 'buffer', keyword_length = 2 },
  },
})

vim.api.nvim_set_hl(0, 'CmpGhostText', { link = 'Comment', italic = true })
