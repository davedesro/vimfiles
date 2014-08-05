if has("unix")
  if system('uname')=~'Darwin'
    set guifont=Menlo\ Regular:h12
    set linespace=2
  else
    set linespace=1
  endif
  set antialias
endif

" Don't beep
set visualbell

set guioptions-=T   " No toolbar
set guioptions-=r   " No scrollbars

if has("gui_macvim")
  " Fullscreen takes up entire screen
  set fuoptions=maxhorz,maxvert
end
