-- ~/.config/nvim/LuaSnip/snippets/tex.lua
-- Snippets for Physics / Academia LaTeX workflow
-- Author: Alexandre Tremblay (Kickstart.nvim + TexLab setup)

local ls = require 'luasnip'
local s, t, i, fmt = ls.snippet, ls.text_node, ls.insert_node, require('luasnip.extras.fmt').fmt

-- Helper for multi-line text node
local function m(text)
  return t(vim.split(text, '\n'))
end
-- Attempt to fix the beg autocompletion that is broken
require('luasnip').add_snippets('tex', {
  -- override with nothing (disables it)
  --  require('luasnip').snippet('beg', {}),
})
ls.add_snippets('tex', {
  s('qbox', {
    t '% ╭────────────────────────────────────────────────────────╮',
    t { '' },
    t '% │                      QUESTION ',
    i(1, '1'),
    t '                        │',
    t { '' },
    t '% ╰────────────────────────────────────────────────────────╯',
  }),
  --  fraction environment
  s(
    'ff',
    fmt(
      [[
  \frac{{{}}}{{{}}}
  ]],
      { i(1), i(2) }
    )
  ),
  -- 🧮 Align environment
  s(
    'al',
    fmt(
      [[
    \begin{{align*}}
    {}
    \end{{align*}}
  ]],
      { i(1) }
    )
  ),

  -- Solution
  s(
    'sol',
    fmt(
      [[
    \begin{{solution}}
    {}
    \end{{solution}}
  ]],
      { i(1) }
    )
  ),
  -- 🧮 Equation environment
  s(
    'eq',
    fmt(
      [[
    \begin{{equation}}
      {}
    \end{{equation}}
  ]],
      { i(1, 'E = mc^2') }
    )
  ),

  -- 🧩 Figure environment
  s(
    'fig',
    fmt(
      [[
    \begin{{figure}}[h!]
      \centering
      \includegraphics[width={}]{{{}}}
      \caption{{{}}}
      \label{{fig:{}}}
    \end{{figure}}
  ]],
      { i(1, '0.8\\textwidth'), i(2, 'figures/filename.png'), i(3, 'Caption text'), i(4, 'label') }
    )
  ),

  -- 🧮 Table environment
  s(
    'tab',
    fmt(
      [[
    \begin{{table}}[h!]
      \centering
      \caption{{{}}}
      \begin{{tabular}}{{{}}}
        \hline
        {} \\\\
        \hline
      \end{{tabular}}
      \label{{tab:{}}}
    \end{{table}}
  ]],
      { i(1, 'Table caption'), i(2, 'c c c'), i(3, 'Header1 & Header2 & Header3'), i(4, 'label') }
    )
  ),

  -- 🎨 TikZ environment
  s(
    'tikz',
    fmt(
      [[
    \begin{{tikzpicture}}[scale={}, thick]
      % Axes
      \draw[->] (-{},0) -- ({},0) node[right] {{${}$}};
      \draw[->] (0,-{}) -- (0,{}) node[above] {{${}$}};
      % Your diagram here
      {}
    \end{{tikzpicture}}
  ]],
      { i(1, '1.0'), i(2, '2'), i(3, '2'), i(4, 'x'), i(5, '2'), i(6, '2'), i(7, 'y'), i(8) }
    )
  ),

  -- 📏 SI Units (requires siunitx)
  s(
    'si',
    fmt(
      [[
    \SI{{{}}}{{{}}}
  ]],
      { i(1, '9.81'), i(2, 'm/s^2') }
    )
  ),

  -- 📚 Citation command
  s(
    'cite',
    fmt(
      [[
    \cite{{{}}}
  ]],
      { i(1, 'author2025') }
    )
  ),

  -- 📘 Reference command
  s(
    'ref',
    fmt(
      [[
    \ref{{{}}}
  ]],
      { i(1, 'eq:label') }
    )
  ),

  -- 📗 Course-specific macro (example)
  s(
    'exo',
    fmt(
      [[
    \exercice{{{}}}
  ]],
      { i(1, 'Analyse des forces sur un pendule') }
    )
  ),

  -- 💡 Inline math
  s(
    'm',
    fmt(
      [[
    ${}$
  ]],
      { i(1, 'x = v_0 t + \frac{1}{2} a t^2') }
    )
  ),

  -- 📈 Physics vectors
  s(
    'vec',
    fmt(
      [[
    \vec{{{}}}
  ]],
      { i(1, 'F') }
    )
  ),

  -- 🧩 Unit vector
  s(
    'uvec',
    fmt(
      [[
    \hat{{{}}}
  ]],
      { i(1, 'n') }
    )
  ),

  -- 🧮 Derivative
  s(
    'dd',
    fmt(
      [[
    \frac{{d{}}}{{d{}}}
  ]],
      { i(1, 'x'), i(2, 't') }
    )
  ),

  -- 🧮 Partial derivative
  s(
    'pp',
    fmt(
      [[
    \frac{{\partial {}}}{{\partial {}}}
  ]],
      { i(1, 'f'), i(2, 'x') }
    )
  ),

  -- 📏 Vector arrow
  s(
    'va',
    fmt(
      [[
    \overrightarrow{{{}}}
  ]],
      { i(1, 'AB') }
    )
  ),

  -- 📋 Common physics template (lab)
  s(
    'lab',
    fmt(
      [[
    \section*{{Introduction}}
    {}
    \section*{{Méthode}}
    {}
    \section*{{Résultats}}
    {}
    \section*{{Analyse}}
    {}
    \section*{{Conclusion}}
    {}
  ]],
      { i(1), i(2), i(3), i(4), i(5) }
    )
  ),
})
