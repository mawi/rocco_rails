# From http://blog.nathanhumbert.com/2010/02/rails-3-loading-rake-tasks-from-gem.html

require 'rocco_rails'
require 'rails'
module RoccoRails
  class Railtie < Rails::Railtie
    # railtie_name :rocco_rails

    rake_tasks do
      load "tasks/rails_tasks.rake"
    end
  end
end