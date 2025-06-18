return {
  "kevinhwang91/nvim-ufo",
  dependencies = "kevinhwang91/promise-async",
  event = "BufReadPost",
  opts = {
    -- Configure providers to avoid treesitter issues with certain file types
    provider_selector = function(bufnr, filetype, buftype)
      -- Use indent provider for problematic file types like .pem
      local problematic_filetypes = {
        "pem",
        "crt", 
        "key",
        "cert",
        "p12",
        "pfx"
      }
      
      for _, ft in ipairs(problematic_filetypes) do
        if filetype == ft then
          return {"indent"}
        end
      end
      
      -- Use treesitter for most files, fallback to indent
      return {"treesitter", "indent"}
    end,
  },
  config = function(_, opts)
    require("ufo").setup(opts)
    
    -- Set fold settings
    vim.o.foldcolumn = "1"
    vim.o.foldlevel = 99
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true
    
    -- Key mappings for folding
    vim.keymap.set("n", "zR", require("ufo").openAllFolds)
    vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
  end,
} 