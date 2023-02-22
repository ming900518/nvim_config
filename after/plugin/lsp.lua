local lsp = require('lsp-zero')
lsp.preset('recommended')
lsp.ensure_installed({
    'rust_analyzer',
    'denols',
    'tsserver'
})
lsp.skip_server_setup({ 'rust_analyzer' })
local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<Up>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<Down>'] = cmp.mapping.select_next_item(cmp_select),
    ['<E>'] = cmp.mapping.confirm({ select = true }),
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

if root_pattern("package.json", "./package.json") then
    lsp.skip_server_setup('denols')
    lsp.configure('tsserver', {
        on_attach = function(client)
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false
        end,
        root_dir = root_pattern("package.json", "./package.json"),
        single_file_support = false
    })
else
    lsp.configure('denols', {
        flags = {
            debounce_text_changes = 150,
        },
        filetypes = {
            'javascript',
            'javascriptreact',
            'javascript.jsx',
            'typescript',
            'typescriptreact',
            'typescript.tsx',
            'markdown',
        },
        single_file_support = false,
        init_options = {
            enable = true,
            lint = true,
            unstable = true
        },
    })
end

local rust_lsp = lsp.build_options('rust_analyzer', {
    single_file_support = false,
})

require('rust-tools').setup({ server = rust_lsp })

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
        null_ls.builtins.formatting.deno_fmt,
        null_ls.builtins.formatting.rustfmt,
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
