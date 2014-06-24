Dave's Vim Configuration
==========================

Originally forked from [Mislav](https://github.com/mislav/vimfiles) motivated by his [blog post](http://mislav.uniqpath.com/2011/12/vim-revisited/). I routinely cherry pick his checkins.

The configuration uses [Vundle](https://github.com/gmarik/Vundle.vim).

The decision to use plugins are driven by my development requirements.
[Ruby on Rails](https://github.com/rails/rails),
Javascript/[CoffeeScript](http://coffeescript.org/), [HAML](http://haml.info/), [SASS](http://sass-lang.com/),
[C](http://en.wikipedia.org/wiki/C_(programming_language)),
 and [BASH](http://www.gnu.org/software/bash/).

I put effort in making sure all plugins play nicely and are consistent
indepenedent of language.

Please let me know if there's a *must have* that I haven't found.

## Installation:

Prerequisites: ruby, git, vim compiled with Ruby and Python (if [youcompleteme](https://github.com/Valloric/YouCompleteMe) is enabled).

1. Manually `git clone` vundle and put it in the bundle directory
2. Move your existing configuration somewhere else:
   `mv ~/.vim* ~/.gvim* my_backup`
3. Clone this repo into ".vim":
   `git clone https://github.com/Pliny/vimfiles.git ~/.vim`
4. Go into ".vim" and run "rake":
   `cd ~/.vim && rake`

This will install "~/.vimrc" and "~/.gvimrc" symlinks that point to
files inside the ".vim" directory.

## Features:

* 2 spaces, no tabs
* incremental, case-insensitive search
* 'Leader' character mapped to "," (comma)
* `,f` opens file search via :CommandT plugin
* `,,` switches between two last buffers
* `<C-j/k/h/l>` switches between windows (no need to prepend `<C-w>`)
* cursor keys for movement disabled!
* run rspec tests in editor
* handy autocomplete features for brackets and blocks
* `<M-l/h>` pushes/pops the tag stack
* Different color schemes for different languages
* Basic shell support
* autocompletion with `<tab>`

## Plugins:

* ack
* command-t
* commentary
* endwise
* fugitive
* markdown
* rails
* haml
* scss
* coffee-script
* conque
* vim-ruby-conque
* delimitmate
* gundo
* javascript
* json
* matchit
* surround
* tcomment
* vim-pasta
* mustache
* ruby
* taglist
* markdown-folding
* eunuch
* clang_complete
* supertab
* youcompleteme
