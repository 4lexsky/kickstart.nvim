return {
  'lervag/vimtex',
  lazy = false, -- or ft = { "tex" } if you prefer lazy-loading
  init = function()
    -- Use Skim as the viewer
    vim.g.vimtex_view_method = 'skim'
    -- vim.g.vimtex_view_general_viewer = 'skim'
    vim.g.vimtex_view_general_viewer = '/Applications/Skim.app/Contents/SharedSupport/displayline'
    vim.g.vimtex_view_general_options = '-r @line @pdf @tex'
    vim.g.vimtex_skim_sync = 1
    vim.g.vimtex_skim_activate = 1

    -- Compiler
    vim.g.vimtex_compiler_method = 'latexmk'

    -- Quickfix filters (optional, less noise)
    vim.g.vimtex_quickfix_ignore_filters = {
      'Underfull',
      'Overfull',
      'specifier changed to',
      'Label(s) may have changed',
    }

    -- Don’t conceal LaTeX
    vim.g.tex_conceal = ''
    vim.opt.conceallevel = 0
    -- vimtex config
    vim.g.vimtex_complete_enabled = 1 -- enable vimtex completion
    vim.g.vimtex_complete_close_braces = 1 -- auto-close braces after commands
    vim.g.vimtex_complete_bib = { simple = 1 } -- simple bib completion
    -- put temp files in .tmp folder
    vim.g.vimtex_compiler_latexmk = {
      aux_dir = '.tmp', -- you can set here whatever name you desire
    }
  end,
}
