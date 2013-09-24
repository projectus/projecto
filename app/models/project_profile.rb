class ProjectProfile < ActiveRecord::Base
  belongs_to :project

  has_one :avatar, as: :avatarable

  # Make sure every project profile has a project
  validates :project, presence: true

  validate :details_keys_are_formatted_correctly
  
  def details
	  eval self.details_hash
	end
		
  def self.empty_details_entry
		{ :title => "e.g. What we're trying to do", 
			:content => "e.g. Something new" }
	end

  def generate_empty_avatar
		build_avatar	
	end
			
  def generate_empty_details
		details = {} 
	  details[:entry_01] = ProjectProfile.empty_details_entry 
		self.details_hash = details.inspect
	end
		
	def destroy
	  generate_empty_details
	end

  def update_details_entry(key,fields)
	  details = self.details
	  symkey = key.to_sym
	  if details[symkey].nil?
		  details[symkey] = ProjectProfile.empty_details_entry
		end
		details[symkey].update(fields.symbolize_keys)
    self.details_hash = details.inspect
	end
	
	def delete_details_entry(key)
	  details = self.details
	  details.delete(key.to_sym)
	  self.details_hash = details.inspect
	  save!
	end
	
	private
	  def details_keys_are_formatted_correctly
		  keys = details.keys
		  keys.each do |key|
			  unless key =~ /entry_(\d\d)/
				  errors[:base] << "Incorrect entry key format. You may have too many entries."
				  return 
				end			
			end
		end					
end
