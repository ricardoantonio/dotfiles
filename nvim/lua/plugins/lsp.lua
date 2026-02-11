return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      html = {
        filetypes = { "html", "gotmpl" },
      },
      emmet_ls = {
        filetypes = { "html", "css", "gotmpl" },
      },
    },
  },
}
