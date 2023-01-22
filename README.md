# duplicate.nvim
A Neovim plugin used to duplicate a textobject.
E.g. use `ydaw` to duplicate the current word (including whitespace) or `3ydd` to duplicate the next three lines.

## Features
- mappings for duplication in normal mode (line-wise or using textobject) + visual mode
- duplication in normal mode respects `v:count` and is dot-repeatable

Requires Neovim ≥ 0.6.

## Installation
Install it just like any other Neovim plugin. Make sure to call the `setup` function.

Example for lazy.nvim:
```lua
return {
  "smjonas/duplicate.nvim",
  config = function()
    require("duplicate").setup()
  end
}
```

## Configuration
You can override the default settings by passing a Lua table to the setup function. The default options are:
```lua
require("duplicate").setup {
  -- set any operator to `nil` to disable it
  operator = {
    normal_mode = "yd", -- duplicate in normal mode, expects a text-object
    visual_mode = nil, -- duplicate in visual mode, unmapped by default
    line = "ydd", -- duplicate the current line
  },
  -- A function with signature `transform(lines: table<string>): table<string>`.
  -- Can be used to modify the text to be duplicated.
  transform = nil,
}
```
