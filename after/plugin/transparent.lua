require("transparent").setup({
    groups = { -- table: default groups
        'Normal', 'NormalNC', 'Comment', 'Constant', 'Special', 'Identifier',
        'Statement', 'PreProc', 'Type', 'Underlined', 'Todo', 'String', 'Function',
        'Conditional', 'Repeat', 'Operator', 'Structure', 'LineNr', 'NonText',
        'SignColumn', 'CursorLineNr', 'EndOfBuffer',
    },
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
    exclude_groups = {
    }, -- table: groups you don't want to clear
})
