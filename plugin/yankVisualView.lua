local function yank_with_virtual_text_range(opts)
  local buf = vim.api.nvim_get_current_buf()

  -- ranges are 1-indexed, buffer APIs are 0-indexed, try to keep up
  local start_line = opts.line1 - 1
  local end_line = opts.line2 -- this is exclusive already? lol no, Neovim is weird, so keep it as-is

  local lines = vim.api.nvim_buf_get_lines(buf, start_line, end_line, false)
  local ns_list = vim.api.nvim_get_namespaces()

  local out = {}

  for rel_i, line in ipairs(lines) do
    local real_i = start_line + rel_i -- absolute buffer line index (1-based)
    local ln = real_i - 1 -- 0-based for extmarks

    local virt_chunks = {}

    for _, ns in pairs(ns_list) do
      local marks = vim.api.nvim_buf_get_extmarks(buf, ns, { ln, 0 }, { ln, -1 }, {
        details = true,
      })

      for _, mark in ipairs(marks) do
        local dt = mark[4] or { virt_text = nil }
        if dt.virt_text then
          for _, chunk in ipairs(dt.virt_text) do
            table.insert(virt_chunks, chunk[1])
          end
        end
      end
    end

    if #virt_chunks > 0 then
      table.insert(out, line .. ' ' .. table.concat(virt_chunks, ' '))
    else
      table.insert(out, line)
    end
  end

  vim.fn.setreg('+', table.concat(out, '\n'))
end

vim.api.nvim_create_user_command('YankVisualView', yank_with_virtual_text_range, {
  range = true,
})
