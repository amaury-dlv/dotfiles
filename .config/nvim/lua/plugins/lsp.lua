-- LSP configuration with Mason and ty support
return {
  "neovim/nvim-lspconfig",
  dependencies = {
    -- Automatically install LSPs and related tools to stdpath for Neovim
    { "mason-org/mason.nvim", opts = {} },
    "mason-org/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    { "j-hui/fidget.nvim", opts = {} }, -- Useful status updates for LSP.
    "saghen/blink.cmp", -- Allows extra capabilities provided by blink.cmp
  },
  config = function()
    -- LSP servers to install via Mason
    local servers = {
      lua_ls = {
        settings = {
          Lua = {
            diagnostics = { globals = { 'vim' } },
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
          },
        },
      },
    }

    -- Setup mason-tool-installer to auto-install servers
    require('mason-tool-installer').setup({
      ensure_installed = vim.tbl_keys(servers),
    })

    -- LSP attach function for keybindings
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc)
          vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

        map('K', vim.lsp.buf.hover, 'Hover Documentation')
        map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
        map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
        map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

        -- Highlight references under cursor
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client.server_capabilities.documentHighlightProvider then
          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = event.buf,
            callback = vim.lsp.buf.document_highlight,
          })
          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = event.buf,
            callback = vim.lsp.buf.clear_references,
          })
        end
      end,
    })

    -- Get capabilities from blink.cmp
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('blink.cmp').get_lsp_capabilities(capabilities)

    -- Setup mason-lspconfig to auto-configure servers
    require('mason-lspconfig').setup({
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
          require('lspconfig')[server_name].setup(server)
        end,
      },
    })

    -- Manually configure ty (not available via Mason)
    local configs = require('lspconfig.configs')
    if not configs.ty then
      configs.ty = {
        default_config = {
          cmd = { 'ty', 'server' },
          filetypes = { 'python' },
          root_dir = function(fname)
            return require('lspconfig.util').root_pattern('.git', 'pyproject.toml', 'setup.py')(fname)
              or vim.fn.fnamemodify(fname, ':h')
          end,
          settings = {},
        },
      }
    end
    require('lspconfig').ty.setup({
      capabilities = capabilities,
    })
  end,
}
