class Commodity < ApplicationRecord
    validates :product_name, presence: true
    
    mount_uploader :image, ImageUploader
    belongs_to :request, optional: true, foreign_key: "request_id"
end
