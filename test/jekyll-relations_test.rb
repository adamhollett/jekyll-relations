# frozen_string_literal: true

require 'test_helper'

module Jekyll
  class RelationsTest < Minitest::Test
    jekyll_config = YAML.load_file('test/fixtures/_config.yml')
    config        = Jekyll.configuration(jekyll_config)
    @site         = Jekyll::Site.new(config)
    @site.reader.read

    byebug

    def test_page_parent_method
      assert Jekyll::Page.method_defined?(:parent)
    end

    def test_page_ancestors_method
      assert Jekyll::Page.method_defined?(:ancestors)
      assert Jekyll::Page.method_defined?(:parents)
    end

    def test_page_children_method
      assert Jekyll::Page.method_defined?(:children)
    end
  end
end
