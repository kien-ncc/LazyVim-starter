return {
  {
    "mfussenegger/nvim-dap",
    -- stylua: ignore
    keys = {
      { "<F5>", function() require("dap").continue() end, desc = "Continue" },
      { "<F10>", function() require("dap").step_over() end, desc = "Step Over" },
      { "<F11>", function() require("dap").step_into() end, desc = "Step Into" },
      -- swap uppercase mappings since the lowercase version is used more frequently.
      { "<leader>dC", function() require("dap").continue() end, desc = "Continue" },
      { "<leader>dc", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
      { "<leader>dO", function() require("dap").step_out() end, desc = "Step Out" },
      { "<leader>do", function() require("dap").step_over() end, desc = "Step Over" },
    },
  },
  {
    "mxsdev/nvim-dap-vscode-js",
    config = function()
      require("dap-vscode-js").setup({
        -- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
        --vim.env.HOME
        debugger_path = "/Users/admin/src/vscode-js-debug", -- Path to vscode-js-debug installation.
        -- debugger_cmd = { "js-debug-adapter" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
        adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "chrome", "node-terminal", "pwa-extensionHost" }, -- which adapters to register in nvim-dap
        -- log_file_path = "(stdpath cache)/dap_vscode_js.log" -- Path for file logging
        -- log_file_level = false -- Logging level for output to file. Set to false to disable file logging.
        -- log_console_level = vim.log.levels.ERROR -- Logging level for output to console. Set to false to disable console output.
      })

      for _, language in ipairs({ "typescript", "javascript", "html", "vue" }) do
        require("dap").configurations[language] = {
          {
            -- use nvim-dap-vscode-js's pwa-node debug adapter
            type = "pwa-chrome",
            name = "Launch Chrome to debug client",
            request = "launch",
            url = "http://localhost:9000",
            sourceMaps = true,
            protocol = "inspector",
            port = 9222,
            webRoot = "${workspaceFolder}/site-watching-over",
            -- skip files from vite's hmr
            skipFiles = { "**/node_modules/**/*", "**/@vite/*", "**/src/client/*", "**/src/*" },
          },
          {
            type = "pwa-chrome",
            name = "Launch Chrome to debug client 8080",
            request = "launch",
            url = "http://localhost:8080",
            sourceMaps = true,
            protocol = "inspector",
            port = 9222,
            webRoot = "${workspaceFolder}/site-manage-thg/src",
            -- skip files from vite's hmr
            skipFiles = { "**/node_modules/**/*", "**/@vite/*", "**/src/client/*", "**/src/*" },
          },
          {
            type = "pwa-chrome",
            name = "Attach Chrome 9222 url localhost 8080",
            request = "attach",
            url = "http://localhost:8080",
            sourceMaps = true,
            protocol = "inspector",
            port = 9222,
            webRoot = "${workspaceFolder}/site-manage-thg/src",
            skipFiles = { "**/node_modules/**/*", "**/@vite/*", "**/src/client/*", "**/src/*" },
            sourceMapPathOverrides = {
              ["webpack://package-name/./src/*"] = "${webRoot}/*",
            },
          },
          {
            type = "pwa-chrome",
            name = "Attach Chrome 9222 url localhost 9000",
            request = "attach",
            url = "http://localhost:9000",
            sourceMaps = true,
            protocol = "inspector",
            port = 9222,
            webRoot = "${workspaceFolder}/site-watching-over/src",
            skipFiles = { "**/node_modules/**/*", "**/@vite/*", "**/src/client/*", "**/src/*" },
            sourceMapPathOverrides = {
              ["webpack://package-name/./src/*"] = "${webRoot}/*",
            },
          },
          {
            type = "pwa-chrome",
            name = "Attach Chrome 9222 url localhost 9001",
            request = "attach",
            url = "http://localhost:9001",
            sourceMaps = true,
            protocol = "inspector",
            port = 9222,
            webRoot = "${workspaceFolder}/site-manage-thg/src",
            skipFiles = { "**/node_modules/**/*", "**/@vite/*", "**/src/client/*", "**/src/*" },
            sourceMapPathOverrides = {
              ["webpack://package-name/./src/*"] = "${webRoot}/*",
            },
          },
          {
            type = "pwa-chrome",
            name = "Launch Chrome to debug client 5097",
            request = "launch",
            url = "http://localhost:5097/welcome",
            sourceMaps = true,
            protocol = "inspector",
            port = 9222,
            webRoot = "${workspaceFolder}/OnPremise",
            -- skip files from vite's hmr
            skipFiles = { "**/node_modules/**/*", "**/@vite/*", "**/src/client/*", "**/src/*" },
          },
          {
            type = "pwa-chrome",
            name = "Launch Chrome to debug client 5097 swagger",
            request = "launch",
            url = "http://localhost:5097/swagger",
            sourceMaps = true,
            protocol = "inspector",
            port = 9222,
            webRoot = "${workspaceFolder}/OnPremise",
            -- skip files from vite's hmr
            skipFiles = { "**/node_modules/**/*", "**/@vite/*", "**/src/client/*", "**/src/*" },
          },
        }
      end
    end,
  },
  {
    "Cliffback/netcoredbg-macOS-arm64.nvim",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      local dap = require("dap")
      require("netcoredbg-macOS-arm64").setup(dap)
      dap.configurations.cs = {
        {
          type = "coreclr",
          name = "NetCoreDbg: Attach",
          request = "attach",
          cwd = "${fileDirname}",
          -- program = function()
          --   return vim.fn.input("Path to dll", vim.fn.getcwd() .. '/bin/Debug/', "file")
          -- end,
          -- processName = function()
          --   return vim.fn.input("Attach processName", "OnPremise", "file")
          -- end,
          processId = require("dap.utils").pick_process,
        },
      }
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    -- stylua: ignore
    keys = {
      { "<leader>de", function() require("dapui").eval(nil, { enter = true }) end, desc = "Eval", mode = {"n", "v"} },
    },
    -- stylua: ignore
    opts = {
      layouts = {{
        elements = { {
            id = "repl",
            size = 0.9
          }, {
            id = "console",
            size = 0.1
          } },
        position = "bottom",
        size = 10
      }},
    },
  },
}
