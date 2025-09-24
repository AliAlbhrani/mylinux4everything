require("albhrani.keymaps")
require("albhrani.autocmds")




require('lualine').setup({
  sections = {
    lualine_c = {
      {
        fmt = function(name)
          if name ~= "" then
            return "󰆧 " .. name -- Using a nice icon from a nerd font
          else
            return ""
          end
        end,
      },
    },
  },
})
