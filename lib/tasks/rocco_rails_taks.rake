#Taken from https://github.com/hotsh/rstat.us/blob/master/Gemfile

begin
  require 'rocco/tasks'

  desc 'Build rocco docs'
  task :rocco

  begin
    config = YAML.load_file(Rails.root.to_s + "/config/rocco.yml")
    template = Rails.root.to_s + config["template"]
  rescue Exception => e
    gem_path = Gem.loaded_specs['rocco_rails'].full_gem_path
    config = YAML.load_file( gem_path + "/lib/config/rocco.yml")
    template = gem_path + "/"+ config["template"]
  end

  out = config["output"]

  #Rocco::make 'docs/', ["app/models/*.rb", "app/controllers/*.rb"]
  # TODO Only for testing
  Rocco::make out, ["vendor/plugins/rocco/lib/*.rb", "vendor/plugins/rocco/lib/rocco/*.rb"], {:template_file => template}

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