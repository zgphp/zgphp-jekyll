#
# Category navigation
#
# Implements next/previous links for posts within the same category
#

module Jekyll
    class CategoryAwareNavigationGenerator < Generator

        safe true
        priority :high

        def generate(site)
            site.categories.each_pair do |category_name, posts|
                posts.sort! { |a, b| a <=> b }

                posts.each do |post|
                    position = posts.index post

                    if position && position < posts.length - 1
                        post.data["category_next"] = posts[position + 1]
                    end

                    if position && position > 0
                        post.data["category_prev"] = posts[position - 1]
                    end
                end
            end
        end
    end
end
