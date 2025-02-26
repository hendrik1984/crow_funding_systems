class User < ApplicationRecord
    has_many :campaigns, dependent: :destroy
    
    validates :name, presence: true
    validates :email, presence: true, uniqueness: true
    validates :role, presence: true
    validates :password_hash, presence: true

end
