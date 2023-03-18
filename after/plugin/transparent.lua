require("transparent").setup({
    enable = true, -- boolean: enable transparent
    extra_groups = { -- table/string: additional groups that should be cleared
        "all",
        "DapUINormal",
        "DapUIPlayPause",
        "DapUIRestart",
        "DapUIStop",
        "DapUIUnavailable",
        "DapUIStepOver",
        "DapUIStepInto",
        "DapUIStepBack",
        "DapUIStepOut",        -- In particular, when you set it to 'all', that means all available groups
        -- example of akinsho/nvim-bufferline.lua
        --"BufferLineTabClose",
        --"BufferlineBufferSelected",
        --"BufferLineFill",
        --"BufferLineBackground",
        --"BufferLineSeparator",
        --"BufferLineIndicatorSelected",
    },
    exclude = {
    }, -- table: groups you don't want to clear
})
