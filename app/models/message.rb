class Message < ApplicationRecord
    after_create_commit { MessageBroadcastJob.perform_later self }
    # belongs_to :from, class_name: "User"
    # belongs_to :to, class_name: "User"
    
    default_scope -> {order(created_at: :asc)}
    
    # validates :from_id, presence: true
    # validates :to_id, presence: true
    # validates :request_id, presence: true
    validates :content, presence: true, length: {maximum: 100}
    
    def Message.recent_in_request(request_id)
        where(request_id: request_id).last(500)
    end
    
end
