class Article < ApplicationRecord
    validates :title, :link, presence: true

    include PgSearch::Model
    pg_search_scope :search_by_title_and_body,
        against: [ :title, :body ],
        using: {
        tsearch: { prefix: true }
        }

    def create_short_link
        
    end
    
    private

    def get_short_link
        url = "https://api-ssl.bitly.com/v4/shorten"
        headers = {"Content-Type": "application/json", "Authorization": ENV['TOKEN']}
        body = {"long_url": link}.to_json
        response = HTTParty.post(url, body: body, headers: headers, format: :json)

        return response.parsed_response["id"]
    end
end
