vim.cmd [[packadd packer.nvim]]
return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
    use {'theHamsta/nvim-dap-virtual-text', config = function ()
        require("nvim-dap-virtual-text").setup {
            virt_text_pos = 'eol',
            virt_text_win_col = nil,
            highlight_changed_variables = true,
            show_stop_reason = false,
        }
    end}
    use('nvim-treesitter/playground')
    use('mbbill/undotree')
    use {
        'VonHeikemen/lsp-zero.nvim',
        requires = {
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },
            { 'L3MON4D3/LuaSnip' },
        }
    }
    use {
        "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons"
    }
    use { "williamboman/mason.nvim" }
    use { "xiyaowong/transparent.nvim" }
    use {
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons',
        },
        tag = 'nightly'
    }
    use { 'feline-nvim/feline.nvim' }
    use {
        'saecki/crates.nvim',
        tag = 'v0.3.0',
        requires = { 'nvim-lua/plenary.nvim' },
        config = function()
            require('crates').setup()
        end,
    }
    use { 'simrat39/rust-tools.nvim' }
    use({'scalameta/nvim-metals', requires = { "nvim-lua/plenary.nvim" }})
    use { 'jose-elias-alvarez/null-ls.nvim' }
    use { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } }
    use {
        'dinhhuy258/git.nvim',
        config = function()
            require('git').setup()
        end
    }
    use "sts10/vim-pink-moon"
    use "ThePrimeagen/lsp-debug-tools.nvim"
    use "ziglang/zig.vim"
end)
