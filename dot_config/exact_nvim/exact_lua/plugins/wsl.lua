---@type LazySpec
return {
  {
    "AstroNvim/astrocore",
    opts = function(_, opts)
      -- Check if running in WSL
      local is_wsl = vim.fn.has("wsl") == 1
      
      if is_wsl then
        -- Configure WSL-specific clipboard settings
        opts.options = opts.options or {}
        opts.options.opt = opts.options.opt or {}
        
        -- Use Windows clipboard in WSL
        opts.options.opt.clipboard = "unnamedplus"
        opts.options.opt.mouse = "a"
        
        -- Add WSL-specific mappings
        opts.mappings = opts.mappings or {}
        opts.mappings.n = opts.mappings.n or {}
        opts.mappings.v = opts.mappings.v or {}
        
        -- WSL-specific clipboard mappings
        opts.mappings.n["<leader>y"] = { '"+y', desc = "Copy to Windows clipboard" }
        opts.mappings.n["<leader>Y"] = { '"+Y', desc = "Copy line to Windows clipboard" }
        opts.mappings.n["<leader>p"] = { '"+p', desc = "Paste from Windows clipboard" }
        opts.mappings.n["<leader>P"] = { '"+P', desc = "Paste before cursor from Windows clipboard" }
        opts.mappings.n["<leader>d"] = { '"+d', desc = "Delete to Windows clipboard" }
        opts.mappings.n["<leader>D"] = { '"+D', desc = "Delete line to Windows clipboard" }
        
        opts.mappings.v["<leader>y"] = { '"+y', desc = "Copy to Windows clipboard" }
        opts.mappings.v["<leader>p"] = { '"+p', desc = "Paste from Windows clipboard" }
        opts.mappings.v["<leader>P"] = { '"+P', desc = "Paste before cursor from Windows clipboard" }
        opts.mappings.v["<leader>d"] = { '"+d', desc = "Delete to Windows clipboard" }
        
        -- Add WSL-specific clipboard provider
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