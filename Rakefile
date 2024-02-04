# Requirements:
#  - ctags
#  - Get latest vundle here: git@github.com:gmarik/vundle.git
#    and place it  vimfiles/bundle/
#    TODO:
#      - link .vim properly
#      - git clone Vundle.vim, rename and move to bundle/vundle

task :default => [:link, :tmp_dirs, :update]

desc %(Update or create bundles in the bundle/ directory)
task :update do
  sh "vim +PluginInstall! +qall"
end

desc %(Make ~/.vimrc and ~/.gvimrc symlinks)
task :link do
  %w[vimrc gvimrc].each do |script|
    dotfile = File.join(ENV['HOME'], ".#{script}")
    if File.exist? dotfile
      warn "~/.#{script} already exists"
    else
      ln_s File.join('.vim', script), dotfile
    end
  end
end

task :tmp_dirs do
  mkdir_p "_backup"
  mkdir_p "_temp"
end

task :macvim_check do
  if mvim = which('mvim') and '/usr/bin/vim' == which('vim')
    warn color('Warning:', 31) + " You have MacVim installed, but `vim` still opens system Vim."
    warn "To use MacVim version when you invoke `vim`:  " + color("$ ln -s mvim #{File.dirname(mvim)}/vim", 37)
  end
end

def color msg, code
  if $stderr.tty? then "\e[1;#{code}m#{msg}\e[m"
  else msg
  end
end

#
# Read which ruby version is vim compiled against
#
def read_ruby_version vim
  script = %{require "rbconfig"; print File.join(RbConfig::CONFIG["bindir"], RbConfig::CONFIG["ruby_install_name"])}
  version = `#{vim} --nofork --cmd 'ruby #{script}' --cmd 'q' 2>&1 >/dev/null | grep -v 'Vim: Warning'`.strip
  version unless version.empty? or version.include?("command is not available")
end

#
# Read which python version is vim compiled against
#
def read_python_version vim
  script = %{print (sys.version)}
  version = `#{vim} --nofork --cmd 'python #{script}' --cmd 'q' 2>&1 >/dev/null | grep -v 'Vim: Warning' | head -1 | cut -d ' ' -f 1`.strip
  version unless version.empty? or version.include?("command is not available")
end

# Cross-platform way of finding an executable in the $PATH.
#
#   which('ruby') #=> /usr/bin/ruby
def which cmd
  exts = ENV['PATHEXT'] ? ENV['PATHEXT'].split(';') : ['']
  ENV['PATH'].split(File::PATH_SEPARATOR).each do |path|
    exts.each { |ext|
      exe = "#{path}/#{cmd}#{ext}"
      return exe if(File.executable?(exe) and !File.directory?(exe))
    }
  end
  return nil
end
