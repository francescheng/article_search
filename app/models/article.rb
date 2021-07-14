class Article < ApplicationRecord
    # validates :title, :link, presence: true
    after_validation :get_heading

    def get_heading
        headings = []
        page = MetaInspector.new(link)
        headings << page.h1
        headings << page.h2
        headings << page.h3
        @title = page.title
        @body = headings.join(", ")
    end
end
