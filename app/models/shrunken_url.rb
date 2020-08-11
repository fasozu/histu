class ShrunkenUrl < ApplicationRecord
    validates :url, presence: true
    validates :short_code, presence: true, uniqueness: true
    
    
end
