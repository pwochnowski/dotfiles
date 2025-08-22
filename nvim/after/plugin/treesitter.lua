
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "c", "dart", "lua", "rust", "markdown"},
  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = false,

  ignore_install = {},

  highlight = {
    -- `false` will disable the whole extension
    enable = true,


    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },

  modules = {},
}
--
require 'nvim-treesitter.install'.compilers = { '/opt/homebrew/Cellar/gcc/14.1.0/bin/gcc-14' }

--local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
--parser_config.dartl = {
--    install_info = {
--      url = "~/repos/tree-sitter-dart",
--      files = {"src/parser.c", "src/scanner.c"},
--      brain = "main",
--      generate_requires_npm = false, -- if stand-alone parser without npm dependencies
--      requires_generate_from_grammar = false, -- if folder contains pre-generated src/parser.c
--    },
--    filetype = "dart",
--}

--
--
--
--
----  incremental_selection = {
----    enable = false,
----    keymaps = {
----      -- mappings for incremental selection (visual mappings)
----      init_selection = "<CR>", -- maps in normal mode to init the node/scope selection
----      node_incremental = ".", -- increment to the upper named parent
----      node_decremental = ",", -- increment to the upper named parent
----      scope_incremental = "<TAB>", -- increment to the upper scope (as defined in locals.scm)
----      scope_decremental = "<S-TAB>", -- decrement to the previous node
----    },
----  },
----  textobjects = {
----    select = {
----      enable = true,
----
----      -- Automatically jump forward to textobj, similar to targets.vim
----      lookahead = true,
----
----      keymaps = {
----        -- You can use the capture groups defined in textobjects.scm
----        ["af"] = "@function.outer",
----        ["if"] = "@function.inner",
----
----        ["ab"] = "@block.outer",
----        ["ib"] = "@block.inner",
----
----        ["ac"] = { query = "@class.outer", desc = "Select outer part of a class region" },
----        ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
----
----        -- You can also use captures from other query groups like `locals.scm`
----        ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
----      },
----
----      -- You can choose the select mode (default is charwise 'v')
----      --
----      -- Can also be a function which gets passed a table with the keys
----      -- * query_string: eg '@function.inner'
----      -- * method: eg 'v' or 'o'
----      -- and should return the mode ('v', 'V', or '<c-v>') or a table
----      -- mapping query_strings to modes.
----      selection_modes = {
----        ['@parameter.outer'] = 'v', -- charwise
----        ['@function.outer'] = 'V', -- linewise
----        ['@class.outer'] = '<c-v>', -- blockwise
----      },
----      -- If you set this to `true` (default is `false`) then any textobject is
----      -- extended to include preceding or succeeding whitespace. Succeeding
----      -- whitespace has priority in order to act similarly to eg the built-in
----      -- `ap`.
----      include_surrounding_whitespace = true,
----    },
----
----    swap = {
----      enable = true,
----      swap_next = {
----        ["<leader>a"] = "@parameter.inner",
----      },
----      swap_previous = {
----        ["<leader>A"] = "@parameter.inner",
----      },
----    },
----  },
----
--}
