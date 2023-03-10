require('plugins')
require('set')
vim.g.mapleader = ' '
-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- OR setup with some options
vim.cmd('autocmd Colorscheme * highlight NvimTreeNormal guibg=#1e1e1e guifg=#9da5b3')
vim.cmd('autocmd Colorscheme * highlight NvimTreeBorder guibg=#1e1e1e guifg=#9da5b3')
vim.cmd('autocmd Colorscheme * highlight TelescopeNormal guibg=#1e1e1e guifg=#9da5b3')
vim.cmd('autocmd Colorscheme * highlight TelescopeBorder guibg=#1e1e1e guifg=#9da5b3')
vim.cmd('autocmd Colorscheme * highlight NoiceCmdlinePopup guibg=#1e1e1e guifg=#9da5b3')
vim.cmd('autocmd Colorscheme * highlight NoicePopup guibg=#1e1e1e guifg=#9da5b3')
vim.cmd('autocmd Colorscheme * highlight NoicePopupmenu guibg=#1e1e1e guifg=#9da5b3')
vim.cmd('autocmd Colorscheme * highlight NoiceConfirm guibg=#1e1e1e guifg=#9da5b3')
vim.cmd('autocmd Colorscheme * highlight NoiceMini guibg=#1e1e1e guifg=#9da5b3')

vim.cmd('colorscheme xcodedarkhc')
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "*" },
    command = [[:NvimTreeClose]]
})

vim.g.markdown_fenced_languages = {
  "ts=typescript"
}

