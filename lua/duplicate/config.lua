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

M.version = "3.0.1" -- x-release-please-version

return M
