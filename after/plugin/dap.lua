local dap = require("dap")

require("dapui").setup({
    -- icons = { expanded = "?", collapsed = "?" },
    mappings = {
        -- Use a table to apply multiple mappings
        expand = { "<CR>", "<2-LeftMouse>" },
        open = "o",
        remove = "d",
        edit = "e",
        repl = "r",
    },
    layouts = {
        {
            elements = {
                { id = "repl",   size = 0.25 },
                { id = "scopes", size = 0.75 },
            },
            size = 10,
            position = 'bottom',
        },
    },
    floating = {
        max_height = nil, -- These can be integers or a float between 0 and 1.
        max_width = nil,  -- Floats will be treated as percentage of your screen.
        mappings = {
            close = { "q", "<Esc>" },
        },
    },
    windows = { indent = 1 },
})

dap.adapters["pwa-node"] = {
    type = "server",
    host = "localhost",
    port = "${port}",
    executable = {
        command = "node",
        args = { "/Users/chisakikirino/.local/share/nvim/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
            "${port}" },
    }
}

dap.configurations.javascript = {
    {
        type = "pwa-node",
        request = "attach",
        name = "Attach",
        processId = require 'dap.utils'.pick_process,
        cwd = "${workspaceFolder}",
    }
}

dap.configurations.typescript = {
    {
        type = "pwa-node",
        request = "attach",
        name = "Attach",
        processId = require 'dap.utils'.pick_process,
        cwd = "${workspaceFolder}",
    }
}

dap.adapters.codelldb = {
  type = 'server',
  port = "${port}",
  executable = {
    command = '/Users/chisakikirino/.config/nvim/codelldb/adapter/codelldb',
    args = {"--port", "${port}"},
  }
}

dap.configurations.rust = {
  {
    name = 'Launch',
    type = 'codelldb',
    request = 'launch',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},
  },
}

vim.keymap.set('n', '<leader>bp', function()
    dap.toggle_breakpoint()
end)
vim.keymap.set('n', '<leader>db', function()
    require('dapui').toggle()
end)
