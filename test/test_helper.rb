# frozen_string_literal: true

require 'jekyll'
require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'
require 'byebug'

Minitest::Reporters.use!

module Minitest
  class Test
    Dir.chdir('test/fixtures')
    config        = Jekyll.configuration(YAML.load_file('_config.yml'))
    @@site        = Jekyll::Site.new(config)
    @@site.reader.read
  end
end
