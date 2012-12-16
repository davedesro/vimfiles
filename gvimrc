colorscheme solarized

" Set color theme based on file type
if has("autocmd")
  au FileType css,scss,html,xhtml,haml,erb,sass colorscheme guardian
  au FileType python,javascript,coffee colorscheme distinguished
  au FileType ruby colorscheme railscasts
  au FileType sh colorscheme vividchalk
  au FileType c colorscheme jellybeans
endif

set guifont=Menlo\ Regular:h12
set linespace=2
set antialias

" Don't beep
set visualbell

set guioptions-=T   " No toolbar
set guioptions-=r   " No scrollbars

if has("gui_macvim")
  " Fullscreen takes up entire screen
  set fuoptions=maxhorz,maxvert
end
