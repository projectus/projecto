class Project < ActiveRecord::Base

  CATEGORIES = [ "engineering", "science", "arts", "music", "sports" ]
	
  # Associations ################################

  #belongs_to :activity_feed
  has_one  :activity_feed, as: :subscribable, dependent: :destroy
  #has_many :subscribers, through: :activity_feed, foreign_key: :user_id

	has_many :collaborations, dependent: :destroy
	has_many :users, through: :collaborations
	belongs_to :owner, class_name: 'User', foreign_key: :owner_id

	has_many :task_groups, dependent: :destroy	
	has_many :tasks, through: :task_groups
	
  has_many :comments, dependent: :destroy
  has_many :news, class_name: 'NewsPost', dependent: :destroy

	has_many :taggings, dependent: :destroy
	has_many :tags, through: :taggings

  has_one :profile, class_name: 'ProjectProfile', dependent: :destroy
	
	has_many :applications, class_name: 'CollaborationApplication', dependent: :destroy
	has_many :invitations, class_name: 'CollaborationInvitation', dependent: :destroy

  # Validation ################################

  validates :category, inclusion: CATEGORIES
  validates :owner, presence: true

  # Before validation ##############################

  before_validation do self.category.downcase! end

	# After create ###################################

  after_create :create_empty_profile, :create_project_activity_feed, :subscribe_owner
		
  # Public methods #################################

  def self.categories
	  CATEGORIES.map(&:capitalize)
	end
	
  def owned_by?(user)
	  return user == self.owner
	end
		
	def self.tagged_with(tagname)
		tag = Tag.find_by_name(tagname.downcase)
		unless tag.nil?
			tag.projects
		else
			return []
		end
	end

	def self.tagged_with_something_like(tagname)
		Project.joins(:tags).where("tags.name LIKE ?", "%#{tagname.downcase}%")
	end
		
	def self.tag_counts
		Tag.select("tags.*, count(taggings.tag_id) as count").
		  joins(:taggings).group("taggings.tag_id")
	end
	
	def tag_list
		tags.map(&:name).join(",")
	end
	
	def tag_list=(names)
		self.tags = names.split(",").map do |n|
			Tag.where(name: n.strip.downcase).first_or_create!
	  end
	end
	
	# Private methods ###################################

  private
    # Create empty project profile associated with self
    def create_empty_profile
      profile = build_profile
      profile.generate_empty_outline
      profile.save!
    end

    # Subscribe owner to his project
    def subscribe_owner
	    owner.subscribe(activity_feed)
	  end
	
	  def create_project_activity_feed
		  create_activity_feed
		end	
end
