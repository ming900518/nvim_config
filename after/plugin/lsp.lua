local lsp = require('lsp-zero')
require('mason').setup({})

vim.g.rustaceanvim = {
    server = {
        capabilities = require('cmp_nvim_lsp').default_capabilities(),
        default_settings = {
            ['rust-analyzer'] = {
                diagnostics = {
                    enable = true,
                    disabled = { "unresolved-proc-macro", "macro-error" },
                }
            },
        }
    },
}

local noop = function() end

require('mason-lspconfig').setup({
    ensure_installed = { 'lua_ls', 'ts_ls', 'tailwindcss', 'html' },
    handlers = {
        function(server_name)
            require('lspconfig')[server_name].setup({})
        end,
        rust_analyzer = noop,
    }
})
local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    {
        update_in_insert = true,
        virtual_text = true,
        underline = false
    }
)

-- local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
local signs = { Error = "", Warn = "", Hint = "", Info = "" }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

local root_pattern = require('lspconfig.util').root_pattern

lsp.configure('ts_ls', {
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
    single_file_support = true
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
        "astro"
    },
    init_options = {
        userLanguages = {
            rust = "html",
        },
    },
    root_dir = require 'lspconfig'.util.root_pattern('tailwind.config.js', 'tailwind.config.ts', 'postcss.config.js',
        'postcss.config.ts', 'windi.config.ts', 'tailwindcss'),
})

vim.api.nvim_set_hl(0, "CmpBlack", { bg = "#000000" })

cmp.setup({
    sources = {
        { name = 'nvim_lsp' },
        { name = 'buffer' },
    },
    mapping = cmp.mapping.preset.insert({
        ['<Up>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<Down>'] = cmp.mapping.select_next_item(cmp_select),
        ['<CR>'] = cmp.mapping.confirm({ select = false }),
        ['<C-Space>'] = cmp.mapping.complete(),
    }),
    window = {
        completion = {
            border = "rounded",
            winhighlight = "Normal:CmpBlack",
        },
        documentation = {
            border = "rounded",
            winhighlight = "Normal:CmpBlack",
        }
    }
})

lsp.setup()

vim.lsp.config("rustomorin-analyzer", {
    cmd = { "/Users/chisakikirino/.cargo/bin/rustomorin-analyzer" },
    root_markers = { "Cargo.toml" },
    filetypes = { "rust" }
});
vim.lsp.enable('rustomorin-analyzer');

vim.keymap.set("n", "<leader>fm", function() vim.lsp.buf.format({ async = true }) end)
vim.keymap.set("n", "<leader>hh", function() vim.lsp.inlay_hint(0) end)
vim.keymap.set("n", "<leader>hv", function() vim.lsp.buf.hover() end)
vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end)
vim.keymap.set("n", "<leader>rf", function() vim.lsp.buf.references() end)
vim.keymap.set("n", "<leader>td", function() vim.lsp.buf.type_definition() end)
