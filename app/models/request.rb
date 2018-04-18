class Request < ApplicationRecord
    validates :user_id, presence: true
    validates :title, presence: true
    validates :budget, presence: true
    validates :description, presence: true
    
    belongs_to :user
end
