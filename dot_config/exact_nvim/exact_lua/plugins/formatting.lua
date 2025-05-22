return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" }, -- Format on load
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "isort", "black" },
      javascript = { "prettierd", "prettier" }, -- Use prettierd first, fallback to prettier
      typescript = { "prettierd", "prettier" },
      sh = { "shfmt" },
      yaml = { "yamlfmt" },
      -- Add more formatters here as needed
      -- Ensure they are also in mason.lua ensure_installed
      ["_"] = { "trim_whitespace" }, -- Default for any filetype
    },
    -- Format on save
    format_on_save = {
      timeout_ms = 500,
      lsp_fallback = true, -- Use LSP formatter if conform fails or isn't configured
    },
  },
} 