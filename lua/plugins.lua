vim.cmd [[packadd packer.nvim]]
return require('packer').startup(function(use)
    use('wbthomason/packer.nvim')
    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
    use('mbbill/undotree')
    use('neovim/nvim-lspconfig')
    use('hrsh7th/nvim-cmp')
    use('hrsh7th/cmp-buffer')
    use('hrsh7th/cmp-path')
    use('saadparwaiz1/cmp_luasnip')
    use('hrsh7th/cmp-nvim-lsp')
    use('hrsh7th/cmp-nvim-lua')
    use('L3MON4D3/LuaSnip')
    use {
        "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons"
    }
    use("williamboman/mason.nvim")
    use("xiyaowong/transparent.nvim")
    use {
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons',
        },
    }
    use {
        'saecki/crates.nvim',
        tag = 'v0.3.0',
        requires = { 'nvim-lua/plenary.nvim' },
        config = function()
            require('crates').setup()
        end,
    }
    use('jose-elias-alvarez/null-ls.nvim')
    use {
        'dinhhuy258/git.nvim',
        config = function()
            require('git').setup()
        end
    }
    use("sts10/vim-pink-moon")
    use('mrcjkb/rustaceanvim')
    use('MunifTanjim/nougat.nvim')
end)
