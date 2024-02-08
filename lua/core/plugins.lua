local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
    'ellisonleao/gruvbox.nvim',
    'folke/tokyonight.nvim',
    'sonph/onehalf',
    'nvim-lualine/lualine.nvim',
    'nvim-treesitter/nvim-treesitter',
    "williamboman/mason.nvim",
    "neovim/nvim-lspconfig",
    "williamboman/mason-lspconfig.nvim",
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-nvim-lsp',
    {
        "L3MON4D3/LuaSnip",
        -- follow latest release.
        version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!).
        build = "make install_jsregexp"
    },
    'saadparwaiz1/cmp_luasnip',
    "rafamadriz/friendly-snippets",
    "github/copilot.vim",
    "ggandor/leap.nvim",
    "nvim-tree/nvim-web-devicons",
    "nvim-treesitter/playground",
    'MunifTanjim/nui.nvim',
    "nvim-lua/plenary.nvim",
    {
        "mfussenegger/nvim-dap",
        lazy = true,
        module = { "dap" },
        dependencies = {
            { "theHamsta/nvim-dap-virtual-text", module = { "nvim-dap-virtual-text" } },
            { "rcarriga/nvim-dap-ui", module = { "dapui" } },
            { "mfussenegger/nvim-dap-python", module = { "dap-python" } },
            { "nvim-telescope/telescope-dap.nvim" },
            { "leoluz/nvim-dap-go", module = "dap-go" },
            { "jbyuki/one-small-step-for-vimkind", module = "osv" },
            { "mxsdev/nvim-dap-vscode-js", module = { "dap-vscode-js" } },
            {
                "microsoft/vscode-js-debug",
                lazy = true,
                build = "npm install --legacy-peer-deps && npm run compile",
                enabled = true,
            },
        },
        config = function()
            require("core.plugin_config.dap").setup()
        end,
        disabled = false
    },
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.4',
        dependencies = { {'nvim-lua/plenary.nvim'} }
    },
    {
        "jackMort/ChatGPT.nvim",
        event = "VeryLazy",
        config = function()
            local home = vim.fn.expand("$HOME")
            require("chatgpt").setup({ api_key_cmd = "cat " .. vim.fn.expand("$HOME") .. "/nothingherelaala" })
        end,
        dependencies = {
            "MunifTanjim/nui.nvim",
            "nvim-lua/plenary.nvim",
        }
    },
    { "nvim-treesitter/nvim-treesitter-textobjects", dependencies = "nvim-treesitter/nvim-treesitter", },
    { "nvim-telescope/telescope-file-browser.nvim", dependencies = {  "nvim-lua/plenary.nvim" } },
    { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
    { "hrsh7th/cmp-path" },
    -- { "TabbyML/vim-tabby" },
    { "tpope/vim-fugitive" },
    { "folke/neodev.nvim", opts = {} },
    {
        "ray-x/lsp_signature.nvim",
        event = "VeryLazy",
        opts = {},
    },
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { {"nvim-lua/plenary.nvim"} }
    },
    { "bluz71/vim-nightfly-colors", name = "nightfly", lazy = false, priority = 1000 },
    --{ "zbirenbaum/copilot.lua" },
    {"rebelot/kanagawa.nvim"},
    {'norcalli/nvim-colorizer.lua'},
    {'rcarriga/nvim-notify'},
}

local opts = {}

require("lazy").setup(plugins, opts)





