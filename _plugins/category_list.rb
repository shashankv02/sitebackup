module Jekyll
    
    class CategoryPage < Page
        def initialize(site, base, dir, category)
            @site = site
            @base = base
            @dir = dir
            @name = 'index.html'
            
            self.process(@name)
            self.read_yaml(File.join(base, '_layouts'), 'category_index.html')
            self.data['category'] = category
            
            category_title_prefix = site.config['category_title_prefix'] || 'Category: '
            self.data['title'] = "#{category_title_prefix}#{category}"
        end
    end
    
    class CategoryPageGenerator < Generator
        safe true
        
        def generate(site)
            if site.layouts.key? 'category_index'
                dir = site.config['category_dir'] || 'topic'
                site.categories.keys.each do |category|
                    create_categories(site, File.join(dir, category), category)
                end
            end
        end
        def create_categories(site, dir, cat)
            cat_page = CategoryPage.new(site, site.source, dir, cat)
            cat_page.render(site.layouts, site.site_payload)
            cat_page.write(site.dest)
            site.pages << cat_page
        end
    end
    
end
