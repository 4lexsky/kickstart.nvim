vim.api.nvim_create_autocmd('FileType', {
  pattern = 'tex',
  callback = function(args)
    local buf = args.buf
    local template_dir = vim.fn.expand '~/Documents/enseignement-examens/templates/global'
    --local template_dir = vim.fn.expand '~/.config/nvim/templates/latex/'

    -- Add path for :r completion
    vim.opt_local.path:append(template_dir)

    -- Delete old :T if it exists (avoids E464)
    pcall(vim.api.nvim_buf_del_user_command, buf, 'TexTemplate')

    -- Create buffer-local :T command
    vim.api.nvim_buf_create_user_command(buf, 'TexTemplate', function(opts)
      local file = template_dir .. opts.args
      if not file:match '%.tex$' then
        file = file .. '.tex'
      end
      if vim.fn.filereadable(file) == 1 then
        vim.cmd('r ' .. vim.fn.fnameescape(file))
      else
        vim.notify('Template not found: ' .. file, vim.log.levels.ERROR)
      end
    end, {
      nargs = 1,
      complete = function(_, line)
        local files = vim.fn.readdir(template_dir)
        local matches = {}
        local prefix = line:match '^%s*TexTemplate%s+(.*)$' or ''
        for _, f in ipairs(files) do
          if f:match '%.tex$' then
            f = f:gsub('%.tex$', '')
            if f:find(prefix, 1, true) then
              table.insert(matches, f)
            end
          end
        end
        return matches
      end,
    })
  end,
})
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'tex', 'plaintex' },
  callback = function()
    vim.lsp.start { name = 'texlab', cmd = { 'texlab' } }
  end,
})
-- Clean tex tmp files after a sucessful compilation
local augroup = vim.api.nvim_create_augroup("vimtex_config", { clear = true })

vim.api.nvim_create_autocmd("User", {
  pattern = "VimtexEventCompileSuccess",
  group = augroup,
  desc = "Clean temporary LaTeX files after successful compilation",
  callback = function()
    if vim.bo.filetype == "tex" then
      vim.fn 
    end
  end,
})
