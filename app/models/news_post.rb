class NewsPost < ActiveRecord::Base
  default_scope order('created_at DESC')

  belongs_to :project
  belongs_to :user

  has_many :activity_references, as: :referenceable, dependent: :destroy

  validates :user, presence: true
  validates :project, presence: true

  after_create :add_creation_activity_to_activity_feed

  private
    def add_creation_activity_to_activity_feed
	    activity = Activity.new(species:'news post')
	    activity.activity_feed = project.activity_feed
	    activity.save!	
	    activity.activity_references.create(referenceable: self, title: 'post')
	  end
end
