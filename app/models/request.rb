class Request < ApplicationRecord
    validates :user_id, presence: true
    validates :title, presence: true
    validates :budget, presence: true
    validates :description, presence: true
    
    belongs_to :user
    has_many :commodities
    accepts_nested_attributes_for :commodities
    mount_uploader :image, ImageUploader
end
