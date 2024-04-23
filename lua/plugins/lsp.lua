return {
  {
    "neovim/nvim-lspconfig",
    -- thanks https://github.com/SuduIDE/ideals/issues/59#issuecomment-1348761041
    -- see also `:h lspconfig-new`, https://www.lazyvim.org/configuration/examples
    ---@class PluginLspOpts
    opts = function(_, opts)
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local configs = require("lspconfig.configs")
      local util = require("lspconfig.util")

      capabilities.textDocument.completion.completionItem.snippetSupport = true
      capabilities.textDocument.completion.completionItem.resolveSupport = {
        properties = {
          "documentation",
          "detail",
          "additionalTextEdits",
        },
      }

      configs.ideals = {
        default_config = {
          cmd = { "/Applications/IntelliJ IDEA CE.app/Contents/MacOS/idea", "lsp-server" },
          filetypes = { "kotlin", "gradle", "java" },
          root_dir = function(pattern)
            local cwd = vim.loop.cwd()
            local root = util.root_pattern(".idea")(pattern)
            return util.path.is_descendant(cwd, root) and cwd or root
          end,
        },
      }

      -- lspconfig.ideals.setup({
      --   capabilities = capabilities,
      -- })
      -- table.insert(opts, value)
      opts.servers.ideals = {
        capabilities = capabilities,
      }
    end,
  },
  {
    "jmederosalvarado/roslyn.nvim",
    config = function()
      require("roslyn").setup({
        --dotnet_cmd = "dotnet", -- this is the default
        --roslyn_version = "4.8.0-3.23475.7", -- this is the default
        --on_attach = <on_attach you would pass to nvim-lspconfig>, -- required
        --capabilities = <capabilities you would pass to nvim-lspconfig>, -- required
      })
    end,
  },
}
