class User < ApplicationRecord
    has_secure_password
    has_many :campaigns, dependent: :destroy
    
    validates :name, presence: true
    validates :occupation, presence: true
    validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :role, presence: true
    # validates :password_hash, presence: true
    validates :token, uniqueness: true, allow_nil: true
    validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

end
