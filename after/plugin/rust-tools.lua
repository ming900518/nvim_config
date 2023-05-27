local extension_path = '/home/chisakikirino/.config/nvim/codelldb/'
local codelldb_path = extension_path .. 'adapter/codelldb'
local liblldb_path = extension_path .. 'lldb/lib/liblldb.so'
local rt = require("rust-tools")
local rtdap = require('rust-tools.dap')
rt.setup({
    tools = {
        inlay_hints = {
            auto = false
        }
    },
    server = {
        on_attach = function(_, bufnr)
            -- Hover actions
            vim.keymap.set("n", "<Leader>h", rt.hover_actions.hover_actions, { buffer = bufnr })
            -- Code action groups
            vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
        end,
        cmd = { "rustup", "run", "stable", "rust-analyzer" },
        settings = {
            ["rust-analyzer"] = {
                check = {
                    command = "clippy",
                    extraArgs = { "--all", "--", "-W", "clippy::all" }
                }
            }
        },
    },
    dap = {
        adapter = rtdap.get_codelldb_adapter(codelldb_path, liblldb_path)
    },
})
