local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = vim.fn.stdpath 'cache' .. '/jdtls/' .. project_name
return {
  cmd = { 'jdtls' },
  -- cmd = function()
  --   local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
  --   local workspace_dir = vim.fn.stdpath 'cache' .. '/jdtls/' .. project_name
  --
  --   return {
  --     'jdtls',
  --     '-data',
  --     workspace_dir,
  --   }
  -- end,
  --
  -- root_dir = function()
  --   return vim.fs.root(0, { '.git', 'build.gradle', 'pom.xml' })
  -- end,
  settings = {
    java = {
      format = {
        enabled = true,
      },
    },
  },
}
