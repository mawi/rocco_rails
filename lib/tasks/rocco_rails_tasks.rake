# Taken from https://github.com/hotsh/rstat.us/blob/master/lib/tasks/rocco.rake and
# https://github.com/rtomayko/rocco/blob/master/lib/rocco/tasks.rb

begin
  require 'rocco/tasks'

  desc 'Build rocco docs'
  task :rocco

  # If exists a config/rocco.yml in rails path use it
  begin
    base_path = Rails.root.to_s + "/"
    config = YAML.load_file(base_path + "config/rocco.yml")
  rescue Exception => e
    base_path = Gem.loaded_specs['rocco_rails'].full_gem_path + "/"
    config = YAML.load_file(base_path + "lib/config/rocco.yml")
  end

  # Set variables. Have to use absolute path for css to use it in local
  out = config["output"]
  template = base_path + config["template"]
  stylesheet = [Rails.root.to_s, out, "resources", config["stylesheet_name"]].join("/")
  resources_path = base_path + config["resources_path"]


  #Rocco::make 'docs/', ["app/models/*.rb", "app/controllers/*.rb", "app/uploaders/*.rb", "app/workers/*.rb"], {:template_file => template, :stylesheet => RoccoRails.generate_resources(resources_path, [Rails.root.to_s, out, "resources"].join("/")) }
  # TODO Only for testing
  Rocco::make out, ["vendor/plugins/rocco/lib/*.rb", "vendor/plugins/rocco/lib/rocco/*.rb"], {:template_file => template, :stylesheet => RoccoRails.generate_resources(resources_path, [Rails.root.to_s, out, "resources"].join("/")) }

  # Copy resources folder to out folder
  FileUtils.mkdir_p(out + "/resources") if Dir[out].blank?
  FileUtils.cp_r(resources_path, out)



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