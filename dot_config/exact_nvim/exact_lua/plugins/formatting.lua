return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" }, -- Format on load
  config = function()
    local conform = require("conform")
    
    -- Helper to check if a formatter is available
    local function formatter_available(formatter)
      local formatter_config = require("conform").get_formatter_config(formatter)
      if not formatter_config then return false end
      
      local command = formatter_config.command
      if type(command) == "function" then
        return true -- Assume dynamic commands exist
      end
      
      return vim.fn.executable(command) == 1
    end
    
    -- Configure conform
    conform.setup({
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "isort", "black" },
        javascript = { "prettierd", "prettier" }, -- Use prettierd first, fallback to prettier
        typescript = { "prettierd", "prettier" },
        javascriptreact = { "prettierd", "prettier" },
        typescriptreact = { "prettierd", "prettier" },
        sh = { "shfmt" },
        bash = { "shfmt" },
        zsh = { "shfmt" },
        yaml = { "yamlfmt" },
        json = { "prettierd", "prettier" },
        jsonc = { "prettierd", "prettier" },
        markdown = { "prettierd", "prettier" },
        html = { "prettierd", "prettier" },
        css = { "prettierd", "prettier" },
        scss = { "prettierd", "prettier" },
        go = { "gofmt" },
        -- Add more formatters here as needed
        -- Ensure they are also in mason.lua ensure_installed
        ["_"] = { "trim_whitespace" }, -- Default for any filetype
      },
      -- Format on save with error handling
      format_on_save = function(bufnr)
        -- Disable for certain filetypes
        local ignore_filetypes = { "sql", "java" }
        if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
          return
        end
        
        -- Disable for files in certain paths
        local bufname = vim.api.nvim_buf_get_name(bufnr)
        if bufname:match("/node_modules/") then
          return
        end
        
        -- Try to format with a timeout
        local ok, err = pcall(function()
          return {
            timeout_ms = 500,
            lsp_fallback = true, -- Use LSP formatter if conform fails or isn't configured
          }
        end)
        
        if not ok then
          vim.notify(string.format("Format on save failed: %s", err), vim.log.levels.WARN, { title = "conform.nvim" })
          return nil
        end
        
        return {
          timeout_ms = 500,
          lsp_fallback = true,
        }
      end,
      -- Log errors
      notify_on_error = true,
    })
  end,
} 