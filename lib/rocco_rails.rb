require File.expand_path('../rocco_rails/lib/rocco_rails/version.rb')
require "rocco"

module RoccoRails

    class << self
    require 'rocco_rails/railtie' if defined?(Rails)
    include Rake::DSL if defined?(Rake::DSL)


    # Rocco only use a var named stylesheet supposed to be the path for the stylesheet. This is a little hack to use it to
    # inject a complete directory. Default is /resources
    def generate_resources(path, rocco_out)
      files = Dir.entries(path) - [".", ".."]
      out = ""
      files.each do |file|
          out += "<link rel='stylesheet' href='#{[rocco_out, file].join('/')}'>\n" if file.end_with?(".css")
          out += "<script src='#{[rocco_out, file].join('/')}'></script>\n" if file.end_with?(".js")
        end
      out

    end

    def generate_file_list(excuded_items = [])
      rails_files = Dir.glob(File.join("**", "*.rb"))
      excuded_items.each do |excluded|
        rails_files.delete_if{|x| x.include?(excluded)}
      end
      rails_files
    end

    #http://stackoverflow.com/questions/760233/generate-a-file-list-based-on-an-array
    def generate_menu(path)

      old_pwd = Dir.pwd
      Dir.chdir(path)
      dirs = Dir["**/*.html"]
      Dir.chdir(old_pwd)

      tree = {}
      menu = ""

      dirs.each do |path|
        current  = tree
        path.split("/").inject("") do |sub_path,dir|
          sub_path = sub_path[0] == ("/") ? sub_path[1..-1] : sub_path
          sub_path = File.join(sub_path, dir)
          current[sub_path] ||= {}
          current  = current[sub_path]
          sub_path
        end
      end
      return print_tree(tree)
    end


    protected

    def print_tree(node)
      out = ""
      out += "<ul>"
      node.each_pair do |path, subtree|
        out +=  path.end_with?(".html") ? "<li> <a href='#{path}'> #{File.basename(path)}</a>" : "<li>#{File.basename(path)}"
        out += print_tree(subtree) unless subtree.empty?
      end
      out += "</li></ul>"
      return out
    end


   end
end
