-- nvim-tree is also there in modified buffers so this function filter it out
local modifiedBufs = function(bufs)
    local t = 0
    for k, v in pairs(bufs) do
        if v.name:match("NvimTree_") == nil then
            t = t + 1
        end
    end
    return t
end

local gwidth = vim.api.nvim_list_uis()[1].width
local gheight = vim.api.nvim_list_uis()[1].height
local width = 60
local height = 20

vim.api.nvim_create_autocmd("BufEnter", {
    nested = true,
    callback = function()
        if #vim.api.nvim_list_wins() == 1 and
            vim.api.nvim_buf_get_name(0):match("NvimTree_") ~= nil and
            modifiedBufs(vim.fn.getbufinfo({ bufmodified = 1 })) == 0 then
            vim.cmd "quit"
        end
    end
})

require("nvim-tree").setup({
    sort_by = "case_sensitive",
    view = {
        width = width,
        --height = height,
        float = {
            enable = false,
            open_win_config = {
                relative = "editor",
                width = width,
                height = height,
                row = (gheight - height) * 0.4,
                col = (gwidth - width) * 0.5,
            }
        },
        adaptive_size = true,
        mappings = {
            list = {
                { key = "n", action = "create"},
                { key = "u", action = "dir_up" },
            },
        },
    },
    renderer = {
        group_empty = true,
    },
    filters = {
        dotfiles = false,
        custom = { "^.git$", ".DS_Store" }
    },
    ignore_ft_on_setup = {
        "gitcommit",
    },
    git = {
        enable = true,
        ignore = false,
        timeout = 500,
    },
})
local api = require("nvim-tree.api")
vim.keymap.set('n', '<leader>fe', api.tree.focus)
