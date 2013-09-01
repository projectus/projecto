class Project < ActiveRecord::Base
	has_many :collaborations
	has_many :users, through: :collaborations
end
