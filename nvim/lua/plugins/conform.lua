return {
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "djlint",
      },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        gotmpl = { "djlint" },
      },
      formatters = {
        djlint = {
          prepend_args = {
            "--profile=golang",
            "--indent=2",
          },
        },
      },
    },
  },
}
