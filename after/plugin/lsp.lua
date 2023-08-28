local lsp = require('lsp-zero')
lsp.preset('recommended')
lsp.ensure_installed({
    'rust_analyzer',
    'tsserver',
    'tailwindcss',
    'html',
    'jdtls',
})
local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<Up>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<Down>'] = cmp.mapping.select_next_item(cmp_select),
    ['<CR>'] = cmp.mapping.confirm({ select = false }),
    ['<C-Space>'] = cmp.mapping.complete(),
})

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
vim.lsp.diagnostic.on_publish_diagnostics,
{
    update_in_insert = true,
    virtual_text = true
}
)

-- local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
local signs = { Error = "", Warn = "", Hint = "", Info = "" }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

local root_pattern = require('lspconfig.util').root_pattern

lsp.configure('tsserver', {
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
    root_dir = root_pattern("package.json", "./package.json"),
    single_file_support = false
})

lsp.configure('html', {
    filetypes = {
        "html",
    }
})

lsp.configure('tailwindcss', {
    filetypes = {
        "css",
        "scss",
        "sass",
        "postcss",
        "html",
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "svelte",
        "vue",
        "rust",
    },
    init_options = {
        userLanguages = {
            rust = "html",
        },
    },
    root_dir = require 'lspconfig'.util.root_pattern('tailwind.config.js', 'tailwind.config.ts', 'postcss.config.js',
    'postcss.config.ts', 'windi.config.ts'),
})

local null_ls = require('null-ls')

local null_opts = lsp.build_options('null-ls', {
    on_attach = function(client, bufnr)
        if client.supports_method "textDocument/formatting" then
            vim.api.nvim_create_autocmd("BufWritePre", {
                desc = "Auto format before save",
                pattern = "<buffer>",
                callback = function()
                    vim.lsp.buf.format({
                        bufnr = bufnr,
                        filter = function(filter_client)
                            return filter_client.name == "null-ls"
                        end
                    })
                end,
            })
        end
    end
})

null_ls.setup({
    on_attach = null_opts.on_attach,
    sources = {
        null_ls.builtins.formatting.rustfmt,
        null_ls.builtins.formatting.prettierd.with({
            env = {
                PRETTIERD_DEFAULT_CONFIG = vim.fn.expand("~/.config/nvim/after/plugin/prettierd.json"),
            },
        })
    }
})

lsp.set_preferences({
    sign_icons = {}
})
lsp.setup_nvim_cmp({
    mapping = cmp_mappings
})

lsp.setup()
vim.keymap.set("n", "<leader>fm", function() vim.lsp.buf.format({ async = true }) end)
vim.keymap.set("n", "<leader>hh", function() vim.lsp.inlay_hint(0) end)
vim.keymap.set("n", "<leader>hv", function() vim.lsp.buf.hover() end)
vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end)
vim.keymap.set("n", "<leader>rf", function() vim.lsp.buf.references() end)
vim.keymap.set("n", "<leader>td", function() vim.lsp.buf.type_definition() end)
