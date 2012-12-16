colorscheme solarized

" Set color theme based on file type
autocmd FileType css,scss,html,xhtml,haml,erb,sass colorscheme guardian
autocmd FileType python,javascript,coffee colorscheme distinguished
autocmd FileType ruby colorscheme railscasts
autocmd FileType sh colorscheme vividchalk

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
