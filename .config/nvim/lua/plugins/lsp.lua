return {
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "rafamadriz/friendly-snippets",
        },
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")
            require("luasnip/loaders/from_vscode").lazy_load()

            cmp.setup({
                completion = {
                    completeopt = "menu,menuone,preview,noselect",
                },
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                mapping = {
                    ["<C-k>"] = cmp.mapping.select_prev_item(),
                    ["<C-j>"] = cmp.mapping.select_next_item(),
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-c>"] = cmp.mapping.close(),
                    ["<Esc>"] = cmp.mapping.close(),
                    ["<CR>"] = cmp.mapping.confirm({
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = true,
                    }),
--                    ["<Tab>"] = cmp.mapping.confirm({
--                        behavior = cmp.ConfirmBehavior.Replace,
--                        select = true,
--                    }),
                    --["<Tab>"] = cmp.mapping(function(fallback)
                    --    if cmp.visible() then
                    --        cmp.select_next_item()
                    --    elseif luasnip.expand_or_jumpable() then
                    --        luasnip.expand_or_jump()
                    --    else
                    --        fallback()
                    --    end
                    --end, { "i", "s" }),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                },
                sources = {
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "path" },
                    { name = "buffer" },
                },
            })
        end,
    },
    {
        "williamboman/mason.nvim",
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
        },
        config = function()
            local mason = require("mason")
            local mason_lspconfig = require("mason-lspconfig")
            mason.setup({
                PATH = "prepend",
            })

            mason_lspconfig.setup({
                ensure_installed = {
                    "lua_ls",
                    "html",
                    "cssls",
                    "pyright",
                    "rust_analyzer",
                    "clangd",
                    "jsonls",
                },
                automatic_installation = true,
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        event = {"BufReadPre", "BufNewFile"},
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            {"antosha417/nvim-lsp-file-operations", opts = {}},
            {"j-hui/fidget.nvim", opts = {}},
        },
        config = function()
            local lspconfig = require("lspconfig")
            local cmp_nvim_lsp = require("cmp_nvim_lsp")
            local opts = { noremap = true, silent = true }
            local lsp_attach = function(client, bufnr)
                opts.buffer = bufnr

                vim.keymap.set('n', '<leader>', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
                vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
                vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
                vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
                vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
                vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
                vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
                vim.keymap.set('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
                vim.keymap.set({'n', 'x'}, '<leader>fm', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
                vim.keymap.set('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
            end

            local capabilities = cmp_nvim_lsp.default_capabilities()

            local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
            for type, icon in pairs(signs) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
            end

            lspconfig.lua_ls.setup({
                capabilities = capabilities,
                on_attach = lsp_attach,
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = {'vim'},
                        },
                        workspace = {
                            library = {
                                [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                                [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
                            },
                        },
                    },
                },
            })
            lspconfig.ts_ls.setup({
                capabilities = capabilities,
                on_attach = lsp_attach,
            })
            lspconfig.html.setup({
                capabilities = capabilities,
                on_attach = lsp_attach,
            })
            lspconfig.cssls.setup({
                capabilities = capabilities,
                on_attach = lsp_attach,
            })
            lspconfig.pyright.setup({
                capabilities = capabilities,
                on_attach = lsp_attach,
            })
            lspconfig.rust_analyzer.setup({
                capabilities = capabilities,
                on_attach = lsp_attach,
                settings = {
                    ["rust-analyzer"] = {
                        assist = {
                            importEnforceStyle = "Block",
                        },
                        diagnostics = {
                            disabled = {
                                "unresolved-import",
                            },
                        },
                    },
                    cargo = {
                        loadOutDirsFromCheck = true,
                    },
                },
            })
            lspconfig.clangd.setup({
                capabilities = capabilities,
                on_attach = lsp_attach,
            })
            lspconfig.jsonls.setup({
                capabilities = capabilities,
                on_attach = lsp_attach,
            })

        end,
    },
}
