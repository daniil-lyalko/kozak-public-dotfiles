return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" }, -- Lint on load
  config = function()
    local lint = require("lint")
    lint.linters_by_ft = {
      python = { "flake8" },
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      sh = { "shellcheck" },
      yaml = { "yamllint" },
      -- Add more linters here as needed
      -- Ensure they are also in mason.lua ensure_installed
    }

    -- Create autocommand to lint on save and on leaving insert mode
    vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
      group = vim.api.nvim_create_augroup("nvim-lint-autogroup", { clear = true }),
      callback = function()
        require("lint").try_lint()
      end,
    })
  end,
} 