local usePlugins = function(use)
  -- LSP 設定集
  use 'neovim/nvim-lspconfig'

  -- 補完
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/nvim-cmp'
end

local setupServers = function()
  local lspconfig = require 'lspconfig'

  -- Lua の言語サーバの設定
  lspconfig.lua_ls.setup {
    settings = {
      Lua = {
        -- 使用するランタイムのバージョンは LuaJIT
        runtime = { version = "LuaJIT" },

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

local setupCompletion = function()
  local cmp = require 'cmp'

  cmp.setup {
    mapping = cmp.mapping.preset.insert {
      ['<Tab>'] = cmp.mapping.select_next_item(),
      ['<S-Tab>'] = cmp.mapping.select_prev_item(),
      ['<C-e>'] = cmp.mapping.abort(),
    },

    sources = cmp.config.sources {
      { name = 'nvim_lsp' },
    },
  }
end

return {
  usePlugins = usePlugins,
  setupServers = setupServers,
  setupCompletion = setupCompletion,
}
