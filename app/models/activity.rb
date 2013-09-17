class Activity < ActiveRecord::Base
  default_scope order('created_at DESC')

  belongs_to :activity_feed

  has_many :activity_references, dependent: :destroy

  validates_presence_of :activity_feed

  def referenceable_by_type(type)
	  ref = activity_references.where(title: type).first
	  return ref.referenceable unless ref.nil?
	  nil
	end
end
