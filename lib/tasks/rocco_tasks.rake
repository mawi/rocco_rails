require File.expand_path('../rocco_rails/lib/rocco_rails.rb')

require 'rocco/tasks'
require 'erb'


    def load_config
      @config = YAML.load_file("lib/config/rocco.yml")
      @out = @config["output"]
      @template = @config["template"]
      @resources_path = @config["resources_path"]
    end

    desc 'Build rocco_rails docs'
    task :rocco_docs
      load_config
      Rocco::make(@out, Dir["**/*.rb"] + Dir["**/*.rake"], {:template_file => @template, :stylesheet => RoccoRails.generate_resources(@resources_path, "/rocco_rails/resources") })

      # Copy resources folder to out folder



    task :rocco_index do
      load_config
      @menu = RoccoRails.generate_menu(@out)
      @title = "Rocco Documentation"
      ["menu", "index"].each do |page|
        template = File.read("lib/templates/#{page}.erb")
        html = ERB.new(template, 0, "%<>").result
        File.open(@out + "/#{page}.html", 'w') {|f| f.write(html) }
      end
      FileUtils.cp_r("lib/templates/menu_resources/.", @out + "/resources")
      FileUtils.cp_r("lib/templates/resources/.",  @out + "/resources")

    end

    task :rocco => [:rocco_docs, :rocco_index]