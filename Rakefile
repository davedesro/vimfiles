task :default => [:tmp_dirs, :update, :command_t, :autotag, :conque, :link]

desc %(Bring bundles up to date)
task :update => [ :autotag, :conque ] do
  sh "git submodule sync >/dev/null"
  sh "git submodule update --init"
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

desc %(Compile Command-T plugin)
task :command_t => :macvim_check do
  vim = which('mvim') || which('vim') or abort "vim not found on your system"
  ruby = read_ruby_version(vim)

  Dir.chdir "bundle/command-t/ruby/command-t" do
    if ruby
      puts "Compiling Command-T plugin..."
      sh(*Array(ruby).concat(%w[extconf.rb]))
      sh "make clean && make"
    else
      warn color('Warning:', 31) + " Can't compile Command-T, no ruby support in #{vim}"
      sh "make clean"
    end
  end
end

task :macvim_check do
  if mvim = which('mvim') and '/usr/bin/vim' == which('vim')
    warn color('Warning:', 31) + " You have MacVim installed, but `vim` still opens system Vim."
    warn "To use MacVim version when you invoke `vim`:  " + color("$ ln -s mvim #{File.dirname(mvim)}/vim", 37)
  end
end

desc %(Add the trunk of conque)
task :conque => :macvim_check do
  svn = which('svn') or abort "svn not found on your system"
  if File.directory?("bundle/conque")
    Dir.chdir "bundle/conque" do
      sh "svn update"
    end
  else
    sh "svn checkout http://conque.googlecode.com/svn/trunk/ bundle/conque"
  end
end

desc %(Add the autotag plugin)
task :autotag => :macvim_check do
  vim = which('mvim') || which('vim') or abort "vim not found on your system"
  sh "mkdir -p bundle/autotag/plugin"
  Dir.chdir "bundle/autotag/plugin" do
    sh "curl https://raw.github.com/craigemery/dotFiles/master/vim/plugin/autotag.vim -o autotag.vim"
  end
end

def color msg, code
  if $stderr.tty? then "\e[1;#{code}m#{msg}\e[m"
  else msg
  end
end

# Read which ruby version is vim compiled against
def read_ruby_version vim
  script = %{require "rbconfig"; print File.join(RbConfig::CONFIG["bindir"], RbConfig::CONFIG["ruby_install_name"])}
  version = `#{vim} --nofork --cmd 'ruby #{script}' --cmd 'q' 2>&1 >/dev/null | grep -v 'Vim: Warning'`.strip
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
      return exe if File.executable? exe
    }
  end
  return nil
end
