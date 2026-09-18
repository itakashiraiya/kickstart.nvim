local function get_visual_selection_or_line(opts)
  local mode = vim.fn.mode()
  local cmd
  if mode:match '[vV\22]' then
    return vim.fn.getregion(vim.fn.getpos 'v', vim.fn.getpos '.', { type = mode })
  else
    return vim.fn.getline '.'
  end
end

local function ex_cmd(opts)
  vim.cmd(get_visual_selection_or_line(opts))
end

local function shell(opts)
  vim.cmd('!' .. get_visual_selection_or_line(opts))
end

vim.api.nvim_create_user_command('ExecuteVisualSelection', ex_cmd, {
  range = true,
})
