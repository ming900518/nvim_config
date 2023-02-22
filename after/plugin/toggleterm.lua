require("toggleterm").setup{
    open_mapping = [[<C-t>]],
    shade_terminals = false,
    highlights = {
        Normal = {
            link = 'Normal',
        },
        NormalFloat = {
            link = 'Normal'
        },
        FloatBorder = {
            link = 'Normal'
        },
    }
}
