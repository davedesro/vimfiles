#! /usr/bin/env ruby
##
## Script useful if doing rails development
##
## Generate all tags for all gems in a rails directory and
## included by bundler in tags
##
## Basically does the same as "bundle show gemname", except for all gems.
## Interestingly enough, "bundle show" without any arguments falls back to
## "bundle list", otherwise the whole thing could have been a bash one-liner.

require 'bundler'

paths = Bundler.load.specs.map(&:full_gem_path)

system("ctags -f tags --exclude='public/**' --exclude='coverage/**' --exclude='db/**' --exclude='log/**' --exclude='tmp/**'  -R *")
system("ctags -R -f tags -a #{paths.join(' ')}")
