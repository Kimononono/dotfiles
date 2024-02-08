require("nvim-treesitter.install").prefer_git = true
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "c", "vim", "python", "lua", "bash", "json", "yaml", "html", "css", "javascript", "typescript", "tsx", "rust", "java"},

  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
  },
   playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
    keybindings = {
      toggle_query_editor = 'o',
      toggle_hl_groups = 'i',
      toggle_injected_languages = 't',
      toggle_anonymous_nodes = 'a',
      toggle_language_display = 'I',
      focus_language = 'f',
      unfocus_language = 'F',
      update = 'R',
      goto_node = '<cr>',
      show_help = '?',
    },
  },
  {
   incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<leader>gnn", -- set to `false` to disable one of the mappings
      node_incremental = "<leader>grn",
      scope_incremental = "<leader>grc",
      node_decremental = "<leader>grm",
    },
  },
  },

}

