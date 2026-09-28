vim.api.nvim_create_user_command('Unitify', function()
  vim.cmd [[%s/\v(\d+[ ,\d+])([A-Za-zµ\/]+)/\$\1\\,\\unit{\2}\$/g]]
end, {})
return {}
