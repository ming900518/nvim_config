return require('pckr').add{
    'wbthomason/packer.nvim';
    {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'};
    'mbbill/undotree';
    'neovim/nvim-lspconfig';
    'hrsh7th/nvim-cmp';
    'hrsh7th/cmp-buffer';
    'hrsh7th/cmp-path';
    'saadparwaiz1/cmp_luasnip';
    'hrsh7th/cmp-nvim-lsp';
    'hrsh7th/cmp-nvim-lua';
    'L3MON4D3/LuaSnip';
    'folke/trouble.nvim';
    'kyazdani42/nvim-web-devicons';
    'williamboman/mason.nvim';
    'xiyaowong/transparent.nvim';
    'nvim-tree/nvim-tree.lua';
    'nvim-tree/nvim-web-devicons';
    {
        'saecki/crates.nvim',
        tag = 'v0.3.0',
        requires = { 'nvim-lua/plenary.nvim' },
        config = function()
            require('crates').setup()
        end
    };
    {
        'dinhhuy258/git.nvim',
        config = function()
            require('git').setup()
        end
    };
    'sts10/vim-pink-moon';
    'mrcjkb/rustaceanvim';
    'MunifTanjim/nougat.nvim';
}
