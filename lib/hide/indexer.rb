module Hide
  class Indexer

    attr_reader :index

    def initialize(index_name)
      @site  = Hide::Site.new(Hide.config(:path), :pages_directories => Hide.config(:directories))
      @index = Slingshot.index index_name
    end

    def setup
      index.create :mappings => Hide.config(:mappings), :settings => Hide.config(:settings)
    end

    def destroy!
      index.delete
    end

    def reindex!
      (@site.pages + @site.posts).each do |page|
        next unless page.title
        index_page page
      end
      index.refresh
    end

    def update! before, after
      updater = Updater.new @site, before, after
      updater.update_site

      (updater.updated_pages + updater.updated_posts).each do |page|
        next unless page.title
        index_page page
      end
      index.refresh
    end

    def index_page(page)
      p ['INDEXING', page.category, page.id]
      p index.store( page.category.to_s, page)
    end

  end
end
