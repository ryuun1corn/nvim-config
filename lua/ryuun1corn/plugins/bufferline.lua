return {
  "akinsho/bufferline.nvim",
  dependencies = { 
    "nvim-tree/nvim-web-devicons",
    "catppuccin/nvim"
  },
  config = function()
    local bufferline = require("bufferline")

    bufferline.setup({
      options = {
        mode = "tabs",
      },
      highlights = require("catppuccin.groups.integrations.bufferline").get(),     
    })
  end,
  version = "*",
}
