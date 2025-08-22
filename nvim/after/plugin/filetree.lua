-- examples for your init.lua

-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true


-- OR setup with some options
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    relativenumber = true,
  },
  update_focused_file = {
    enable = true,
    update_root = true,
  },
  renderer = {
    highlight_opened_files = "icon",
    highlight_modified = "name",
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
  actions = {
    open_file = {
      quit_on_open = true
    }
  }
})

--vim.keymap.set('cd', 
