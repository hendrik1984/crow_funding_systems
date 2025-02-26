class Campaign < ApplicationRecord
    belongs_to :user

    validates :name, presence: true
    validates :short_description, presence: true
    validates :description, presence: true
    validates :goal_amount, presence: true, numericality: { greater_than: 0 }
    validates :current_amount, presence: true, numericality: { greater_than_or_equal_to: 0 }
    validates :backer_count, presence: true, numericality: { greater_than_or_equal_to: 0 }
    validates :slug, presence: true, uniqueness: true
    
end
