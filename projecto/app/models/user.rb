class User < ActiveRecord::Base
	has_many :collaborations, dependent: :destroy
	has_many :projects, through: :collaborations
	
	has_secure_password
	validates :password, :username, presence: true
	validates :username, uniqueness: true 
end
