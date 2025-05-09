return {
  {
    "folke/snacks.nvim",
    ---@type snacks.Config
    opts = {
      picker = {
        hidden = true,
        ignored = true,
        exclude = {
          "node_modules",
          ".git",
        },
      },
    },
  },
}
