return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" }, -- Lint on load
  config = function()
    local lint = require("lint")
    
    -- Helper function to check if a linter is available
    local function linter_exists(name)
      local linter_config = lint.linters[name]
      if not linter_config then return false end
      
      local cmd = linter_config.cmd
      if type(cmd) == "function" then
        -- For dynamic commands, assume it exists (will fail gracefully if not)
        return true
      end
      
      return vim.fn.executable(cmd) == 1
    end
    
    -- Define linters with fallback behavior
    -- Only use linters that provide value beyond LSP diagnostics
    local linters_by_ft = {
      javascript = { "eslint_d" }, -- Provides style/best practices beyond ts_ls
      typescript = { "eslint_d" }, -- Provides style/best practices beyond ts_ls
      -- python: using pyright LSP for all diagnostics
      -- yaml: using yamlls LSP for all diagnostics  
      -- shell: using bashls LSP for all diagnostics
      -- Add more linters here only if they provide unique value beyond LSP
    }
    
    -- Filter out unavailable linters
    lint.linters_by_ft = {}
    for ft, linters in pairs(linters_by_ft) do
      local available_linters = {}
      for _, linter in ipairs(linters) do
        if linter_exists(linter) then
          table.insert(available_linters, linter)
        else
          vim.notify(string.format("Linter '%s' for %s is not available", linter, ft), vim.log.levels.WARN, { title = "nvim-lint" })
        end
      end
      if #available_linters > 0 then
        lint.linters_by_ft[ft] = available_linters
      end
    end

    -- Create autocommand to lint on save and on leaving insert mode
    vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
      group = vim.api.nvim_create_augroup("nvim-lint-autogroup", { clear = true }),
      callback = function()
        -- Safely try to lint, catching any errors
        local ok, err = pcall(function()
          require("lint").try_lint()
        end)
        if not ok then
          vim.notify(string.format("Linting failed: %s", err), vim.log.levels.ERROR, { title = "nvim-lint" })
        end
      end,
    })
  end,
} 