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
" Plugin 'wincent/Command-T'
Plugin 'Raimondi/delimitMate.git'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-fugitive'
Plugin 'sjl/gundo.vim.git'
Plugin 'tpope/vim-markdown'
Plugin 'vim-scripts/matchit.zip.git'
Plugin 'tpope/vim-surround.git'
Plugin 'tomtom/tcomment_vim.git'
Plugin 'sickill/vim-pasta.git'
" Plugin 'flazz/vim-colorschemes.git'
Plugin 'nelstrom/vim-markdown-folding'
Plugin 'yegappan/taglist.git'
Plugin 'vim-scripts/ZoomWin.git'
Plugin 'bronson/vim-visual-star-search'
Plugin 'pangloss/vim-javascript.git'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'derekwyatt/vim-fswitch'
Plugin 'othree/xml.vim'
Plugin 'python-mode/python-mode.git'
Plugin 'digitaltoad/vim-pug'
Plugin 'thinca/vim-localrc'
" Plugin 'craigemery/vim-autotag'
Plugin 'RRethy/vim-illuminate.git'
Plugin 'tmux-plugins/vim-tmux-focus-events'
Plugin 'rhysd/vim-clang-format'
Plugin 'roxma/vim-tmux-clipboard'
Plugin 'skywind3000/asyncrun.vim'
Plugin 'rakr/vim-one.git'
Plugin 'vim-airline/vim-airline.git'
Plugin 'vim-airline/vim-airline-themes.git'
Plugin 'preservim/vimux'
" Plugin 'tomasr/molokai.git'
" Plugin 'sonph/onehalf.git'
" Plugin 'gosukiwi/vim-atom-dark.git'
" Plugin 'sjl/badwolf.git'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'udalov/kotlin-vim'

filetype plugin indent on

" Mouse support
set mouse=a
set ttymouse=sgr
set balloonevalterm
" Styled and colored underline support
let &t_AU = "\e[58:5:%dm"
let &t_8u = "\e[58:2:%lu:%lu:%lum"
let &t_Us = "\e[4:2m"
let &t_Cs = "\e[4:3m"
let &t_ds = "\e[4:4m"
let &t_Ds = "\e[4:5m"
let &t_Ce = "\e[4:0m"
" Strikethrough
let &t_Ts = "\e[9m"
let &t_Te = "\e[29m"
" Truecolor support
let &t_8f = "\e[38:2:%lu:%lu:%lum"
let &t_8b = "\e[48:2:%lu:%lu:%lum"
let &t_RF = "\e]10;?\e\\"
let &t_RB = "\e]11;?\e\\"
" Bracketed paste
let &t_BE = "\e[?2004h"
let &t_BD = "\e[?2004l"
let &t_PS = "\e[200~"
let &t_PE = "\e[201~"
" Cursor control
let &t_RC = "\e[?12$p"
let &t_SH = "\e[%d q"
let &t_RS = "\eP$q q\e\\"
let &t_SI = "\e[5 q"
let &t_SR = "\e[3 q"
let &t_EI = "\e[1 q"
let &t_VS = "\e[?12l"
" Focus tracking
let &t_fe = "\e[?1004h"
let &t_fd = "\e[?1004l"
execute "set <FocusGained>=\<Esc>[I"
execute "set <FocusLost>=\<Esc>[O"
" Window title
let &t_ST = "\e[22;2t"
let &t_RT = "\e[23;2t"

" vim hardcodes background color erase even if the terminfo file does
" not contain bce. This causes incorrect background rendering when
" using a color theme with a background color in terminals such as
" kitty that do not support background color erase.
let &t_ut=''

" colorscheme onehalfdark
" let g:airline_theme='onehalflight'

colorscheme one
" colorscheme mrkn256
set background=dark
" let g:one_allow_italics=1
if has("gui_running")
  let g:airline_theme='one'
else
  let g:airline_theme='onedark'
  call one#highlight('PMenuSel',   '000000', 'd19a66', '')
  call one#highlight('CursorLine', '',       '2a2a2a', '')
  call one#highlight('Folded',     'ffff00', '000000', '')
  call one#highlight('ColorColumn', '',      'be5046', '')
  call one#highlight('StatusLine', '',       '686868', '')
endif
"let g:airline_experimental=1
let g:airline_section_c_only_filename=1
let g:airline_stl_path_style='short'
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
let g:airline#extensions#taglist#enabled=0
let g:airline#extensions#whitespace#mixed_indent_format='[%s]mi'
let g:airline#extensions#whitespace#symbol=''
let g:airline_section_z=airline#section#create(['%p%%', 'maxlinenr', 'colnr'])

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
set tabstop=4                     " a tab is two spaces
set shiftwidth=4                  " an autoindent (with <<) is two spaces
set expandtab                     " use spaces by default, not tabs
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

	au BufRead,BufNewFile *.dts,*.dtsi,*.overlay set filetype=dts

  " turn syntax off for large files
  au BufWinEnter * if line2byte(line("$") + 1) > 400000 | syntax clear | endif

  " In Makefiles, use real tabs, not tabs expanded to spaces
  au FileType make set noexpandtab
  au FileType c set nowrap ts=4 sw=4 softtabstop=4 expandtab colorcolumn=80

  " For DTS files used for DTB, use real tabs
  au FileType dts set noexpandtab

  " Make sure all markdown files have the correct filetype set and setup wrapping
  au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn,txt} setf markdown |
        \ set wrap wrapmargin=2 textwidth=80

  au FileType json set expandtab
  au Syntax json setlocal foldmethod=syntax

  au FileType c,cpp,make
    \ nmap <silent> <Leader>n :cn<CR>     |
    \ nmap <silent> <Leader>p :cp<CR>     |
    \ nmap <silent> <Leader>c :make all V=1<CR>   |
    \ nmap <silent> <Leader>r :make install V=1<CR>   |
    \ nmap <silent> <Leader>v :make clean && make install V=1<CR> |
    \ nmap <silent> <Leader>w :let resp = system(~/.local/bin/west build -p auto)<CR> |
    \ nmap <silent> <Leader>F :let resp = system(~/.local/bin/west flash --flash-opt="-e=chip")<CR> |
    \ nmap <silent> <Leader>h :FSHere<CR> |
    \ nmap <silent> <Leader>H :FSSplitRight<CR>
  au BufEnter *.c compiler gcc

  au BufRead *.c,*.cpp let b:fswitchlocs = '.,../Inc,../include,../Include,../inc'
  au BufRead *.h,*.hpp let b:fswitchlocs = '.,../Src,../source,../Source,../src'

  au Syntax c,cpp setlocal foldmethod=syntax
  au Syntax c,cpp normal! zR

  au FileType python nmap <leader>L :PymodeLint<CR>

  " Remember last location in file, but not for commit messages.
  " see :help last-position-jump
  au BufReadPost * if &filetype !~ '^git\c' && line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g`\"" | endif

  au FileType coffee,rexx,python :setlocal foldmethod=indent

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

" :FZF only works if you have /usr/share/vim/vimfiles/plugins/fzf.vim from
" here https://github.com/junegunn/fzf/tree/master/plugin
map <leader>f :FZF<cr>
map <leader>b :Buffers<cr>
" http://vimcasts.org/e/14
cnoremap %% <C-R>=expand('%:h').'/'<cr>

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
let g:pymode_folding = 0
let g:pymode_indent = 1
let g:pymode_lint = 0

" autotag
let g:autotagTagsFile=".tags"
let g:autotagmaxTagsFileSize="100000000"
" To use debugging, uncomment the line below, open up vim and ':call AutoCmdDebug()'
" let g:autotagVerbosityLevel="10"

" Gundo
nnoremap <silent> <F5> :GundoToggle<CR>
let g:gundo_prefer_python3 = 1

" Disable tmux navigator when zooming the Vim pane
let g:tmux_navigator_disable_when_zoomed = 1
let g:tmux_navigator_preserve_zoom = 1

let g:ackprg = 'ag --vimgrep -U'

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
nnoremap  <Leader>s :cs find 3 <C-r>=expand("<cword>")<CR><CR>

if v:version > 801 || v:version == 801
  packadd termdebug
endif

