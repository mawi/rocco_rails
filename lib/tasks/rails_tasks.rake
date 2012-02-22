# Taken from https://github.com/hotsh/rstat.us/blob/master/lib/tasks/rocco.rake and
# https://github.com/rtomayko/rocco/blob/master/lib/rocco/tasks.rb
require 'rocco/tasks'

namespace :rails do
     # If exists a config/rocco.yml in rails path use it
    def load_config
      begin
        @base_path = Rails.root.to_s + "/"
        @config = YAML.load_file(@base_path + "config/rocco.yml")
      rescue Exception => e
        @base_path = Gem.loaded_specs['rocco_rails'].full_gem_path + "/"
        @config = YAML.load_file(@base_path + "lib/config/rocco.yml")
      end
    end



    desc 'Build rocco docs'
    task :rocco



    load_config

    # Set variables. Have to use absolute path for css to use it in local
    out = @config["output"]
    template = @base_path + @config["template"]
    stylesheet = [Rails.root.to_s, out, "resources", @config["stylesheet_name"]].join("/")
    resources_path = @base_path + @config["resources_path"]
    excluded_items =  @config["excluded_items"].split(", ")

    p "lalala"
    Rocco::make out, RoccoRails.generate_file_list(excluded_items), {:template_file => template, :stylesheet => RoccoRails.generate_resources(resources_path, [Rails.root.to_s, out, "resources"].join("/")) }


    # Copy resources folder to out folder
    FileUtils.mkdir_p(out + "/resources") if Dir[out].blank?
    FileUtils.cp_r(resources_path, out)




    desc 'Test actual config.yml'
    task :test_rocco_config do
      load_config
      out = @config["output"]
      template = @base_path + @config["template"]
      stylesheet = [Rails.root.to_s, out, "resources", @config["stylesheet_name"]].join("/")
      resources_path = @base_path + @config["resources_path"]
      excluded_items =  @config["excluded_items"].split(", ")

      p "Template exist => #{File.exists?(template)}"
      p "Resources exist => #{File.exists?(resources_path)}"
      p "List of files to generate docs => #{RoccoRails.generate_file_list(excluded_items)}"
    end

    desc 'Copy rocco.yml to rails config path'
    task :rocco_setup do
      yml_path = [Gem.loaded_specs['rocco_rails'].full_gem_path, "lib", "config", "rocco.yml"].join("/")
      FileUtils.cp(yml_path, Rails.root.to_s + "/config/rocco.yml")
      p "rocco.yml copied to config/rocco.yml"
    end

end