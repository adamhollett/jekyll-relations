# frozen_string_literal: true

module Jekyll
  module Relations
    module Page
      # The next highest page in the folder structure.
      #
      # Returns the Page object for the parent page.
      def parent
        @parent ||= begin
          depth = url.count('/')
          site.pages
            .select(&:html?)
            .find { |p| url.start_with?(p.url) && p.url.count('/') == depth - 1 }
        end
      end

      # A list of ancestors from the site index to the current page.
      #
      # Returns an Array of Page objects or an empty Array.
      def ancestors
        @ancestors ||= begin
          return [] unless parent
          ancestors = []
          i = self
          while i.parent
            ancestors << i.parent
            i = i.parent
          end
          ancestors.reverse
        end
      end
      alias_method :parents, :ancestors

      # A list of the pages directly below this one in the folder structure.
      #
      # Returns an Array of Page objects or an empty Array.
      def children
        return [] unless index?
        @children ||= begin
          depth = url.count('/')
          site.pages
            .select(&:html?)
            .select { |p| p.url.start_with?(url) && p.url.count('/') == depth + 1 }
        end
      end

      # Convert the new Page data to a Hash suitable for use by Liquid.
      #
      # Returns the Hash representation of this Page.
      def to_liquid(attrs = Jekyll::Page::ATTRIBUTES_FOR_LIQUID)
        super(attrs + %w(parent ancestors parents children))
      end
    end
  end
end

Jekyll::Page.prepend Jekyll::Relations::Page
