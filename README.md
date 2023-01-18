# duplicate.nvim
A tiny Neovim plugin used to duplicate a textobject (works in both normal and visual mode). E.g. use `ydip` to duplicate the current paragraph.

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
  operator = "yd",
}
```
