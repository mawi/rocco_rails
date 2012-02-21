require "rocco_rails/version"
require "rocco"

module RoccoRails

    def self.generate_resources(path, rocco_out)
      files = Dir.entries(path) - [".", ".."]
      out = ""
      files.each do |file|
          out += "<link rel='stylesheet' href='#{[rocco_out, file].join('/')}'>\n" if file.end_with?(".css")
          out += "<script src='#{[rocco_out, file].join('/')}'></script>\n" if file.end_with?(".js")
        end
      out

    end

end
