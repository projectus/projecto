class Project < ActiveRecord::Base
	has_many :collaborations
	has_many :users, through: :collaborations
	
	has_many :taggings
	has_many :tags, through: :taggings
	
	def self.tagged_with(name)
		Tag.find_by_name!(name.downcase).projects
	end
	
	def self.tag_counts
		Tag.select("tags.*, count(taggings.tag_id) as count").
		  joins(:taggings).group("taggings.tag_id")
	end
	
	def tag_list
		tags.map(&:name).join(", ")
	end
	
	def tag_list=(names)
		self.tags = names.split(",").map do |n|
			Tag.where(name: n.strip.downcase).first_or_create!
	  end
	end	
end
