class Commodity < ApplicationRecord
    validates :request_id, presence: true
    validates :product_name, presence: true
    
    mount_uploader :image, ImageUploader
    belongs_to :request, optional: true
end
