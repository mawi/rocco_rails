# RoccoRails

Rocco customizable addon to generate docco style documentation in rails projects

## What is rocco/docco?

Rocco is  a quick-and-dirty,  literate-programming-style documentation
generator for Ruby. See the Rocco generated docs for more information:

                <http://rtomayko.github.com/rocco/>


Rocco is a port of,  and borrows heavily from, Docco  -- the original
quick-and-dirty,   hundred-line-long,   literate-programming-style
documentation generator in CoffeeScript:

                <http://jashkenas.github.com/docco/>

## Installation

Add this lines to your application's Gemfile:

    gem 'rocco', :git => "git://github.com/rtomayko/rocco.git"
    gem 'rocco_rails', '~> 0.9'

## Usage

### Easy way

To generate application's documentation into 'docs' directory just run:

    rake rails:rocco

### Custom way

rocco_rails uses a rocco.yml config file inside gem directory. It can be customized by copying it to your application's config directory or running rake rails:rocco_setup.

Default rocco.yml:

    output: docs
    template: lib/templates/layout.mustache
    resources_path: lib/templates/resources
    excluded_items: config/, spec/, db/
    index: README.rdoc

* output => define target directory
* template => moustache template used by rocco to generate html
* resources_path => if you have your own template and want to use your .css or .js just put it into this directory. It will be copied and linked in generated docs
* excluded_items => A comma separated list of directories not to look into
* index => Readme/info of the project. Added as home page in index.html. Uses github gem, so the same style can be used.

Your custom rocco.yml doesn't have to have all options. It will merge whit gem's config. Sample rocco.yml would be good if you don't have a custom template.

You can test your rocco.yml running

    rake rails:test_rocco_config

And then, again

    rake rails:rocco


## Known issues

- Rocco gem that is actualy in rubygems doesn't have the option to select a stylesheet to use. If your generated docs seems to have no style, try to use rocco's github code (see Instalation)

- README files (without extension) are not rendered well. Try to rename to README.rdoc

## Demo

You can see a demo of autogenerated gem documentation in

  http://mawi.github.com/rocco_rails/


## Changelog

### v0.9
- Added support for project's README as home page redered with github gem.
- Fix issue #1

### v0.8.1
- **Mayor fix** Gem is not loaded properly

### v0.8
- **Initial release**



## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
