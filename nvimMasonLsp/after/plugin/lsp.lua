local lsp = require('lsp-zero')
local cmp_action = lsp.cmp_action()

lsp.preset({
    name = "recommended",
})

lsp.ensure_installed({
    "rust_analyzer",
    "tsserver",
    "eslint",
    "jsonls",
    "yamlls",
    "html",
    "cssls",
    "lua_ls",
})

-- Fix Undefined global 'vim'
lsp.configure('lua_ls', {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            }
        }
    }
})
lsp.configure('jsonls', {
    settings = {
        json = {
            schemas = require('schemastore').json.schemas(),
            format = {
                enable = true,
            },
            validate = {
                enable = true,
            }
        }
    }
})

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<S-Tab>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<Tab>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-k>'] = cmp.mapping.confirm({
        -- documentation says this is important.
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
    }),
    ["<C-Space>"] = cmp.mapping.complete(),
    -- scroll up and down in the completion documentation
    ['<C-d>'] = cmp.mapping.scroll_docs(5),
    ['<C-u>'] = cmp.mapping.scroll_docs(-5),
    ['<C-f>'] = cmp_action.luasnip_jump_forward(),
    ['<C-b>'] = cmp_action.luasnip_jump_backward(),
})
require('luasnip.loaders.from_vscode').lazy_load()

lsp.setup_nvim_cmp({
    sources = {
        { name = "path" },
        { name = "nvim_lsp" },
        { name = "copilot" },
        { name = "buffer",  keyword_length = 3 },
        { name = "luasnip" },
    },
    mapping = cmp_mappings
})

lsp.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>rr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
    vim.keymap.set("n", "<leader>fm", function() vim.lsp.buf.format({ async = false, timeout_ms = 10000 }) end, opts)
end)

lsp.format_on_save({
    format_opts = {
        timeout_ms = 10000,
    },
    servers = {
        ['lua_ls'] = { 'lua' },
        ['rust_analyzer'] = { 'rust' },
        ['tsserver'] = { 'typescript', 'typescriptreact', 'typescript.tsx', 'javascript', 'javascriptreact',
            'javascript.jsx' },
        ['jsonls'] = { 'json' },
        ['yamlls'] = { 'yaml' },
        ['html'] = { 'html' },
        ['cssls'] = { 'css', 'scss', 'less' },
    }
})

lsp.setup()

vim.diagnostic.config({
    virtual_text = true
})
