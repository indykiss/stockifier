class User < ApplicationRecord
    # If I'm having problems with the password: 
    # has_secure_password validations: false
    has_secure_password
    validates :password, presence: true, length: { minimum: 4 }
    has_many :stocks

    validates :email, presence: true, uniqueness: true
end
