set nocompatible " use vim-defaults instead of vi-defaults (easier, more user friendly)
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
" call vundle#begin('~/some/path/here')

"Error Checking 
Plugin 'vim-syntastic/syntastic'

"let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'vim-latex/vim-latex'

Plugin 'ctrlpvim/ctrlp.vim'

Plugin 'FelikZ/ctrlp-py-matcher'

Plugin 'majutsushi/tagbar'

"vimgrep improvement
Plugin 'rking/ag.vim'

"Enable FocusGained, FocusLost commands inside Tmux
Plugin 'tmux-plugins/vim-tmux-focus-events'

"Give me decent higlighting for tmux.conf
Plugin 'tmux-plugins/vim-tmux'

"Use gc to auto comment lines"
Plugin 'tpope/vim-commentary'

"Timeout for hjkl keys
Bundle 'takac/vim-hardtime'

Plugin 'junegunn/vim-easy-align'

Plugin 'felixhummel/setcolors.vim'

" All of your Plugins must be added before the following line
call vundle#end()         " required

filetype plugin indent on " Attempt to determine the type of a file based on its name
syntax on                 " Enable syntax highlighting


"Ag options
let g:ackprg = 'ag --nogroup --nocolor --column'
let g:ag_working_path_mode="r"
let g:ag_prg="ag --vimgrep"


" Syntastic settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_enable_signs = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 3
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" CTRLP settings
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
" r - nearest ancestor (parent with .git folder)
" a - current directory when the file isn't a direct ancestor of the current
" file
let g:ctrlp_working_path_mode = 'ra'

let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore = {
	\ 'dir':  '\v[\/]\.(git|hg|svn)$',
	\ 'file': '\v\.(exe|so|dll)$',
	\ 'link': 'SOME_BAD_SYMBOLIC_LINKS',
	\ }

" CTRLP matching function (supposedly better)
let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }

" Tagbar settings
nmap <leader>, :TagbarToggle<CR>

"Get gud with vim
let g:hardtime_default_on = 0



"Vim-LaTex Settings
let g:tex_flavor='latex'
let g:Tex_TreatMacViewerAsUNIX = 1
let g:Tex_ExecuteUNIXViewerInForeground = 1
let g:Tex_ViewRule_ps = 'open -a Preview'
let g:Tex_ViewRule_pdf = 'open -a Skim'
let g:Tex_ViewRule_dvi = 'open -a  Skim'
let g:Tex_Env_question = "\\begin{question}{<++>}\<CR>\\end{question}<++>"



set guioptions-=f "Keep gvim connected to the terminal process

let mapleader=" "  "Change leader key

"Keymappings

"Remap since F5 is impossible to reach
imap <C-e> <F5>

" remove trailing whitespace
nnoremap <silent> <leader>d :%s/\s\+$//e<CR>:noh<CR>

" global substitution on last used search pattern
nnoremap <leader>s :%s///g<Left><Left>
xnoremap <leader>s :s///g<Left><Left>

"Clear highlighting
nnoremap <leader>h :noh<CR>

"Send keys in tmux
"go to the right tmux pane and repeat last command
nnoremap <leader>r :!tmux send-keys -t right C-p C-j <CR><CR>


"Something I will never remember to use
iabbrev /_ /********************************************
iabbrev _/ ********************************************/


"Use EasyAlign with ga
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

"Define folding (za) by syntax of current file
setlocal foldmethod=syntax
setlocal nofoldenable

set noswapfile "who needs a swapfile when you don't make mistakes

"Buffer options
set hidden "Cause the current buffer to hide changes when another buffer is opened
set confirm "Check before quitting if unwritten buffer
set autowriteall

" Better command-line completition
set wildmenu
set wildignore=*.o,*.obj,*.bak,*.exe,*.py[co],*.sw*,*~,*.pyc,.svn

"2 lines above/below cursor when scrolling
set scrolloff=2

"Display line on cursor position
"set cursorline

" Ignore case for commandline filename completions
set wildignorecase

" Undo persists upon closing file
set undofile

"Show typed command in status bar
set showcmd

"Show cursor position in status bar
set ruler

"show current mode in status bar
set showmode

" Highlight searches
set hlsearch

" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase

"Display line number on left
set number
"Display relative line numbers
set relativenumber

"Break word if text goes over the end of the line
set lbr

"set the command window height to 2 lines
set cmdheight=2

"Enable use of mouse (we dont want this habit though)
"set mouse=a

"indentation settings
"inserts spaces instead of 'real' tab characters
set expandtab
"change the number of space characters inserted for indentation
set shiftwidth=2
set softtabstop=2

map Y y$
"nnoremap <Space> :nohl<CR><C-L>

set t_Co=16
"let g:solarized_termcolors=256
"set background=dark
colorscheme ingretu 


"Configure buffers to use, instead of tabs
nmap ; :buffers<CR>


"Use control+t <direction> to switch between open tab
map <C-t><up> :tabr<cr>
map <C-t><down> :tabl<cr>
map <C-t><left> :tabp<cr>
map <C-t><right> :tabn<cr>

"disable arrow keys to break bad habits
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

nmap <Leader><Leader> :

" fix up moving line by line in the paragraph
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk
" map gj/gk to do what j/k do by default
nnoremap gj j
nnoremap gk k
vnoremap gj j
vnoremap gk k

" wrapped line movement mappings (adds larger jumps to jumplist)
nnoremap <expr> j v:count > 4 ? (v:count > 5 ? "m'" . v:count : '') . 'j' : 'gj'
nnoremap <expr> k v:count > 4 ? (v:count > 5 ? "m'" . v:count : '') . 'k' : 'gk'

if has("gui_vim")
endif

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

augroup syntastic_color
  au!
  autocmd BufRead,BufNewFile * :highlight SignColumn ctermbg=8 guibg=#000000
  autocmd BufRead,BufNewFile * :highlight SyntasticErrorSign ctermbg=8 guibg=#000000
  autocmd BufRead,BufNewFile * :highlight SyntasticError ctermfg=16 ctermbg=14 
  autocmd BufRead,BufNewFile * :highlight qfError ctermbg=8 guibg=#000000

  "Apparently this is more appropriate autocommand to watch for?
  "autocmd ColorScheme * highlight SignColumn ctermbg=red
augroup END


augroup filetype_mips
  autocmd!
  autocmd BufRead,BufNewFile *.s :set syntax=mips
augroup END

augroup compile_time
  au!
  autocmd FileType cpp nnoremap <silent> <leader>m :!g++ %<cr>
  autocmd FileType c nnoremap <leader>m :!gcc -std=c11 %<cr>
  autocmd FileType cpp nnoremap <silent> <leader>g :!g++ -g %<cr>
  autocmd FileType c nnoremap  <leader>g :!gcc -std=c11 -g %<cr>
  autocmd FileType c nnoremap <leader>a :!gcc -std=c11 -Wall -Werror %<cr>
augroup END

augroup unfold_all
  autocmd!
  autocmd BufNewFile,BufRead * :normal zR
augroup END

" Prevent folds from opening while editing
autocmd InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod  | setlocal foldmethod=manual | endif
autocmd InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif

"autosave on lose focus
autocmd BufLeave,FocusLost * silent! :wall

"Toggle displaying relative number
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * :set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * :set norelativenumber
augroup END

augroup myvimrchax
  au!
  autocmd BufWrite .vimrc source ~/.vimrc
augroup END

augroup latex
  au!
  autocmd BufNewFile,BufRead *.tex let tex_no_curly_error=1
augroup END

augroup md_update
  au!
  autocmd InsertLeave *.md silent! :w
  autocmd InsertLeave *.html silent! :w
augroup END

function! s:CloseBracket()
  let line = getline('.')
  if line =~# '^\s*\(struct\|class\|enum\) '
    return "{\<Enter>};\<Esc>O"
  elseif searchpair('(', '', ')', 'bmn', '', line('.'))
    " Probably inside a function call. Close it off.
    return "{\<Enter>});\<Esc>O"
  else
    return "{\<Enter>}\<Esc>O"
  endif
endfunction

inoremap <expr> {<Enter>  <SID>CloseBracket()



