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
}

local function setupServers()
  local lspconfig = require 'lspconfig'

  -- Lua の言語サーバの設定
  lspconfig.lua_ls.setup {
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
  lspconfig.tsserver.setup {}
end

local function setupCompletion(keys)
  local cmp = require 'cmp'

  cmp.setup {
    mapping = cmp.mapping.preset.insert {
      [keys.nextItem] = cmp.mapping.select_next_item(),
      [keys.prevItem] = cmp.mapping.select_prev_item(),
      [keys.abort] = cmp.mapping.abort(),
    },

    sources = cmp.config.sources {
      { name = 'nvim_lsp' },
    },
  }
end

local function registerHoverAction(key)
  vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if client.server_capabilities.hoverProvider then
        vim.keymap.set('n', key, vim.lsp.buf.hover, { buffer = args.buf })
      end
    end,
  })
end

return {
  plugins = plugins,
  setupServers = setupServers,
  setupCompletion = setupCompletion,
  registerHoverAction = registerHoverAction,
}
