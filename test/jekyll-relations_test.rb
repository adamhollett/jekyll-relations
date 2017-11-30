# frozen_string_literal: true

require 'test_helper'

module Jekyll
  class RelationsTest < Minitest::Test
    parallelize_me!

    def setup
      @site  ||= @@site
      @pages ||= @site.pages
    end

    # Parent

    def test_page_parent_method
      assert Jekyll::Page.method_defined?(:parent)
    end

    def test_site_index_parent
      page = @pages.find { |p| p.url == '/' }
      assert_nil page.parent
    end

    def test_normal_page_parent
      page = @pages.find { |p| p.url == '/fruit/apple/' }
      assert_equal '/fruit/', page.parent.url
    end

    def test_index_page_parent
      page = @pages.find { |p| p.url == '/fruit/' }
      assert_equal '/', page.parent.url
    end

    # Ancestors

    def test_page_ancestors_method
      assert Jekyll::Page.method_defined?(:ancestors)
      assert Jekyll::Page.method_defined?(:parents)
    end

    def test_normal_page_ancestors
      page = @pages.find { |p| p.url == '/fruit/apple/' }
      assert_equal 2,         page.ancestors.size
      assert_equal '/',       page.ancestors[0].url
      assert_equal '/fruit/', page.ancestors[1].url
    end

    def test_site_index_ancestors
      page = @pages.find { |p| p.url == '/' }
      assert_equal [], page.ancestors
    end

    def test_page_not_in_own_ancestors
      page = @pages.find { |p| p.url == '/fruit/apple/' }
      refute page.ancestors.map(&:url).include?(page.url)
    end

    # Children

    def test_page_children_method
      assert Jekyll::Page.method_defined?(:children)
    end

    def test_normal_page_children
      page = @pages.find { |p| p.url == '/about/' }
      assert_equal [], page.children
    end

    def test_index_page_children
      page = @pages.find { |p| p.url == '/fruit/' }
      assert_equal 4, page.children.size
      assert page.children.map(&:url).include? '/fruit/apple/'
      assert page.children.map(&:url).include? '/fruit/orange/'
      assert page.children.map(&:url).include? '/fruit/peach/'
      assert page.children.map(&:url).include? '/fruit/plum/'
    end

    def test_page_not_in_own_children
      page = @pages.find { |p| p.url == '/fruit/' }
      refute page.children.map(&:url).include?(page.url)
    end
  end
end
