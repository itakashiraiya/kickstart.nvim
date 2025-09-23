return {
  -- cmd = { ... },
  -- filetypes = { ...},
  -- capabilities = {},
  settings = {
    Lua = {
      workspace = {
        library = {
          vim.fn.expand '/usr/local/share/lua/5.4',
          vim.fn.expand '~/dev/lua/packages',
        },
        checkThirdParty = false,
      },
      completion = {
        callSnippet = 'Replace',
      },
      -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
      -- diagnostics = { disable = { 'missing-fields' } },
    },
  },
}
