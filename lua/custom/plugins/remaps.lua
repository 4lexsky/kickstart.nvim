vim.g.mapleader = ' '

-- Exit current file back to file nav
vim.keymap.set('n', '<leader>pv', vim.cmd.Ex)

-- Move selected content up or down
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

-- In Visual mode, replace the selected text with the contents of the default register without yanking (saving) the replaced text
vim.keymap.set('x', '<leader>p', [["_dP]])

-- Copy the selected text into the system clipboard (in Visual mode)
vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]])

-- Copy the current line into the system clipboard (in Normal mode)
vim.keymap.set('n', '<leader>Y', [["+Y]])

-- Delete the selected text without saving it into the default register (in Normal or Visual mode)
vim.keymap.set({ 'n', 'v' }, '<leader>d', [["_d]])
return {}
