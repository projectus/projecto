class Task < ActiveRecord::Base
	belongs_to :poster, class_name: 'User', foreign_key: :poster_id
	belongs_to :task_group
	
	validates :poster, presence: true
  validates :task_group, presence: true
end
