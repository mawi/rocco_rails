#Taken from https://github.com/hotsh/rstat.us/blob/master/Gemfile

begin
  require 'rocco/tasks'

  desc 'Build rocco docs'
  task :rocco
  Rocco::make 'docs/', ["app/models/*.rb", "app/controllers/*.rb"]

  desc 'Build docs and open in browser for the reading'
  task :read => :rocco do
    sh 'open docs/index.html'
  end

  # Convenient aliases
  desc 'Build rocco docs'
  task :doc => :rocco
  desc 'Build rocco docs'
  task :docs => :rocco

rescue LoadError
  warn "#$! -- rocco tasks not loaded."
  task :rocco
end