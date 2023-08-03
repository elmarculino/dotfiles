return {
  'jose-elias-alvarez/null-ls.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = { 'mason.nvim' },
  opts = function()
    local null_ls = require 'null-ls'
    local formatting = null_ls.builtins.formatting
    local diagnostics = null_ls.builtins.diagnostics

    return {
      debug = false,
      sources = {
        -- formatting
        formatting.prettierd.with {
          extra_filetypes = { 'toml' },
          extra_args = { '--no-semi', '--single-quote', '--jsx-single-quote' },
        },
        formatting.black.with { extra_args = { '--fast' } },
        formatting.stylua,
        formatting.google_java_format,
        formatting.terraform_fmt,
        formatting.markdownlint,
        formatting.beautysh.with({ extra_args = { "--indent-size", "2" } }),
        formatting.sql_formatter.with({ extra_args = { "--config" } }),

        -- diagnostics
        diagnostics.flake8,
      },
    }
  end,
}
