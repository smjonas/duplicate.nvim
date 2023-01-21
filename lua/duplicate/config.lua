local M = {}

M.default = {
  operator = {
    normal_mode = "yd",
    ---@type string
    visual_mode = nil,
    line = "ydd",
  },
  ---@type function
  transform = nil,
}

M.version = "2.0.0" -- x-release-please-version

return M
