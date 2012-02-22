# Taken from https://github.com/hotsh/rstat.us/blob/master/lib/tasks/rocco.rake and
# https://github.com/rtomayko/rocco/blob/master/lib/rocco/tasks.rb
require 'rocco/tasks'
require 'erb'

namespace :rails do
     # If exists a config/rocco.yml in rails path use it
    def load_config
      @gem_path = Gem.loaded_specs['rocco_rails'].full_gem_path + "/"
      gem_config = YAML.load_file(@gem_path + "lib/config/rocco.yml")
      begin
        @base_path = Rails.root.to_s + "/"
        rails_config = YAML.load_file(@base_path + "config/rocco.yml")
        @config = gem_config.merge(rails_config)
      rescue Exception => e
        @base_path = @gem_path
        @config = gem_config
      end

      @out = @config["output"]

      template = @base_path + @config["template"]
      @template = File.exists?(template) ? template : @gem_path + @config["template"]

      resources_path = @base_path + @config["resources_path"]
      @resources_path = File.exists?(resources_path) ? resources_path : @gem_path + @config["resources_path"]

      @excluded_items =  @config["excluded_items"].split(", ")

    end



    desc 'Build rocco docs'
    task :rocco_docs

      load_config
      Rocco::Task.new(:rocco_docs, @out, RoccoRails.generate_file_list(@excluded_items), {:template_file => @template, :stylesheet => RoccoRails.generate_resources(@resources_path, [Rails.root.to_s, @out, "resources"].join("/")) })

      # Copy resources folder to out folder
      FileUtils.mkdir_p(@out + "/resources") if Dir[@out].blank?
      FileUtils.cp_r(@resources_path, @out)


    desc 'Generates and index.html for a rocco folder'
    task :rocco_index do
      load_config
      @menu = RoccoRails.generate_menu(@out)
      @title = "Rocco Documentation"
      ["menu", "index"].each do |page|
        template = File.read("/Users/mmarin/Work/rocco_rails/lib/templates/#{page}.erb")
        html = ERB.new(template, 0, "%<>").result
        File.open(@out + "/#{page}.html", 'w') {|f| f.write(html) }
      end

    end

    desc 'Test actual config.yml'
    task :test_rocco_config do
      load_config


      p "Template exist => #{File.exists?(@template)}"
      p "Resources exist => #{File.exists?(@resources_path)}"
      p "List of files to generate docs => #{RoccoRails.generate_file_list(@excluded_items)}"
    end

    desc 'Copy rocco.yml to rails config path'
    task :rocco_setup do
      yml_path = [Gem.loaded_specs['rocco_rails'].full_gem_path, "lib", "config", "rocco.yml.sample"].join("/")
      FileUtils.cp(yml_path, Rails.root.to_s + "/config/rocco.yml")
      p "rocco.yml copied to config/rocco.yml"
    end

    task :rocco => [:rocco_docs, :rocco_index]

end