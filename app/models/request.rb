class Request < ApplicationRecord
    include Statesman::Adapters::ActiveRecordQueries
    
    validates :user_id, presence: true
    validates :title, presence: true
    validates :budget, presence: true
    validates :description, presence: true
    
    belongs_to :user
    has_many :commodities
    accepts_nested_attributes_for :commodities
    mount_uploader :image, ImageUploader
    
    has_many :request_transitions, autosave: false

  def state_machine
    @state_machine ||= RequestStateMachine.new(self, transition_class: RequestTransition)
  end

  def self.transition_class
    RequestTransition
  end

  def self.initial_state
    :raised
  end

  has_many :transitions, class_name: "RequestTransition", autosave: false

  # Initialize the state machine
  def state_machine
    @state_machine ||= RequestStateMachine.new(self, transition_class: RequestTransition,
                                                   association_name: :transitions)
  end

  # Optionally delegate some methods
  delegate :can_transition_to?, :transition_to!, :transition_to, :current_state,
           to: :state_machine 
 
  private_class_method :initial_state
end

