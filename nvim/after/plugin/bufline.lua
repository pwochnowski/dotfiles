vim.opt.termguicolors = true

require("bufferline").setup{
  options = {
    numbers = "buffer_id",
    right_mouse_command = '',
    middle_mouse_command = "bdelete %d"
  }
}
