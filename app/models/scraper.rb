class Scraper < Kimurai::Base
    @name = "scraper"
    @engine = :selenium_chrome
  
    def self.process(url)
        @start_urls = [url]
        self.crawl!
    end

    def parse(response, url:, data: {})
    end  
end
