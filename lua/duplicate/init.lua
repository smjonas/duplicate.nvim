local Duplicate = {}

Duplicate.operator = function(mode)
  if mode == nil then
    vim.cmd("set operatorfunc=v:lua.Duplicate.operator")
    return "g@"
  end

  local mark_left, mark_right = "[", "]"
  if mode == "visual" then
    mark_left, mark_right = "<", ">"
  end

  local line_left, col_left = unpack(vim.api.nvim_buf_get_mark(0, mark_left))
  local line_right, col_right = unpack(vim.api.nvim_buf_get_mark(0, mark_right))

  -- Do nothing
  if (line_left > line_right) or (line_left == line_right and col_left > col_right) then
    return
  end

  -- Using `vim.cmd()` wrapper to allow usage of `lockmarks` command, because
  -- raw execution will delete marks inside region (due to -- `vim.api.nvim_buf_set_lines()`).
  vim.cmd(
    string.format("lockmarks lua Duplicate.duplicate_lines(%d, %d, %d, %d)", line_left, line_right, col_left, col_right)
  )
  return ""
end

local duplicate_cur_line = function()
  local cur_line, _ = unpack(vim.api.nvim_win_get_cursor(0))
  vim.cmd(("%scopy%s"):format(cur_line, cur_line))
end

-- Line indices are 1-based, columns are 0-based
Duplicate.duplicate_lines = function(line_start, line_end, col_start, col_end)
  if line_start == line_end then
    -- Duplicate within a line
    assert(col_start and col_end)
    local line = vim.api.nvim_buf_get_lines(0, line_start - 1, line_start, false)[1]
    -- Make columns 1-based
    col_start, col_end = col_start + 1, col_end + 1
    local chars = line:sub(col_start, col_end)
    local updated_line = line:sub(1, col_start - 1) .. chars .. line:sub(col_start)
    vim.api.nvim_buf_set_lines(0, line_start - 1, line_start, false, { updated_line })
  else
    local lines = vim.api.nvim_buf_get_lines(0, line_start - 1, line_end, false)
    vim.api.nvim_buf_set_lines(0, line_end, line_end, false, lines)
  end
end

Duplicate.setup = function(user_config)
  -- Export module
  _G.Duplicate = Duplicate

  local default = require("duplicate.config").default
  local config = vim.tbl_deep_extend("force", default, user_config or {})

  if config.textobject then
    vim.keymap.set("n", config.textobject, Duplicate.operator, { expr = true, desc = "Duplicate" })
  end

  if config.textobject_visual_mode then
    vim.keymap.set(
      "x",
      config.textobject_visual_mode,
      ":<c-u>lua Duplicate.operator('visual')<cr>",
      { desc = "Duplicate" }
    )
  end

  if config.textobject_cur_line then
    vim.keymap.set("n", config.textobject_cur_line, duplicate_cur_line, { desc = "Duplicate current line" })
  end
end

return Duplicate
