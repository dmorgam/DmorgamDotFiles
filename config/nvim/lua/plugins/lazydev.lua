-- LazyDev: completado y diagnostics de la API de nvim en ficheros lua
--
-- Sustituye al workspace.library de lua_ls, que escaneaba todo el runtimepath
-- en cada arranque.

return {
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
}
