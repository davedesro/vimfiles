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

" let Vundle manage Vundle
Plugin 'VundleVim/Vundle.vim'

" My bundles
"
Plugin 'mileszs/ack.vim'
Plugin 'kchmck/vim-coffee-script'
Plugin 'wincent/Command-T'
Plugin 'basepi/vim-conque.git'
Plugin 'Raimondi/delimitMate.git'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-fugitive'
Plugin 'sjl/gundo.vim.git'
Plugin 'chriseppstein/vim-haml'
Plugin 'leshill/vim-json.git'
Plugin 'tpope/vim-markdown'
Plugin 'benjifisher/matchit.zip.git'
Plugin 'mrtazz/molokai.vim'
Plugin 'juvenn/mustache.vim.git'
Plugin 'tpope/vim-rails'
Plugin 'skwp/vim-ruby-conque.git'
Plugin 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-surround.git'
Plugin 'tomtom/tcomment_vim.git'
Plugin 'sickill/vim-pasta.git'
Plugin 'flazz/vim-colorschemes.git'
Plugin 'tpope/vim-eunuch'
Plugin 'nelstrom/vim-markdown-folding'
Plugin 'vim-scripts/taglist.vim.git'
Plugin '4Evergreen4/vim-hardy'
Plugin 'vim-scripts/ZoomWin.git'
Plugin 'nelstrom/vim-visual-star-search'
Plugin 'pangloss/vim-javascript.git'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'digitaltoad/vim-jade.git'
Plugin 'derekwyatt/vim-fswitch'
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
set relativenumber
set undofile

" Global highlighting
highlight CursorLine cterm=NONE

function s:setupWrapping()
  set wrap
  set wrapmargin=2
  set textwidth=80
endfunction

if has("autocmd")
  " In Makefiles, use real tabs, not tabs expanded to spaces
  au FileType make set noexpandtab

  " Make sure all markdown files have the correct filetype set and setup wrapping
  au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn,txt} setf markdown | call s:setupWrapping()

  " Treat JSON files like JavaScript
  au BufNewFile,BufRead *.json set ft=javascript

  " make Python follow PEP8 ( http://www.python.org/dev/peps/pep-0008/ )
  au FileType python set softtabstop=4 tabstop=4 shiftwidth=4 textwidth=160

  au FileType c,cpp
    \ set tabstop=4 shiftwidth=4 softtabstop=4 noexpandtab textwidth=120 |
    \ nmap <silent> <Leader>h :FSHere<cr> |
    \ nmap <silent> <Leader>H :FSSplitRight<cr>


  " Remember last location in file, but not for commit messages.
  " see :help last-position-jump
  au BufReadPost * if &filetype !~ '^git\c' && line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g`\"" | endif

  au FocusLost * :wa

  au FileType coffee,python,html,xml,rexx :set foldmethod=indent

  " XML
  au FileType xml exe ":silent 1,$!xmllint --format --recover - 2>/dev/null"
  map <leader>xt  <Esc>:silent 1,$!xmllint --format --recover - 2>/dev/null<CR>

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

  " Override rspec conque key bindings
  au FileType rb
    \ nmap <silent> <Leader>rr :RunRubyCurrentFileConque<CR>     |
    \ nmap <silent> <Leader>s :RunRspecCurrentFileConque<CR>     |
    \ nmap <silent> <Leader>l :RunRspecCurrentLineConque<CR>     |
    \ nmap <silent> <Leader>cl :RunCucumberCurrentLineConque<CR> |
    \ nmap <silent> <Leader>cc :RunCucumberCurrentFileConque<CR> |
    \ nmap <silent> <Leader>RR :RunRakeConque<CR>                |
    \ nmap <silent> <Leader>a :RunLastConqueCommand<CR>

  " BGS
  au BufRead,BufNewFile *.bgs set filetype=ruby

  au BufWritePost *
    \ if filereadable('tags') |
    \   call system('ctags -a '.expand('%')) |
    \ endif

  autocmd QuickFixCmdPost [^l]* nested cwindow
  autocmd QuickFixCmdPost    l* nested lwindow

  let os=substitute(system('uname'), '\n', '', '')
  if has("unix") && os != 'Darwin'
    au InsertEnter * silent execute "!dconf write /org/gnome/terminal/legacy/profiles:/:42cdda23-3402-4c1d-9282-1fb1a246971e/cursor-shape \"'ibeam'\""
    au InsertLeave * silent execute "!dconf write /org/gnome/terminal/legacy/profiles:/:42cdda23-3402-4c1d-9282-1fb1a246971e/cursor-shape \"'block'\""
    au VimLeave * silent execute  "!dconf write /org/gnome/terminal/legacy/profiles:/:42cdda23-3402-4c1d-9282-1fb1a246971e/cursor-shape \"'block'\""
  endif

  if $TERM_PROGRAM =~ "iTerm"
    if exists('$TMUX')
      let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
      let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
    else
      let &t_SI = "\<Esc>]50;CursorShape=1\x7" " Vertical bar in insert mode
      let &t_EI = "\<Esc>]50;CursorShape=0\x7" " Block in normal mode
    endif
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

map <leader>gv :CommandTFlush<cr>\|:CommandT app/views<cr>
map <leader>gc :CommandTFlush<cr>\|:CommandT app/controllers<cr>
map <leader>gm :CommandTFlush<cr>\|:CommandT app/models<cr>
map <leader>gh :CommandTFlush<cr>\|:CommandT app/helpers<cr>
map <leader>gl :CommandTFlush<cr>\|:CommandT lib<cr>
map <leader>gf :CommandTFlush<cr>\|:CommandT features<cr>
map <leader>gg :topleft 100 :split Gemfile<cr>
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
set wildignore+=*.d,*.o,*.a,*.ld

nnoremap <leader><leader> <c-^>

" find merge conflict markers
nmap <silent> <leader>cf <ESC>/\v^[<=>]{7}( .*\|$)<CR>

command! KillWhitespace :normal :%s/ *$//g<cr><c-o><cr>

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
set foldmethod=syntax
set foldlevel=99

" Conque
let g:ConqueTerm_CWInsert = 1      " Exit conque terminal using <C-w>
" To kick off a generic conque command,
" use g:exec_script to define the command
nmap <silent> <leader>m :GenericConqueCommand<CR>

" Gundo
nnoremap <silent> <F5> :GundoToggle<CR>

" Taglist
nnoremap <silent> <F8> :TlistToggle<CR>

" json
map <leader>jt  <Esc>:%!json_pp -f json -t json -json_opt pretty<CR>

" turn syntax off for large files
" autocmd BufWinEnter * if line2byte(line("$") + 1) > 100000 | syntax clear | endif

" Kill buffers, keep window state
nmap <leader>d :b#<bar>bd#<CR>

" Alt-right/left to navigate forward/backward in the tags stack
map <M-h> <C-T>
map <M-l> <C-]>
map <C-M-l> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

if has("mac")
  set macmeta
endif

nnoremap <C-p> :bp<CR>
nnoremap <C-n> :bn<CR>

" let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
" let g:ycm_enable_diagnostic_signs = 0
" let g:ycm_show_diagnostics_ui = 0

" Used in vim-ruby-conque, added support for generic command
let g:exec_script     = "/home/dave/Documents/MorseProject/expt-dsd/Scripts/linux/test-on-arm.sh"

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
