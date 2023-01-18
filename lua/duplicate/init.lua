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
  -- raw execution will delete marks inside region (due to
  -- `vim.api.nvim_buf_set_lines()`).
  vim.cmd(string.format("lockmarks lua Duplicate.duplicate_lines(%d, %d)", line_left, line_right))
  return ""
end

Duplicate.duplicate_lines = function(line_start, line_end)
  local lines = vim.api.nvim_buf_get_lines(0, line_start - 1, line_end, false)
  vim.api.nvim_buf_set_lines(0, line_end, line_end, false, lines)
end

local default_config = {
  textobject = "yd",
}

Duplicate.setup = function(user_config)
  local config = vim.tbl_deep_extend("force", default_config, user_config or {})
  -- Export module
  _G.Duplicate = Duplicate
  vim.keymap.set("n", config.textobject, "v:lua.Duplicate.operator()", { expr = true, desc = "Duplicate" })
  vim.keymap.set("x", config.textobject, ":<c-u>lua Duplicate.operator('visual')<cr>", { desc = "Duplicate" })
end

return Duplicate
