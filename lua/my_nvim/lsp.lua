---@class LspActionKeymaps
---@field definition string
---@field format string
---@field hover string
---@field references string

---@class LspCompletionKeymaps
---@field next_item string
---@field prev_item string
---@field abort string
---@field confirm string

---@class DiagnosticsKeymaps
---@field open_float string
---@field goto_next string
---@field goto_prev string

---@class LspKeymaps
---@field action LspActionKeymaps
---@field completion LspCompletionKeymaps
---@field diagnostics DiagnosticsKeymaps

---@param keys LspKeymaps
return function(keys)
  return {
    {
      'neovim/nvim-lspconfig',
      lazy = false,
      dependencies = { 'jose-elias-alvarez/null-ls.nvim' },
      config = function()
        local lsp_config = require 'lspconfig'
        local null_ls = require 'null-ls'

        lsp_config.lua_ls.setup {
          settings = {
            Lua = {
              runtime = { version = 'LuaJIT' },
              diagnostics = {
                globals = { 'vim' },
              },
              workspace = {
                library = vim.api.nvim_get_runtime_file('', true),
                checkThirdParty = false,
              },
              telemetry = {
                enable = false,
              },
            },
          },
        }

        lsp_config.tsserver.setup {}
        lsp_config.clangd.setup {}
        lsp_config.bashls.setup {}
        lsp_config.ocamllsp.setup {}

        null_ls.setup {
          sources = {
            null_ls.builtins.diagnostics.eslint,

            null_ls.builtins.formatting.stylua,
            null_ls.builtins.formatting.eslint,
            null_ls.builtins.formatting.prettier,
          },
        }

        vim.api.nvim_create_autocmd('LspAttach', {
          callback = function(args)
            local client = vim.lsp.get_client_by_id(args.data.client_id)

            if client.server_capabilities.hoverProvider then
              vim.keymap.set('n', keys.action.hover, vim.lsp.buf.hover, { buffer = args.buf })
            end

            if client.server_capabilities.definitionProvider then
              vim.keymap.set('n', keys.action.definition, vim.lsp.buf.definition, { buffer = args.buf })
            end

            if client.server_capabilities.referencesProvider then
              vim.keymap.set('n', keys.action.references, vim.lsp.buf.references, { buffer = args.buf })
            end

            vim.keymap.set('n', keys.action.format, function()
              vim.lsp.buf.format { async = true }
            end, { buffer = args.buf })
          end,
        })

        vim.api.nvim_set_keymap(
          'n',
          keys.diagnostics.open_float,
          ':lua vim.diagnostic.open_float { border = \'single\' }<CR>',
          { noremap = true, silent = true }
        )

        vim.api.nvim_set_keymap(
          'n',
          keys.diagnostics.goto_next,
          ':lua vim.diagnostic.goto_next()<CR>',
          { noremap = true, silent = true }
        )

        vim.api.nvim_set_keymap(
          'n',
          keys.diagnostics.goto_prev,
          ':lua vim.diagnostic.goto_prev()<CR>',
          { noremap = true, silent = true }
        )
      end,
    },

    {
      'hrsh7th/nvim-cmp',
      event = { 'InsertEnter', 'CmdlineEnter' },
      dependencies = {
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-cmdline',
        'hrsh7th/cmp-emoji',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-path',
      },
      config = function()
        local cmp = require 'cmp'

        cmp.setup {
          snippet = {
            expand = function(args)
              vim.fn['vsnip#anonymous'](args.body)
            end,
          },

          mapping = cmp.mapping.preset.insert {
            [keys.completion.next_item] = cmp.mapping.select_next_item(),
            [keys.completion.prev_item] = cmp.mapping.select_prev_item(),
            [keys.completion.abort] = cmp.mapping.abort(),
            [keys.completion.confirm] = cmp.mapping.confirm { select = true },
          },

          sources = cmp.config.sources {
            { name = 'buffer' },
            { name = 'emoji' },
            { name = 'nvim_lsp' },
            { name = 'path' },
          },
        }

        cmp.setup.cmdline(':', {
          mapping = cmp.mapping.preset.cmdline(),
          sources = cmp.config.sources {
            { name = 'cmdline' },
            { name = 'path' },
          },
        })
      end,
    },

    {
      'jose-elias-alvarez/null-ls.nvim',
      dependencies = {
        'nvim-lua/plenary.nvim',
      },
    },

    { 'hrsh7th/vim-vsnip', lazy = false },
  }
end
