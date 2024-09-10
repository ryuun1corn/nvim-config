return {
  "akinsho/bufferline.nvim",
  dependencies = { 
    "nvim-tree/nvim-web-devicons",
    "catppuccin/nvim"
  },
  config = function()
    local bufferline = require("bufferline")

    bufferline.setup({
      highlights = require("catppuccin.groups.integrations.bufferline").get()
    })
  end,
  version = "*",
  opts = {
    options = {
      mode = "tabs",
      separator_style = "slant"
    }
  }
}
