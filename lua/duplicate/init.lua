local Duplicate = {}
local config

Duplicate.operator = function(mode)
  if mode == "normal" then
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
    string.format(
      "lockmarks lua Duplicate.duplicate_lines(%d, %d, %d, %d, %s)",
      line_left,
      line_right,
      col_left,
      col_right,
      mode
    )
  )
  return ""
end

local duplicate_cur_line = function()
  local line_nr, _ = unpack(vim.api.nvim_win_get_cursor(0))
  -- Respect v:count
  local line_count = math.max(1, vim.v.count)
  local lines = vim.api.nvim_buf_get_lines(0, line_nr - 1, line_nr + line_count - 1, false)
  if config.transform then
    lines = config.transform(lines)
  end
  local last_line = line_nr + line_count - 1
  vim.api.nvim_buf_set_lines(0, last_line, last_line, false, lines)
end

-- Line indices are 1-based, columns are 0-based
Duplicate.duplicate_lines = function(line_start, line_end, col_start, col_end, mode)
  if line_start == line_end then
    -- Duplicate within a line
    assert(col_start and col_end)
    local line = vim.api.nvim_buf_get_lines(0, line_start - 1, line_start, false)[1]

    -- Make columns 1-based
    col_start, col_end = col_start + 1, col_end + 1
    local chars = line:sub(col_start, col_end)
    if config.transform then
      chars = config.transform({ chars })[1]
    end
    local updated_line = line:sub(1, col_end) .. chars .. line:sub(col_end + 1)
    vim.api.nvim_buf_set_lines(0, line_start - 1, line_start, false, { updated_line })
  else
    local lines = vim.api.nvim_buf_get_lines(0, line_start - 1, line_end, false)
    if config.transform then
      lines = config.transform(lines)
    end
    vim.api.nvim_buf_set_lines(0, line_end, line_end, false, lines)
  end
end

Duplicate.setup = function(user_config)
  -- Export module
  _G.Duplicate = Duplicate

  local default = require("duplicate.config").default
  config = vim.tbl_deep_extend("force", default, user_config or {})

  if config.operator.normal_mode then
    vim.keymap.set("n", config.operator.normal_mode, function()
      return Duplicate.operator("normal")
    end, { expr = true, desc = "Duplicate" })
  end

  if config.operator.visual_mode then
    vim.keymap.set(
      "x",
      config.operator.visual_mode,
      ":<c-u>lua Duplicate.operator('visual')<cr>",
      { desc = "Duplicate" }
    )
  end

  if config.operator.line then
    vim.keymap.set("n", config.operator.line, duplicate_cur_line, { desc = "Duplicate current line" })
  end
end

return Duplicate
