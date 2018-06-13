class RequestStateMachine
    include Statesman::Machine
    
        state :raised, initial: true
        state :accepted
        state :purchased
        state :sent
        state :received
        state :remitted
        state :enquete
        

        transition from: :raised, to: :accepted
        transition from: :accepted, to: :purchased
        transition from: :purchased, to: :sent
        transition from: :sent, to: :received
        transition from: :received, to: :remitted
        transition from: :remitted, to: :enquete
    
end

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
 
  private_class_method :initial_state

  class RequestTransition < ActiveRecord::Base
   include Statesman::Adapters::ActiveRecordTransition

   belongs_to :request, inverse_of: :request_transitions
  end    
end