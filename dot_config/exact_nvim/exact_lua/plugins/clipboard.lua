---@type LazySpec
return {
  {
    "AstroNvim/astrocore",
    opts = function(_, opts)
      -- Configure clipboard settings
      opts.options = opts.options or {}
      opts.options.opt = opts.options.opt or {}
      
      -- Set clipboard to use system clipboard
      opts.options.opt.clipboard = "unnamedplus"
      opts.options.opt.mouse = "a"
      
      -- Add clipboard mappings
      opts.mappings = opts.mappings or {}
      opts.mappings.n = opts.mappings.n or {}
      opts.mappings.v = opts.mappings.v or {}
      
      -- Normal mode mappings (compatible with Zellij)
      opts.mappings.n["<leader>y"] = { '"+y', desc = "Copy to system clipboard" }
      opts.mappings.n["<leader>Y"] = { '"+Y', desc = "Copy line to system clipboard" }
      opts.mappings.n["<leader>p"] = { '"+p', desc = "Paste from system clipboard" }
      opts.mappings.n["<leader>P"] = { '"+P', desc = "Paste before cursor from system clipboard" }
      opts.mappings.n["<leader>d"] = { '"+d', desc = "Delete to system clipboard" }
      opts.mappings.n["<leader>D"] = { '"+D', desc = "Delete line to system clipboard" }
      
      -- Visual mode mappings (compatible with Zellij)
      opts.mappings.v["<leader>y"] = { '"+y', desc = "Copy to system clipboard" }
      opts.mappings.v["<leader>p"] = { '"+p', desc = "Paste from system clipboard" }
      opts.mappings.v["<leader>P"] = { '"+P', desc = "Paste before cursor from system clipboard" }
      opts.mappings.v["<leader>d"] = { '"+d', desc = "Delete to system clipboard" }
      
      -- Configure clipboard provider for WSL
      if vim.fn.has("wsl") == 1 then
        vim.g.clipboard = {
          name = "WSLClipboard",
          copy = {
            ["+"] = "xclip -selection clipboard",
            ["*"] = "xclip -selection primary",
          },
          paste = {
            ["+"] = "xclip -selection clipboard -o",
            ["*"] = "xclip -selection primary -o",
          },
          cache_enabled = 1,
        }
      end
      
      return opts
    end,
  },
}

