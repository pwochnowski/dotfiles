set nocompatible " use vim-defaults instead of vi-defaults (easier, more user friendly)
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

"let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'junegunn/fzf'

" Plugin 'Valloric/YouCompleteMe'

Plugin 'grailbio/bazel-compilation-database'

"vimgrep improvement
Plugin 'rking/ag.vim'

Plugin 'ap/vim-buftabline'

Plugin 'tpope/vim-fugitive'

"Use gc to auto comment lines"
Plugin 'tpope/vim-commentary'

Plugin 'godlygeek/tabular'

Plugin 'plasticboy/vim-markdown'

Plugin 'asvetliakov/vim-easymotion'

"Timeout for hjkl keys
Bundle 'takac/vim-hardtime'


"Plugin 'felixhummel/setcolors.vim'

" All of your Plugins must be added before the following line
call vundle#end()         " required

filetype plugin indent on " Attempt to determine the type of a file based on its name
syntax on                 " Enable syntax highlighting

set nocp
" configure tags - add additional tags here or comment out not-used ones
" Setting the directory...
set tags=~/.vim/tags 
" Adding the tag files 
set tags+=~/.vim/tags/cpp

nnoremap <silent> <C-p> :<C-u>FZF<CR>

set autowriteall

"Define folding (za) by syntax of current file
" setlocal foldmethod=syntax
setlocal foldmethod=indent
set foldnestmax=2
setlocal nofoldenable

set swapfile
set dir=~/.vimbackup

set wildmenu
set wildignore=*.o,*.obj,*.bak,*.exe,*.py[co],*.sw*,*~,*.pyc,.svn

" position cursor 2 lines from end of screen when scrolling
set scrolloff=2

" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase

"Display line number on left
set number
"Display relative line numbers
set relativenumber

"Break word if text goes over the end of the line
set lbr

set expandtab
set shiftwidth=2
set tabstop=2

set undofile
set undodir=~/.vimbackup/,/tmp//

"Show cursor position in status bar
set ruler

"Show typed command in status bar
set showcmd

"show current mode in status bar
set showmode

"set the command window height to 2 lines
set cmdheight=2

" Turn off annoying beeps
set noerrorbells
set vb t_vb=

set mouse=a

let mapleader=' '

if 0 
" YouCompleteMe
let g:ycm_global_ycm_extra_conf = '/home/paulw/polez/tools/ycm_extra_conf.py'
" let g:ycm_clangd_binary_path="/usr/bin/clangd"

let g:ycm_key_list_select_completion = ['<Enter>']
let g:ycm_key_list_select_previous_completion = ['<C-Enter>']

" Don't trigger completion menu unless requested
" let g:ycm_auto_trigger=0
let g:ycm_min_num_of_chars_for_completion=5


" invoke the completion menu for semantic completion
let g:ycm_key_invoke_completion = '<C-Space>'

let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_autoclose_preview_window_after_completion = 1


" Define the characters that trigger semantic completion when typed. 
let g:ycm_semantic_triggers =  {
  \   'c': ['->', '.'],
  \   'objc': ['->', '.', 're!\[[_a-zA-Z]+\w*\s', 're!^\s*[^\W\d]\w*\s',
  \            're!\[.*\]\s'],
  \   'ocaml': ['.', '#'],
  \   'cpp,cuda,objcpp': ['->', '.', '::'],
  \   'perl': ['->'],
  \   'php': ['->', '::'],
  \   'cs,d,elixir,go,groovy,java,javascript,julia,perl6,python,scala,typescript,vb': ['.'],
  \   'ruby,rust': ['.', '::'],
  \   'lua': ['.', ':'],
  \   'erlang': [':'],
  \ }

nnoremap <C-b> :YcmCompleter GoToDefinitionElseDeclaration<CR>

" unmap <C-i>
noremap <leader>i :YcmCompleter GoToReferences<CR>
endif


"Ag options
let g:ackprg = 'ag --nogroup --nocolor --column'
let g:ag_working_path_mode="r"
let g:ag_prg="ag --vimgrep"


"Get gud with vim
let g:hardtime_default_on = 0


"Keymappings

nnoremap <C-Tab> :bprev<CR>
nnoremap <Tab> :bnext<CR>

map Y y$

nmap <Leader><Leader> :

" fix up moving line by line in the paragraph
nmap j gj

nmap k gk
" map gj/gk to do what j/k do by default
nnoremap gj j
nnoremap gk k


" wrapped line movement mappings (adds larger jumps to jumplist)
nnoremap <expr> j v:count > 4 ? (v:count > 5 ? "m'" . v:count : '') . 'j' : 'gj'
nnoremap <expr> k v:count > 4 ? (v:count > 5 ? "m'" . v:count : '') . 'k' : 'gk'

" remove trailing whitespace
nnoremap <silent> <leader>d :%s/\s\+$//e<CR>:noh<CR>

" global substitution on last used search pattern
nnoremap <leader>s :%s///g<Left><Left>k

" Tagbar settings
" nmap <leader>, :TagbarToggle<CR>

"Clear highlighting
nnoremap <leader>h :noh<CR>


" Autocommands

" autocommand syntax
" autocmd <event_to_watch_for> <pattern_to_filter_event> <command>
" BufNewFile - execute when a new file is buffered
" BufRead - execute when a new file is readd
" FileType - execute when vim sets a buffer's filetype
" BufWritePre - execute just before we are about to write in a buffer
" combine both of the above to run command whenever a file is opened
" Group similar autocommands with augroup and run them all
" use !au at the beginning of the group to clear other autocommands
" (avoids commands being run multiple times)

" Prevent folds from opening while editing
autocmd InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod  | setlocal foldmethod=manual | endif
autocmd InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif

augroup unfold_all
  autocmd!
  autocmd BufNewFile,BufRead * :normal zR
augroup END

" checktime will check for changes on disk and prompt you to reload.
au WinLeave,FocusLost * :wa

"Toggle displaying relative number
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * :set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * :set norelativenumber
augroup END

augroup vimrc
  au!
  autocmd BufWrite .vimrc source ~/.vimrc
augroup END
