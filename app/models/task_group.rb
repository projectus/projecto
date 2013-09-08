class TaskGroup < ActiveRecord::Base
	belongs_to :project
	has_many :tasks, dependent: :destroy
	
  validates :project, presence: true
end
