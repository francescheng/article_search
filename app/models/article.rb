class Article < ApplicationRecord
    validates :title, :link, presence: true
    after_validation :create_short_link, :set_reading_time
    include PgSearch::Model
    pg_search_scope :search_by_title_and_body,
        against: [ :title, :body ],
        using: {
        tsearch: { prefix: true }
        }

    def create_short_link
        self.short_link = get_short_link
    end
    
    private

    def get_short_link
        url = "https://api-ssl.bitly.com/v4/shorten"
        headers = {"Content-Type": "application/json", "Authorization": ENV['TOKEN']}
        body = {"long_url": link}.to_json
        response = HTTParty.post(url, body: body, headers: headers, format: :json)

        return response.parsed_response["id"]
    end

    def set_reading_time
        wpm = 250
        text = Nokogiri::HTML(URI.open(link)).xpath("//p").inner_text
        word_count = text.scan(/\w+/).length
        self.reading_time = (word_count / wpm).to_i
    end
end
