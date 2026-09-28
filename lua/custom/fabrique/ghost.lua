local M = {}

local ns = vim.api.nvim_create_namespace 'fabrique_ghost'

local function trim(s)
  return (s:gsub('^%s+', ''):gsub('%s+$', ''))
end

local function parse_header(path)
  local f = io.open(path, 'r')
  if not f then
    return nil
  end

  local meta = {}
  local in_header = false
  local lines_read = 0

  for line in f:lines() do
    lines_read = lines_read + 1
    if lines_read > 80 then
      break
    end

    if line:match '^%%+%s*@fabrique%s*$' then
      in_header = true
    elseif in_header and line:match '^%%+%s*@end%s*$' then
      break
    elseif in_header then
      local key, value = line:match '^%%+%s*([%w_%-]+)%s*:%s*(.-)%s*$'
      if key and value then
        meta[key] = trim(value)
      end
    end
  end

  f:close()
  if not in_header then
    return nil
  end
  return meta
end

local function resolve_input(master_path, input_path)
  if not input_path:match '%.tex$' then
    input_path = input_path .. '.tex'
  end
  local master_dir = vim.fs.dirname(master_path)
  return vim.fs.normalize(master_dir .. '/' .. input_path)
end

local function ghost_lines(meta)
  local title = meta.title or meta.id or 'Question'
  local details = {}

  if meta.estimated_time_min and meta.estimated_time_min ~= '' and meta.estimated_time_min ~= 'TODO' then
    table.insert(details, '~' .. meta.estimated_time_min .. ' min')
  end
  if meta.default_points and meta.default_points ~= '' then
    table.insert(details, meta.default_points .. ' pts')
  end

  local first = '↳ ' .. title
  if #details > 0 then
    first = first .. ' · ' .. table.concat(details, ' · ')
  end

  local result = { { { first, 'Comment' } } }
  if meta.preview and meta.preview ~= '' then
    table.insert(result, { { '  ' .. meta.preview, 'Comment' } })
  end
  return result
end

function M.refresh(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  if not vim.api.nvim_buf_is_valid(bufnr) then
    return
  end
  if vim.bo[bufnr].filetype ~= 'tex' then
    return
  end

  local master_path = vim.api.nvim_buf_get_name(bufnr)
  if master_path == '' then
    return
  end

  vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)

  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  for i, line in ipairs(lines) do
    local input_path = line:match '\\input%s*{%s*([^}]+)%s*}'
    if input_path then
      local question_path = resolve_input(master_path, input_path)
      local meta = parse_header(question_path)
      if meta then
        vim.api.nvim_buf_set_extmark(bufnr, ns, i - 1, 0, {
          virt_lines = ghost_lines(meta),
          virt_lines_above = false,
        })
      end
    end
  end
end

function M.setup()
  vim.api.nvim_create_user_command('FabriqueGhostRefresh', function()
    M.refresh(0)
  end, {})

  local group = vim.api.nvim_create_augroup('FabriqueGhost', { clear = true })
  vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost' }, {
    group = group,
    pattern = '*.tex',
    callback = function(args)
      M.refresh(args.buf)
    end,
  })
end

return M
