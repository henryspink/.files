
local colors = {
  blue   = '#80a0ff',
  cyan   = '#79dac8',
  black  = '#080808',
  white  = '#c6c6c6',
  red    = '#dd4c4c',
  violet = '#d183e8',
  grey   = '#303030',
}

local bubbles_theme = {
  normal = {
    a = { fg = colors.black, bg = colors.red },
    b = { fg = colors.white, bg = colors.grey },
    c = { fg = colors.white },
  },

  insert = { a = { fg = colors.black, bg = colors.red } },
  visual = { a = { fg = colors.black, bg = colors.red } },
  replace = { a = { fg = colors.black, bg = colors.red } },

    inactive = {
        a = { fg = colors.white, bg = colors.black },
        b = { fg = colors.white, bg = colors.black },
        c = { fg = colors.white },
    },
}

return {
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            icons = {
                mappings = true,
                keys = {},
            },
            spec = {
                { '<leader>c', group = '[C]ode', mode = { 'n', 'x' } },
                { '<leader>d', group = '[D]ocument' },
                { '<leader>r', group = '[R]ename' },
                { '<leader>s', group = '[S]earch' },
                { '<leader>w', group = '[W]orkspace' },
                { '<leader>t', group = '[T]oggle' },
                { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
            },
        },
        keys = {
            {
                "<leader>?",
                function()
                    require("which-key").show({ global = false })
                end,
                desc = "Buffer Local Keymaps (which-key)",
            },
        },
    },
    {
        "supermaven-inc/supermaven-nvim",
        opts = {},
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function ()
            local configs = require("nvim-treesitter.configs")

            require('nvim-treesitter.install').prefer_git = false
            require('nvim-treesitter.install').compilers = { 'clang' }

            configs.setup({
                ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "elixir", "heex", "javascript", "html" },
                auto_install = true,
                sync_install = false,
                highlight = { enable = true },
                indent = { enable = true },
            })
        end
    },
    {
        'akinsho/bufferline.nvim',
        version = "*",
        dependencies = 'nvim-tree/nvim-web-devicons',
        opts = {
            options = {
                buffer_close_icon = '',
                indicator = {
                    style = 'underline',
                    color = '#dd4c4c',
                },
                offsets = {
                    {
                        filetype = "NvimTree",
                        text = "File Explorer",
                        text_align = "right",
                        separator = true
                    },
                },
            }
        }
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
        cmd = 'Neotree',
        keys = {
            { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
        },
        opts = {
            filesystem = {
                window = {
                    mappings = {
                        ['\\'] = 'close_window',
                    },
                },
            },
        },
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        opts = {
            options = {
                theme = bubbles_theme,
                component_separators = '',
                section_separators = { left = '', right = '' },
            },
            sections = {
                lualine_a = { { 'mode', separator = { left = '' }, right_padding = 2 } },
                lualine_b = { 'filename', 'branch' },
                lualine_c = {
                    '%=', --[[ add your center compoentnts here in place of this comment ]]
                },
                lualine_x = {},
                lualine_y = { 'filetype', 'progress' },
                lualine_z = {
                    { 'location', separator = { right = '' }, left_padding = 2 },
                },
            },
            inactive_sections = {
                lualine_a = { 'filename' },
                lualine_b = {},
                lualine_c = {},
                lualine_x = {},
                lualine_y = {},
                lualine_z = { 'location' },
            },
            tabline = {},
            extensions = {},
        }
    },
    {
        "okuuva/auto-save.nvim",
        cmd = "ASToggle",
        event = { "InsertLeave", "TextChanged" },
        opts = {},
    },
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" }
    },
    {
        "nvim-neorg/neorg",
        lazy = false,
        version = "*",
        config = true,
    },
    {
        "debugloop/telescope-undo.nvim",
        dependencies = {
            {
                "nvim-telescope/telescope.nvim",
                dependencies = { "nvim-lua/plenary.nvim" },
            },
        },
        keys = {
            {
                "<leader>u",
                "<cmd>Telescope undo<cr>",
                desc = "undo history",
            },
        },
        opts = {},
        config = function(_, opts)
            require("telescope").setup(opts)
            require("telescope").load_extension("undo")
        end,
    },
    {
        "tpope/vim-fugitive",
        config = function()
            vim.keymap.set('n', '<leader>gs', vim.cmd.Git)
        end
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            require('nvim-autopairs').setup {
                enable_check_bracket_line = false,
                fast_wrap = {},
            }
            local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
            local cmp = require 'cmp'
            cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
        end,
    },
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
        },
        opts = {
            defaults = {
                mappings = {
                    i = {
                        ["<esc>"] = require('telescope.actions').close,
                    },	
                },
                extensions_list = {
                    "fzf",
                    "file_browser",
                    "frecency",
                    "bookmarks",
                    "project",
                    "live_grep",
                    "hlslens",
                    "spell_suggest",
                    "buffers",
                    "help",
                },
            }
        },
    },
    {
        "stevearc/dressing.nvim",
        event = "VeryLazy",
    },
}
