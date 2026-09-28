local lspconfig = require 'lspconfig'
local capabilities = require('cmp_nvim_lsp').default_capabilities()

lspconfig.texlab.setup {
  capabilities = capabilities,
  filetypes = { 'tex', 'plaintex', 'bib' },
  settings = {
    texlab = {
      build = {
        executable = 'latexmk',
        args = { '-pdf', '-interaction=nonstopmode', '-synctex=1', '%f' },
        onSave = true,
      },
      forwardSearch = {
        executable = 'zathura', -- or 'skim' / 'evince' / 'okular'
        args = { '--synctex-forward', '%l:1:%f', '%p' },
      },
      chktex = { onOpenAndSave = true, onEdit = false },
      diagnosticsDelay = 300,
    },
  },
}
