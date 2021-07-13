class Article < ApplicationRecord
    validates :title, :link, presence: true
end
