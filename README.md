# duplicate.nvim
A tiny Neovim plugin used to duplicate a textobject. E.g. use `ydip` to duplicate the current paragraph.
Requires Neovim

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
