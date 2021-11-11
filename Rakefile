# Requirements:
#  - ctags
#  - vim version 7.3.584+ needed for YouCompleteMe
#  - Get latest vundle here: git@github.com:gmarik/vundle.git
#    and place it  vimfiles/bundle/
#    TODO:
#      - link .vim properly
#      - git clone Vundle.vim, rename and move to bundle/vundle

task :default => [:link, :tmp_dirs, :update, :youcompleteme, :pyclewn]

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

desc %(Fetch and Compile pyclewn plugin)
task :pyclewn => :macvim_check do
  vim                  = which('mvim') || which('vim') or abort "vim not found on your system"
  python               = read_python_version(vim)
  pyclewn_version      = "pyclewn-1.11.py2"
  pyclewn_install_file = "#{pyclewn_version}.tar.gz"
  pyclewn_path         = 'bundle/pyclewn'

  if python
    puts "Fetching #{pyclewn_install_file}..."
    Dir.chdir 'tmp' do
      sh "wget 'http://sourceforge.net/projects/pyclewn/files/latest/download?source=files' -O #{pyclewn_install_file}"
      sh "tar -xvzf #{pyclewn_install_file}"
      Dir.chdir pyclewn_version do
        puts "Installing #{pyclewn_version}..."
        # sh "vimdir=$HOME/.vim/#{pyclewn_path} python setup.py install --force"
        sh "sudo python setup.py install --force"
      end
    end
  else
    warn color('Warning:', 31) + " Can't install pyclewn, no python support in #{vim}"
  end
end

desc %(Compile YouCompleteMe plugin)
task :youcompleteme => :macvim_check do
  Dir.chdir "bundle/YouCompleteMe" do
    puts "Compiling YouCompleteMe plugin..."
    sh "./install.sh --clang-completer"
  end
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
