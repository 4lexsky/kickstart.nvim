local M = {}

local entries = {
  -- Navigation
  { "Navigation", "h j k l", "déplacement ← ↓ ↑ →" },
  { "Navigation", "w / b", "mot suivant / précédent" },
  { "Navigation", "e", "fin du mot" },
  { "Navigation", "0 / $", "début / fin de ligne" },
  { "Navigation", "^", "premier caractère non vide" },
  { "Navigation", "gg / G", "début / fin du fichier" },
  { "Navigation", "{ / }", "paragraphe précédent / suivant" },
  { "Navigation", "Ctrl-d / Ctrl-u", "demi-page bas / haut" },
  { "Navigation", "%", "parenthèse/accolade correspondante" },
  { "Navigation", "f<char>", "prochain caractère sur la ligne" },
  { "Navigation", "* / #", "occurrence suivante / précédente du mot" },
  { "Navigation", "/texte", "rechercher dans le fichier" },
  { "Navigation", "n / N", "résultat suivant / précédent" },
  { "Navigation", "gf", "ouvrir fichier sous le curseur" },
  { "Navigation", "Ctrl-o", "revenir à l'emplacement précédent" },
  { "Navigation", "Ctrl-i", "avancer dans l'historique" },

  -- Editing
  { "Editing", "i / a", "insérer avant / après curseur" },
  { "Editing", "I / A", "insérer début / fin de ligne" },
  { "Editing", "o / O", "nouvelle ligne dessous / dessus" },
  { "Editing", "Esc", "retour au mode normal" },
  { "Editing", "x", "supprimer caractère" },
  { "Editing", "dd", "supprimer ligne" },
  { "Editing", "D", "supprimer jusqu'à fin de ligne" },
  { "Editing", "dw", "supprimer mot" },
  { "Editing", "cc", "remplacer ligne" },
  { "Editing", "cw", "remplacer mot" },
  { "Editing", "ciw", "remplacer mot entier" },
  { "Editing", 'ci"', "remplacer contenu entre guillemets" },
  { "Editing", "ci{", "remplacer contenu entre accolades" },
  { "Editing", "ci(", "remplacer contenu entre parenthèses" },
  { "Editing", "yy", "copier ligne" },
  { "Editing", "yw", "copier mot" },
  { "Editing", "p / P", "coller après / avant" },
  { "Editing", "u", "undo" },
  { "Editing", "Ctrl-r", "redo" },
  { "Editing", ".", "répéter dernière modification" },

  -- Visual / Operators
  { "Visual", "v", "sélection caractères" },
  { "Visual", "V", "sélection lignes" },
  { "Visual", "Ctrl-v", "sélection bloc" },
  { "Visual", "> / <", "indenter / désindenter" },
  { "Operators", "d + mouvement", "delete selon mouvement" },
  { "Operators", "y + mouvement", "yank selon mouvement" },
  { "Operators", "c + mouvement", "change selon mouvement" },
  { "Operators", "d$", "supprimer jusqu'à fin ligne" },
  { "Operators", "d}", "supprimer jusqu'au prochain paragraphe" },
  { "Operators", "y}", "copier jusqu'au prochain paragraphe" },
  { "Operators", "di{", "supprimer intérieur {...}" },
  { "Operators", "da{", "supprimer {...} incluant accolades" },
  { "Operators", "yi{", "copier intérieur {...}" },

  -- Telescope / Kickstart
  { "Telescope", "<leader>sf", "chercher fichier" },
  { "Telescope", "<leader>sg", "chercher texte dans projet" },
  { "Telescope", "<leader>sw", "chercher mot sous curseur" },
  { "Telescope", "<leader>/", "chercher dans fichier actuel" },
  { "Telescope", "<leader>s/", "chercher dans fichiers ouverts" },
  { "Telescope", "<leader><leader>", "buffers ouverts" },
  { "Telescope", "<leader>s.", "fichiers récents" },
  { "Telescope", "<leader>sh", "chercher dans l'aide" },
  { "Telescope", "<leader>sk", "chercher les keymaps" },
  { "Telescope", "<leader>sc", "chercher les commandes" },
  { "Telescope", "<leader>sr", "reprendre dernière recherche" },
  { "Telescope", "<leader>sn", "chercher config Neovim" },

  -- Telescope picker
  { "Telescope Picker", "Ctrl-n / Ctrl-p", "suivant / précédent" },
  { "Telescope Picker", "Enter", "ouvrir sélection" },
  { "Telescope Picker", "Ctrl-v", "ouvrir split vertical" },
  { "Telescope Picker", "Ctrl-x", "ouvrir split horizontal" },
  { "Telescope Picker", "Ctrl-t", "ouvrir nouvel onglet" },
  { "Telescope Picker", "Ctrl-/", "afficher raccourcis Telescope" },

  -- Windows / Files
  { "Windows", "Ctrl-h", "fenêtre gauche" },
  { "Windows", "Ctrl-j", "fenêtre dessous" },
  { "Windows", "Ctrl-k", "fenêtre dessus" },
  { "Windows", "Ctrl-l", "fenêtre droite" },
  { "Windows", ":sp fichier", "split horizontal" },
  { "Windows", ":vsp fichier", "split vertical" },
  { "Windows", ":q", "fermer fenêtre" },
  { "Files", ":w", "sauvegarder" },
  { "Files", ":wq", "sauvegarder et fermer" },
  { "Files", ":qa", "quitter Neovim" },
  { "Files", ":e fichier", "ouvrir fichier" },

  -- LSP
  { "LSP", "grr", "références du symbole" },
  { "LSP", "grd", "aller à définition" },
  { "LSP", "grD", "aller à déclaration" },
  { "LSP", "gri", "aller à implémentation" },
  { "LSP", "grn", "renommer symbole" },
  { "LSP", "gra", "code action" },
  { "LSP", "Ctrl-s", "signature help" },

  -- Commands
  { "Commands", ":help sujet", "documentation Neovim" },
  { "Commands", ":checkhealth", "vérifier installation/config" },
  { "Commands", ":set option?", "voir valeur option" },
  { "Commands", ":messages", "derniers messages" },

  -- LaTeX
  { "LaTeX", "gf", "ouvrir fichier \\input{...}" },
  { "LaTeX", "Ctrl-o", "retour au fichier précédent" },
  { "LaTeX", "Ctrl-i", "repartir vers fichier ouvert" },
  { "LaTeX", "ci{", "modifier contenu de {...}" },
  { "LaTeX", "di{", "supprimer contenu de {...}" },
  { "LaTeX", "yi{", "copier contenu de {...}" },
  { "LaTeX", "%", "accolade/parenthèse correspondante" },
  { "LaTeX", "<leader>sf", "trouver fichier .tex" },
  { "LaTeX", "<leader>sg", "chercher texte/commande dans projet" },

  -- Discovery
  { "Discover", "<leader>sk", "chercher un raccourci" },
  { "Discover", ":help commande", "documentation d'une commande" },
  { "Discover", ":help motion.txt", "apprendre les mouvements" },
  { "Discover", ":help text-objects", "apprendre les text objects" },
}

function M.open()
  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values
  local entry_display = require("telescope.pickers.entry_display")

  local displayer = entry_display.create({
    separator = " │ ",
    items = {
      { width = 18 },
      { width = 24 },
      { remaining = true },
    },
  })

  local function make_display(entry)
    return displayer({
      { entry.value[1], "TelescopeResultsComment" },
      { entry.value[2], "TelescopeResultsIdentifier" },
      entry.value[3],
    })
  end

  pickers.new({}, {
    prompt_title = "Neovim + Kickstart Cheatsheet",
    finder = finders.new_table({
      results = entries,
      entry_maker = function(entry)
        return {
          value = entry,
          display = make_display,
          ordinal = table.concat(entry, " "),
        }
      end,
    }),
    sorter = conf.generic_sorter({}),
    previewer = false,
    layout_strategy = "center",
    layout_config = {
      width = 0.90,
      height = 0.80,
    },
  }):find()
end

return M
