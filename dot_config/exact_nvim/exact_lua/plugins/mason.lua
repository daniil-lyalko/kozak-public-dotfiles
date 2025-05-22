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
    end,
  },
}
