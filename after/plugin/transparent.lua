local transparent = require("transparent")
transparent.setup({
    groups = { -- table: default groups
        'Normal',
        'NormalNC', 'Comment', 'Constant', 'Special', 'Identifier',
        'Statement', 'PreProc', 'Type', 'Underlined', 'Todo', 'String', 'Function',
        'Conditional', 'Repeat', 'Operator', 'Structure', 'LineNr', 'NonText',
        'SignColumn', 'CursorLineNr', 'EndOfBuffer', 'WinBar', 'WinBarNC'
    },
    extra_groups = {
       -- 'NvimTreeNormal', 'NvimTreeEndOfBuffer'
    },
    exclude_groups = {
    }}
)
