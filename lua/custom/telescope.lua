-- lua/custom/telescope.lua
local builtin = require 'telescope.builtin'

-- 🔎 Recherche de fichiers (projet courant)
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })

-- 🔎 Recherche dans le contenu des fichiers (projet courant)
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })

-- 📂 Buffers ouverts
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })

-- ⏳ Historique des fichiers
vim.keymap.set('n', '<leader>fo', builtin.oldfiles, { desc = 'Telescope oldfiles' })

-- 📘 Spécial examens : chercher uniquement dans ~/Documents/enseignement-examens
vim.keymap.set('n', '<leader>fe', function()
  builtin.find_files { cwd = '~/Documents/enseignement-examens', hidden = true }
end, { desc = 'Examens: find files' })

vim.keymap.set('n', '<leader>ge', function()
  builtin.live_grep { cwd = '~/Documents/enseignement-examens' }
end, { desc = 'Examens: live grep' })

-- Custom Telescope pickers for LaTeX workflow
--
local telescope = require 'telescope'
-- local builtin = require 'telescope.builtin'
local actions = require 'telescope.actions'
local action_state = require 'telescope.actions.state'
local conf = require('telescope.config').values

-- 🧩 Shared helper to insert selected .tex file content
local function insert_selected_tex(prompt_bufnr)
  local entry = action_state.get_selected_entry()
  actions.close(prompt_bufnr)
  vim.cmd('read ' .. vim.fn.fnameescape(entry.path))
  vim.notify('✅ Inserted: ' .. vim.fn.fnamemodify(entry.path, ':t'), vim.log.levels.INFO)
end

-- ⚙️ Global Boilerplates
vim.keymap.set('n', '<leader>tb', function()
  builtin.find_files {
    prompt_title = '⚙️ Global Boilerplates',
    cwd = vim.fn.expand '~/Documents/enseignement-examens/templates/global',
    find_command = { 'fd', '--type', 'f', '--extension', 'tex' },
    previewer = conf.file_previewer {}, -- ✅ modern API
    layout_config = { width = 0.9, height = 0.9 },
    attach_mappings = function(_, map)
      map('i', '<CR>', insert_selected_tex)
      map('n', '<CR>', insert_selected_tex)
      return true
    end,
  }
end, { desc = 'Insert LaTeX boilerplate from templates/global' })

-- 🧱 Banque Snippets & Boilerplates
vim.keymap.set('n', '<leader>tp', function()
  builtin.find_files {
    prompt_title = '🧱 LaTeX Snippets & Boilerplates',
    cwd = vim.fn.expand '~/Documents/enseignement-examens/banque',
    find_command = { 'fd', '--type', 'f', '--extension', 'tex' },
    previewer = conf.file_previewer {},
    layout_config = { width = 0.9, height = 0.9 },
    attach_mappings = function(_, map)
      map('i', '<CR>', insert_selected_tex)
      map('n', '<CR>', insert_selected_tex)
      return true
    end,
  }
end, { desc = 'Browse & insert LaTeX templates or boilerplates' })

-- 📄 Template Preview with image picker
vim.keymap.set('n', '<leader>tt', function()
  local has_imgcat = vim.fn.executable 'imgcat' == 1
  local has_chafa = vim.fn.executable 'chafa' == 1
  local viewer = has_imgcat and 'imgcat' or (has_chafa and 'chafa' or nil)

  if not viewer then
    vim.notify('⚠️ No image viewer (imgcat/chafa) found — image previews disabled.', vim.log.levels.WARN)
  end

  telescope.extensions.media_files.media_files {
    prompt_title = '📄 LaTeX Template Preview',
    cwd = vim.fn.expand '~/Documents/enseignement-examens/banque/preview',
    find_cmd = { 'fd', '--extension', 'png' },
    layout_config = { width = 0.9, height = 0.9, preview_width = 0.6 },
    attach_mappings = function(_, map)
      local function insert_tex(prompt_bufnr)
        local entry = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        local tex_file = entry.path:gsub('/preview/', '/latex/'):gsub('_preview', ''):gsub('%.png$', '.tex')
        vim.cmd('read ' .. vim.fn.fnameescape(tex_file))
        vim.notify('✅ Inserted: ' .. vim.fn.fnamemodify(tex_file, ':t'))
      end

      local function open_preview(prompt_bufnr)
        local entry = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        vim.fn.jobstart({ 'open', entry.path }, { detach = true })
      end

      map('i', '<CR>', insert_tex)
      map('n', '<CR>', insert_tex)
      map('i', '<C-o>', open_preview)
      map('n', '<C-o>', open_preview)
      return true
    end,
  }
end, { desc = 'Insert LaTeX template with preview' })
