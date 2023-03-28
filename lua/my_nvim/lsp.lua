local plugins = {
  -- LSP 設定集
  'neovim/nvim-lspconfig',

  -- 補完
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
    },
  },

  {
    'jose-elias-alvarez/null-ls.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
  },

  { 'hrsh7th/vim-vsnip', lazy = false },
}

local function setupServers()
  local lspConfig = require 'lspconfig'
  local nullLs = require 'null-ls'

  -- Lua の言語サーバの設定
  lspConfig.lua_ls.setup {
    settings = {
      Lua = {
        -- 使用するランタイムのバージョンは LuaJIT
        runtime = { version = 'LuaJIT' },
        diagnostics = {
          -- vim をグローバル変数として認識させる
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

  -- TypeScript の言語サーバの設定
  lspConfig.tsserver.setup {}

  -- C/C++ の言語サーバの設定
  lspConfig.clangd.setup {}

  -- シェルスクリプトの言語サーバの設定
  lspConfig.bashls.setup {}

  nullLs.setup {
    sources = {
      nullLs.builtins.diagnostics.eslint,

      nullLs.builtins.formatting.stylua,
      nullLs.builtins.formatting.eslint,
      nullLs.builtins.formatting.prettier,
    },
  }
end

---@class LspCompletionKeymaps
---@field nextItem string
---@field prevItem string
---@field abort string
---@field confirm string

--- @param keys LspCompletionKeymaps
local function setupCompletion(keys)
  local cmp = require 'cmp'

  cmp.setup {
    snippet = {
      expand = function(args)
        vim.fn['vsnip#anonymous'](args.body)
      end,
    },

    mapping = cmp.mapping.preset.insert {
      [keys.nextItem] = cmp.mapping.select_next_item(),
      [keys.prevItem] = cmp.mapping.select_prev_item(),
      [keys.abort] = cmp.mapping.abort(),
      [keys.confirm] = cmp.mapping.confirm { select = true },
    },

    sources = cmp.config.sources {
      { name = 'nvim_lsp' },
    },
  }
end

---@class LspActionKeymaps
---@field definition string
---@field format string
---@field hover string
---@field references string

---@param keys LspActionKeymaps
local function setKeymaps(keys)
  vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)

      if client.server_capabilities.hoverProvider then
        vim.keymap.set('n', keys.hover, vim.lsp.buf.hover, { buffer = args.buf })
      end

      if client.server_capabilities.definitionProvider then
        vim.keymap.set('n', keys.definition, vim.lsp.buf.definition, { buffer = args.buf })
      end

      if client.server_capabilities.referencesProvider then
        vim.keymap.set('n', keys.references, vim.lsp.buf.references, { buffer = args.buf })
      end

      vim.keymap.set('n', keys.format, function()
        vim.lsp.buf.format { async = true }
      end, { buffer = args.buf })
    end,
  })
end

return {
  plugins = plugins,
  setupServers = setupServers,
  setupCompletion = setupCompletion,
  setKeymaps = setKeymaps,
}
