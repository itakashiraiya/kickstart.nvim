local function format_macro(macro_lines, last_line)
  local max_len = vim.fn.strdisplaywidth(last_line)
  for _, line in ipairs(macro_lines) do
    local len = vim.fn.strdisplaywidth(line)
    if len > max_len then
      max_len = len
    end
  end
  for i, line in ipairs(macro_lines) do
    local pad = max_len - vim.fn.strdisplaywidth(line) + line:len()
    macro_lines[i] = string.format("%-" .. pad .. "s \\", line)
  end
end

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { '*.c', '*.h' },
  callback = function(args)
    local buf = args.buf

    local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)

    local macro_lines = {}
    for i, line in ipairs(lines) do
      line = line:gsub("%s+$", "") -- trim trailing spaces
      lines[i] = line
      local macro_line
      if not macro_lines[1] then
        macro_line = line:match("^(#%s*.-)%s*\\$")
      else
        macro_line = line:match("^(%s*.-)%s*\\$")
      end
      if macro_line then
        table.insert(macro_lines, macro_line)
      elseif macro_lines[1] then
        format_macro(macro_lines, line)
        for j in ipairs(macro_lines) do
          lines[i + j - #macro_lines - 1] = macro_lines[j]
        end
        macro_lines = {}
      end
    end

    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  end,
})
