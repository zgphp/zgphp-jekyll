=begin

Generates per-category pagination.

Taken and adapted from:
https://gist.github.com/runemadsen/6263974

Originally from:
http://www.marran.com/tech/category-pagination-in-jekyll/

=end
module Jekyll

  class Pagination < Generator
    def generate(site)
    end
  end

  class CategoryPages < Generator

    safe true

    def generate(site)

      site.pages.dup.each do |page|
        paginate(site, page) if CategoryPager.pagination_enabled?(site.config, page)
      end

    end

    def paginate(site, page)

      # sort categories by descending date of publish
      category_posts = site.categories[page.data['category']].sort_by { |p| -p.date.to_f }

      # calculate total number of pages
      pages = CategoryPager.calculate_pages(category_posts, site.config['paginate'].to_i)

      # iterate over the total number of pages and create a physical page for each
      (1..pages).each do |num_page|

        # the CategoryPager handles the paging and category data
        pager = CategoryPager.new(site, num_page, category_posts, page.data['category'], pages)

        if num_page > 1
          newpage = Page.new(site, site.source, page.dir, page.name)
          newpage.pager = pager
          newpage.dir = File.join(page.dir, "/page#{num_page}")
          site.pages << newpage
        else
          page.pager = pager
        end

      end
    end
  end

  class CategoryPager < Pager

    attr_reader :category

    def self.pagination_enabled?(config, page)
      page.name == 'index.html' && page.data.key?('category') && !config['paginate'].nil?
    end

    # same as the base class, but includes the category value
    def initialize(site, page, all_posts, category, num_pages = nil)
      @category = category
      super site, page, all_posts, num_pages
    end

    # use the original to_liquid method, but add in category info
    alias_method :original_to_liquid, :to_liquid
    def to_liquid
      x = original_to_liquid
      x['category'] = @category
      x
    end

  end

  module Filters

    def pager_links(pager)

      if pager['previous_page'] || pager['next_page']

        html = '<ul class="pager">'

        # Note: switched prev and next so prev would be on the left, and next on the right

        if pager['next_page']
          html << "<li class=\"previous\"><a href=\"/#{pager['category']}/page#{pager['next_page']}\">&laquo; Starije</a></li>"
        end

        if pager['previous_page']
          if pager['previous_page'] == 1
            html << "<li class=\"next\"><a href=\"/#{pager['category']}/\">Novije &raquo;</a></li>"
          else
            html << "<li class=\"next\"><a href=\"/#{pager['category']}/page#{pager['previous_page']}\">Novije &raquo;</a></li>"
          end
        end

        html << '</ul>'
        html
      end
    end
  end
end

