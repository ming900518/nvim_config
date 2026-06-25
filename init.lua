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
vim.g.mapleader = ' '
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.cmd('set clipboard+=unnamedplus')
vim.cmd('set encoding=utf-8')
vim.cmd('set winborder=rounded')
vim.cmd('set ve=all')
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
vim.cmd.colorscheme 'pink-moon'

vim.g.markdown_fenced_languages = {
    "ts=typescript"
}

vim.api.nvim_create_autocmd("UIEnter", {
  callback = function()
    require("yazi").setup({
      open_for_directories = true,
    })
  end,
})

vim.keymap.set("n", "<leader>fe", function() require("yazi").yazi() end)
vim.keymap.set("n", "<leader>fm", function() vim.lsp.buf.format({ async = true }) end)
vim.keymap.set("n", "<leader>hh", function() vim.lsp.inlay_hint(0) end)
vim.keymap.set("n", "<leader>hv", function() vim.lsp.buf.hover() end)
vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end)
vim.keymap.set("n", "<leader>rf", function() vim.lsp.buf.references() end)
vim.keymap.set("n", "<leader>td", function() vim.lsp.buf.type_definition() end)vim.keymap.set("n", "<C-z>", vim.cmd.UndotreeToggle)

vim.diagnostic.config({
    update_in_insert = true,
    virtual_text = { severity = { vim.diagnostic.severity.WARN, vim.diagnostic.severity.INFO, vim.diagnostic.severity.HINT } },
    virtual_lines = { severity = { vim.diagnostic.severity.ERROR } },
    underline = false,
    signs = true,
    severity_sort = true,
})

local signs = { Error = "", Warn = "", Hint = "", Info = "" }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end


vim.opt.nu = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.wrap = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.updatetime = 50
vim.opt.colorcolumn = "0"

vim.opt.cmdheight = 0
vim.opt.laststatus = 3
vim.opt.pumheight = 10

vim.api.nvim_set_hl(0, "CmpBlack", { bg = "#000000" })

vim.lsp.config['ts_ls'] = {
    on_attach = function(client)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
    end,
    settings = {
        typescript = {
            inlayHints = {
                includeInlayParameterNameHints = 'all',
                includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayVariableTypeHintsWhenTypeMatchesName = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
            }
        },
        javascript = {
            inlayHints = {
                includeInlayParameterNameHints = 'all',
                includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayVariableTypeHintsWhenTypeMatchesName = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
            }
        }
    },
    root_markers = { "package.json", "./package.json" },
    single_file_support = true
}

vim.lsp.enable('ts_ls')

vim.lsp.config['html'] = {
    filetypes = {
        "html",
    }
}

vim.lsp.enable('html')
