return {
  {
    "iamcco/markdown-preview.nvim",
    lazy = true,
    ft = "markdown",
    build = ":call mkdp#util#install()"
  },
  {
    "chrisbra/csv.vim",
    lazy = true,
    ft = "csv"
  }
}

