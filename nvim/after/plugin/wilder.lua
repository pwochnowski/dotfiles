--local wilder = require('wilder')
--wilder.setup({modes = {':', '/', '?'}})
---- Disable Python remote plugin
--wilder.set_option('use_python_remote_plugin', 0)
--
--wilder.set_option('pipeline', {
--  wilder.branch(
--    wilder.cmdline_pipeline({
--      fuzzy = 1,
--      fuzzy_filter = wilder.lua_fzy_filter(),
--    }),
--    wilder.vim_search_pipeline()
--  )
--})
--
--wilder.set_option('renderer', wilder.renderer_mux({
--  [':'] = wilder.popupmenu_renderer({
--    highlighter = wilder.lua_fzy_highlighter(),
--    left = {
--      ' ',
--      wilder.popupmenu_devicons()
--    },
--    right = {
--      ' ',
--      wilder.popupmenu_scrollbar()
--    },
--  }),
--  ['/'] = wilder.wildmenu_renderer({
--    highlighter = wilder.lua_fzy_highlighter(),
--  }),
--}))


local wilder = require('wilder')
wilder.setup({modes = {':', '/', '?'}})

wilder.set_option('pipeline', {
  wilder.branch(
    wilder.substitute_pipeline({
      pipeline = wilder.vim_search_pipeline({
        skip_cmdtype_check = 1,
        pattern = wilder.lua_fzy_filter(),
      }),
    }),
    wilder.cmdline_pipeline({
      fuzzy = 2,
      fuzzy_filter = wilder.lua_fzy_filter(),
    }),
    {
      wilder.check(function(ctx, x) return x == '' end),
      wilder.history(),
    },
    wilder.vim_search_pipeline({
      pattern = wilder.lua_fzy_filter(),
    })
  ),
})

local highlighters = {
  wilder.pcre2_highlighter(),
  wilder.lua_fzy_highlighter(),
}

local popupmenu_renderer = wilder.popupmenu_renderer(
  wilder.popupmenu_border_theme({
    border = 'rounded',
    empty_message = wilder.popupmenu_empty_message_with_spinner(),
    highlighter = highlighters,
    left = {
      ' ',
      wilder.popupmenu_devicons(),
      wilder.popupmenu_buffer_flags({
        flags = ' a + ',
        icons = {['+'] = '', a = '', h = ''},
      }),
    },
    right = {
      ' ',
      wilder.popupmenu_scrollbar(),
    },
  })
)

local wildmenu_renderer = wilder.wildmenu_renderer({
  highlighter = highlighters,
  separator = ' · ',
  left = {' ', wilder.wildmenu_spinner(), ' '},
  right = {' ', wilder.wildmenu_index()},
})

wilder.set_option('renderer', wilder.renderer_mux({
  [':'] = popupmenu_renderer,
  ['/'] = wildmenu_renderer,
  substitute = wildmenu_renderer,
}))
