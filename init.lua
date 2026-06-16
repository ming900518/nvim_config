local function bootstrap_pckr()
  local pckr_path = vim.fn.stdpath("data") .. "/pckr/pckr.nvim"

  if not (vim.uv or vim.loop).fs_stat(pckr_path) then
    vim.fn.system({
      'git',
      'clone',
      "--filter=blob:none",
      'https://github.com/lewis6991/pckr.nvim',
      pckr_path
    })
  end

  vim.opt.rtp:prepend(pckr_path)
end

bootstrap_pckr()

require('plugins')
require('set')
vim.g.mapleader = ' '
-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.cmd('set clipboard+=unnamedplus')
vim.cmd('set encoding=utf-8')
vim.cmd('set winborder=rounded')
vim.cmd('autocmd Colorscheme * highlight TelescopeNormal guibg=#1e1e1e guifg=#9da5b3')
vim.cmd('autocmd Colorscheme * highlight TelescopeBorder guibg=#1e1e1e guifg=#9da5b3')
vim.cmd('autocmd Colorscheme * highlight NoiceCmdlinePopup guibg=#1e1e1e guifg=#9da5b3')
vim.cmd('autocmd Colorscheme * highlight NoicePopup guibg=#1e1e1e guifg=#9da5b3')
vim.cmd('autocmd Colorscheme * highlight NoicePopupmenu guibg=#1e1e1e guifg=#9da5b3')
vim.cmd('autocmd Colorscheme * highlight NoiceConfirm guibg=#1e1e1e guifg=#9da5b3')
vim.cmd('autocmd Colorscheme * highlight NoiceMini guibg=#1e1e1e guifg=#9da5b3')
vim.cmd('autocmd Colorscheme * highlight LineNr guifg=#fcd3db')
vim.cmd('autocmd Colorscheme * highlight WinBar guibg=NONE')
vim.cmd('autocmd Colorscheme * highlight WinBarNC guibg=NONE')
vim.cmd('autocmd Colorscheme * highlight LspInlayHint guifg=#bc9ea4 gui=italic')
vim.cmd('ca w!! w !sudo -S tee "%"')
vim.opt.termguicolors = true
-- vim.cmd.colorscheme 'sonokai'
vim.cmd.colorscheme 'pink-moon'

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "*" },
    command = [[:NvimTreeClose]]
})

vim.g.markdown_fenced_languages = {
    "ts=typescript"
}
