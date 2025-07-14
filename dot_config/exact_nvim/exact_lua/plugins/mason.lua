---@type LazySpec
return {
  -- use mason-lspconfig to configure LSP installations
  {
    "williamboman/mason-lspconfig.nvim",
    -- overrides `require("mason-lspconfig").setup(...)`
    opts = function(_, opts)
      -- add more things to the ensure_installed table protecting against community packs modifying it
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
        "ansiblels",
        "bashls",
        "helm_ls",
        "jsonls",
        "lua_ls",
        "terraformls",
        "pyright", -- Python
        "ts_ls", -- TypeScript/JavaScript
        "gopls", -- Go
        "dockerls", -- Docker
        "docker_compose_language_service", -- Docker Compose
        -- add more arguments for adding more language servers
      })
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    -- overrides `require("mason-nvim-dap").setup(...)`
    opts = function(_, opts)
      -- add more things to the ensure_installed table protecting against community packs modifying it
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
        "js",
        "python",
        -- add more arguments for adding more debuggers
      })
    end,
  },
  -- Add configuration for mason.nvim itself if needed, or ensure tools are installed via AstroNvim opts
  -- For now, we'll rely on the new plugins to specify dependencies,
  -- but Mason needs to know which executables to install.
  -- Let's add the default mason setup block with ensure_installed
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      -- Add linters and formatters here
      vim.list_extend(opts.ensure_installed, {
        -- Linters
        "flake8", -- Python
        "eslint_d", -- JS/TS
        "shellcheck", -- Shell
        "yamllint", -- YAML
        -- Formatters
        "stylua", -- Lua
        "black", -- Python
        "isort", -- Python
        "prettierd", -- JS/TS/Web
        "shfmt", -- Shell
        "yamlfmt", -- YAML
      })
      
      -- Configure Mason to use nvm's Node.js
      opts.PATH = "prepend"
      
      -- Set up Mason to use nvm's Node path dynamically
      local nvm_dir = vim.env.HOME .. "/.nvm"
      if vim.fn.isdirectory(nvm_dir) == 1 then
        -- Try to find the default Node version or any available version
        local node_versions = vim.fn.glob(nvm_dir .. "/versions/node/*/bin", 0, 1)
        if #node_versions > 0 then
          -- Use the first available Node version (you might want to sort and pick latest)
          vim.env.PATH = node_versions[#node_versions] .. ":" .. vim.env.PATH
        end
      end
    end,
  },
}
