""
"" Thanks:
""   Gary Bernhardt  <destroyallsoftware.com>
""   Drew Neil  <vimcasts.org>
""   Tim Pope  <tbaggery.com>
""   Janus  <github.com/carlhuda/janus>
""

set nocompatible
syntax enable
set encoding=utf-8

filetype off
set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#rc()


" This must be set before the XML plugin is loaded
if has("autocmd")
  au FileType xml,html
    \ let maplocalleader="m" |
    \ setlocal foldmethod=indent
endif

" let Vundle manage Vundle
Plugin 'VundleVim/Vundle.vim'

" My bundles
"
Plugin 'mileszs/ack.vim'
Plugin 'wincent/Command-T'
Plugin 'Raimondi/delimitMate.git'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-fugitive'
Plugin 'sjl/gundo.vim.git'
Plugin 'tpope/vim-markdown'
Plugin 'vim-scripts/matchit.zip.git'
Plugin 'tpope/vim-surround.git'
Plugin 'tomtom/tcomment_vim.git'
Plugin 'sickill/vim-pasta.git'
Plugin 'flazz/vim-colorschemes.git'
Plugin 'nelstrom/vim-markdown-folding'
Plugin 'vim-scripts/taglist.vim.git'
Plugin '4Evergreen4/vim-hardy'
Plugin 'vim-scripts/ZoomWin.git'
Plugin 'bronson/vim-visual-star-search'
Plugin 'pangloss/vim-javascript.git'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'derekwyatt/vim-fswitch'
Plugin 'othree/xml.vim'
Plugin 'python-mode/python-mode.git'
Plugin 'digitaltoad/vim-pug'
Plugin 'thinca/vim-localrc'
Plugin 'craigemery/vim-autotag'
Plugin 'RRethy/vim-illuminate.git'
Plugin 'tmux-plugins/vim-tmux-focus-events'

" if version >= 703
"   Plugin 'Valloric/YouCompleteMe'
" endif
Plugin 'pyclewn', { 'pinned': 1 }

filetype plugin indent on

set background=dark
color mrkn256
set number
set ruler       " show the cursor position all the time
set cursorline
set showcmd     " display incomplete commands
set shell=bash  " avoids munging PATH under zsh
let g:is_bash=1 " default shell syntax

" Allow backgrounding buffers without writing them, and remember marks/undo
" for backgrounded buffers
set hidden

" Auto-reload buffers when file changed on disk
set autoread

"" Whitespace
set nowrap                        " don't wrap lines
set tabstop=2                     " a tab is two spaces
set shiftwidth=2                  " an autoindent (with <<) is two spaces
set expandtab                     " use spaces, not tabs
set list                          " Show invisible characters
set backspace=indent,eol,start    " backspace through everything in insert mode
" Joining lines
if v:version > 703 || v:version == 703 && has("patch541")
  set formatoptions+=j            " Delete comment char when joining commented lines
endif
set nojoinspaces                  " Use only 1 space after "." when joining lines, not 2
" List chars
set listchars=""                  " Reset the listchars
set listchars=tab:»-              " show tabs as dots
set listchars+=trail:◘            " show trailing spaces as dots
set listchars+=extends:>          " The character to show in the last column when wrap is
                                  " off and the line continues beyond the right of the screen
set listchars+=precedes:<         " The character to show in the first column when wrap is
                                  " off and the line continues beyond the left of the screen
"" Searching
set hlsearch                      " highlight matches
set incsearch                     " incremental searching
set ignorecase                    " searches are case insensitive...
set smartcase                     " ... unless they contain at least one capital letter

"" Misc
set undofile
set tags=.tags;

" Global highlighting
highlight CursorLine cterm=NONE

function! g:LRefreshTags()
  let cwd = getcwd()
  let cmd = "rm -f " . g:autotagTagsFile . "; ctags -R -f " . cwd . "/.tags *"
  let resp = system(cmd)
  return ''
endfunction
command! -bar -bang -nargs=* LRefreshTags :call g:LRefreshTags() | echo

if has("autocmd")

  " turn syntax off for large files
  au BufWinEnter * if line2byte(line("$") + 1) > 400000 | syntax clear | endif

  " In Makefiles, use real tabs, not tabs expanded to spaces
  au FileType make set noexpandtab

  " Make sure all markdown files have the correct filetype set and setup wrapping
  au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn,txt} setf markdown |
        \ set wrap wrapmargin=2 textwidth=80

  " Treat JSON files like JavaScript
  au BufNewFile,BufRead *.json set ft=javascript

  au FileType c,cpp set tabstop=4 shiftwidth=4 softtabstop=4 noexpandtab colorcolumn=90
  au FileType c,cpp,make
    \ nmap <silent> <Leader>n :cn<CR>     |
    \ nmap <silent> <Leader>p :cp<CR>     |
    \ nmap <silent> <Leader>c :make all V=1<CR>   |
    \ nmap <silent> <Leader>r :make install V=1<CR>   |
    \ nmap <silent> <Leader>v :make clean && make install V=1<CR> |
    \ nmap <silent> <Leader>h :FSHere<CR> |
    \ nmap <silent> <Leader>H :FSSplitRight<CR>
  au BufEnter *.c compiler gcc

  au BufRead *.c,*.cpp let b:fswitchlocs = '.,../Inc'
  au BufRead *.h,*.hpp let b:fswitchlocs = '.,../Src'

  au Syntax c,cpp setlocal foldmethod=syntax
  au Syntax c,cpp normal! zR

  au FileType python nmap <leader>L :PymodeLint<CR>

  " Remember last location in file, but not for commit messages.
  " see :help last-position-jump
  au BufReadPost * if &filetype !~ '^git\c' && line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g`\"" | endif

  au FileType coffee,rexx :setlocal foldmethod=indent

  au FileType xml
    \ set noexpandtab tabstop=4 shiftwidth=4 softtabstop=4 |
    \ map <leader>xt  <Esc>:silent 1,$!xmllint --format --recover - 2>/dev/null<CR>

  " Arduino
  au BufRead,BufNewFile *.{pde,ino} set filetype=arduino
  au FileType arduino
    \ nmap <silent> <Leader>l :write<CR> :ArduinoUpload<CR> |
    \ nmap <silent> <Leader>v :write<CR> :ArduinoVerify<CR>

  " REXX
  au BufRead,BufNewFile *.{zrx,rexx}  set filetype=rexx

  " magic markers: enable using `H/S/J/C to jump back to
  " last HTML, stylesheet, JS or Ruby code buffer
  au BufLeave *.{erb,html,h}    exe "normal! mH"
  au BufLeave *.{css,scss,sass} exe "normal! mS"
  au BufLeave *.{js,coffee}     exe "normal! mJ"
  au BufLeave *.{rb,c,cpp}      exe "normal! mC"

  " BGS
  au BufRead,BufNewFile *.bgs set filetype=ruby

  autocmd QuickFixCmdPost [^l]* nested cwindow
  autocmd QuickFixCmdPost    l* nested lwindow

  let os=substitute(system('uname'), '\n', '', '')

  if has("unix") && os != 'Darwin'
    au InsertEnter * silent execute "!echo -ne \"\e[5 q\""
    au InsertLeave * silent execute "!echo -ne \"\e[1 q\""
    au VimLeave * silent execute "!echo -ne \"\e[1 q\""
  elseif exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
  elseif $TERM_PROGRAM =~ "iTerm" || $SSH_CLIENT
    let &t_SI = "\<Esc>]50;CursorShape=1\x7" " Vertical bar in insert mode
    let &t_EI = "\<Esc>]50;CursorShape=0\x7" " Block in normal mode
  endif
endif

set autowrite " Write the contents of the file on buffer switching

" provide some context when editing
set scrolloff=3

" don't use Ex mode, use Q for formatting
map Q gq

" clear the search buffer when hitting return
:nnoremap <CR> :nohlsearch<cr>

" toggle the current fold
:nnoremap <Space> za

let mapleader=","

" paste lines from unnamed register and fix indentation
nmap <leader>p pV`]=
nmap <leader>P PV`]=

map <leader>f :CommandTFlush<cr>\|:CommandT<cr>
" http://vimcasts.org/e/14
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>F :CommandTFlush<cr>\|:CommandT %%<cr>

" ignore Rubinius, Sass cache files
set wildignore+=tmp/**,*.rbc,.rbx,*.scssc,*.sassc
" Ignore non-development rails area
set wildignore+=public/**,coverage/**,log/**
" Ignore node libraries
set wildignore+=node_modules
" Ignore C/C++ compiling assets
set wildignore+=*.d,*.o,*.a,*.hex,*.axf,*.elf

nnoremap <leader><leader> <c-^>

" find merge conflict markers
nmap <silent> <leader>cf <ESC>/\v^[<=>]{7}( .*\|$)<CR>

set splitright
set splitbelow

" easier navigation between split windows
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" disable cursor keys in normal mode
map <Left>  :echo "no!"<cr>
map <Right> :echo "no!"<cr>
map <Up>    :echo "no!"<cr>
map <Down>  :echo "no!"<cr>

set backupdir=~/.vim/_backup    " where to put backup files.
set directory=~/.vim/_temp      " where to put swap files.
set undodir=~/.vim/_undo        " where to put undo files.

if has("statusline") && !&cp
  set laststatus=2  " always show the status bar

  set statusline=%f\ \ \ %m
  " Add fugitive
  set statusline+=\ \ \ %{fugitive#statusline()}

  " Go to right side
  set statusline+=%=

  " Set Line number
  set statusline+=L:%l\ (%p%%),\ C:%c

  " [RO] marker
  set statusline+=\ %r
endif

let g:CommandTMaxHeight=10
let g:CommandTMinHeight=4
let g:CommandTTraverseSCM='pwd'
let g:CommandTMatchWindowReverse=0
" TODO: Find out how to properly map these. h-split doesn't work in console right now
" let g:CommandTAcceptSelectionVSplitMap='C-v'
" let g:CommandTAcceptSelectionSplitMap='C-h'

let g:sh_fold_enabled=1
set foldlevelstart=20

" Ack
nnoremap <Leader>a :LAck!<Space>


" pymode
let g:pymode_doc = 0
let g:pymode_breakpoint_bind = '<leader>B'
let g:pymode_lint_cwindow = 0
let g:pymode_rope = 0
let g:pymode_lint_on_write = 0

" autotag
let g:autotagTagsFile=".tags"
let g:autotagmaxTagsFileSize="67108864"
" To use debugging, uncomment the line below, open up vim and ':call AutoCmdDebug()'
" let g:autotagVerbosityLevel="10"

" Gundo
nnoremap <silent> <F5> :GundoToggle<CR>

" Taglist
nnoremap <silent> <F8> :TlistToggle<CR>

" json
map <leader>jt  <Esc>:%!json_pp -f json -t json -json_opt pretty<CR>

" Kill buffers, keep window state
nmap <leader>d :b#<bar>bd#<CR>

" Alt-right/left to navigate forward/backward in the tags stack
map <M-h> <C-T>
map <M-l> <C-]>
map <C-M-l> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

" load project specific vim settings
set secure
call localrc#load('.tree.vimrc', getcwd())

if has("mac")
  set macmeta
endif

nnoremap <C-p> :bp<CR>
nnoremap <C-n> :bn<CR>

" let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
" let g:ycm_enable_diagnostic_signs = 0
" let g:ycm_show_diagnostics_ui = 0

if has("cscope")
  set csprg=/usr/bin/cscope
  set csto=0
  set cst
  set nocsverb
  " add any database in current directory
  if filereadable("cscope.out")
    cs add cscope.out
    " else add database pointed to by environment
  elseif $CSCOPE_DB != ""
    cs add $CSCOPE_DB
  endif
endif
set csverb
map  <C-\>:cs find 3 <C-r>=expand("<cword>")<CR><CR>
