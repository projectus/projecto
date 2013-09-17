class Tag < ActiveRecord::Base
	has_many :taggings
	has_many :projects, through: :taggings
	
	validates :name, uniqueness: true
end
