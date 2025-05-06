return {
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        cssls = {},
        css_variables = {},
        cssmodules_ls = {},
      },
    },
  },
}
