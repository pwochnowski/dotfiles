require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'nord',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {
      'mode',
      -- number of search matches when hlsearch enabled
      'searchcount'
    },
    lualine_b = {
       {
         'diagnostics',

         -- Table of diagnostic sources, available sources are:
         --   'nvim_lsp', 'nvim_diagnostic', 'nvim_workspace_diagnostic', 'coc', 'ale', 'vim_lsp'.
         -- or a function that returns a table as such:
         --   { error=error_cnt, warn=warn_cnt, info=info_cnt, hint=hint_cnt }
         sources = { 'nvim_lsp', 'coc' },

         -- Displays diagnostics for the defined severity types
         sections = { 'error', 'warn', 'info', 'hint' },

         diagnostics_color = {
           -- Same values as the general color option can be used here.
           error = 'DiagnosticError', -- Changes diagnostics' error color.
           warn  = 'DiagnosticWarn',  -- Changes diagnostics' warn color.
           info  = 'DiagnosticInfo',  -- Changes diagnostics' info color.
           hint  = 'DiagnosticHint',  -- Changes diagnostics' hint color.
         },
         symbols = {
           --error = '', warn = '',
           info = '', hint = ''
         },
         colored = true,           -- Displays diagnostics status in color if set to true.
         update_in_insert = false, -- Update diagnostics in insert mode.
         always_visible = true,   -- Show diagnostics even if there are none.
       }
    },
    lualine_c = {'filename'},
    lualine_x = {},
    lualine_y = {
      'branch',
      {
        'diff',
        colored = true, -- Displays a colored diff status if set to true
        diff_color = {
          -- Same color values as the general color option can be used here.
          added    = 'DiffAdd',    -- Changes the diff's added color
          modified = 'DiffChange', -- Changes the diff's modified color
          removed  = 'DiffDelete', -- Changes the diff's removed color you
        },
        symbols = {added = '+', modified = '~', removed = '-'}, -- Changes the symbols used by the diff.
        source = nil, -- A function that works as a data source for diff.
        -- It must return a table as such:
        --   { added = add_count, modified = modified_count, removed = removed_count }
        -- or nil on failure. count <= 0 won't be displayed.
      }
    },
    lualine_z = {
      {
        'location',
        padding = 0
      }
    }
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  --tabline = {
  --  lualine_a = {},
  --  lualine_b = {},
  --  lualine_c = { require'tabline'.tabline_buffers },
  --  lualine_x = { require'tabline'.tabline_tabs },
  --  lualine_y = {},
  --  lualine_z = {},
  --},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}
