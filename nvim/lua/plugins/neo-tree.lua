-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  keys = {
    { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
  },
  opts = {
    sources = {
      'filesystem',
      'buffers',
      'git_status',
      'document_symbols',
    },
    source_selector = {
      winbar = true,
      sources = {
        { source = 'filesystem' },
        { source = 'buffers' },
        { source = 'git_status' },
        { source = 'document_symbols' },
      },
    },
    filesystem = {
      filtered_items = {
        visible = true, -- when true, they will just be displayed differently than normal items
        hide_dotfiles = false,
        hide_gitignored = false,
        hide_by_name = {
          'node_modules',
        },
        hide_by_pattern = { -- uses glob style patterns
          --"*.meta",
          --"*/src/*/tsconfig.json",
        },
        always_show = { -- remains visible even if other settings would normally hide it
          '.gitignore',
        },
        always_show_by_pattern = { -- uses glob style patterns
          '.env*',
        },
        never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
          '.git',
          '.DS_Store',
          'thumbs.db',
        },
        never_show_by_pattern = { -- uses glob style patterns
          --".null-ls_*",
        },
      },
      window = {
        mappings = {
          ['\\'] = 'close_window',
        },
      },
    },
  },
}
