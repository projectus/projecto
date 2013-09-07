class Project < ActiveRecord::Base

  PROJECT_CATEGORIES = [ "Engineering", "Science", "Arts", "Music", "Sports" ]
	
# Associations ################################
	has_many :collaborations, dependent: :destroy
	has_many :users, through: :collaborations

  has_many :comments, dependent: :destroy
	has_many :taggings, dependent: :destroy
	has_many :tags, through: :taggings

  has_one :project_profile
	
	has_many :applications, class_name: 'CollaborationApplication', dependent: :destroy
	has_many :invitations, class_name: 'CollaborationInvitation', dependent: :destroy

##################################################
# Validation goes here ###########################

  validates :category, inclusion: PROJECT_CATEGORIES

##################################################

  def set_owner(user)
	  owner_collab = collaborations.find_by_role('owner')
	  if owner_collab.nil?
		  Collaboration.create!(role: 'owner', project: self, user: user)
		else
		  owner_collab.user = user
		  owner_collab.save
		end
	end
		
  def owner
	  collaborations.find_by_role('owner').user
	end

  def owned_by?(user)
	  return user == self.owner
	end
		
	def self.tagged_with(name)
		tag = Tag.find_by_name(name.downcase)
		unless tag.nil?
			tag.projects
		else
			return []
		end
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
