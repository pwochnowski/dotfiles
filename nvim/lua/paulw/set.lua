vim.opt.guicursor = ""

vim.opt.autowriteall = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.smartindent = true

-- enabling number and relativenumber at the same time produces hybrid line number mode.
-- Shows relative numbers for all except current line 
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.wrap = true
-- Break at word if text goas over end of line
vim.opt.lbr = true

vim.opt.autowriteall = true

vim.opt.termguicolors = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.ignorecase = true
vim.opt.smartcase = true


vim.opt.scrolloff = 4
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.colorcolumn = "100"

-- Set completeopt to have a better completion experience
vim.opt.completeopt = 'menuone,noselect'
