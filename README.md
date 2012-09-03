Dave's Vim Configuration
==========================

Originally forked from [Mislav](https://github.com/mislav/vimfiles) motivated by his [blog post](http://mislav.uniqpath.com/2011/12/vim-revisited/).

The configuration uses [Pathogen](https://github.com/tpope/vim-pathogen), git submodules, along with some direct repository connections such as SVN.

The decision to use plugins are driven by my web development requirements.
These days these include [Ruby on Rails](https://github.com/rails/rails),
Javascript/[CoffeeScript](http://coffeescript.org/), [HAML](http://haml.info/), and [SASS](http://sass-lang.com/)

Please let me know if there's a *must have* that I haven't found.

## Installation:

Prerequisites: ruby, git, vim compiled with Ruby.

1. Move your existing configuration somewhere else:
   `mv ~/.vim* ~/.gvim* my_backup`
2. Clone this repo into ".vim":
   `git clone https://github.com/Pliny/vimfiles.git ~/.vim`
3. Go into ".vim" and run "rake":
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
* vim-ruby-conque (custom keybindings originally forked from [zolrath](https://github.com/zolrath/vim-ruby-conque))
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
