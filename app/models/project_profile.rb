class ProjectProfile < ActiveRecord::Base
  belongs_to :project

  # Make sure every project profile has a project
  validates :project, presence: true

  validate :details_keys_are_formatted_correctly
  
  def details
	  eval self.details_hash
	end
		
  def self.empty_details_entry
		Proc.new{|entry| 
			entry.title "e.g. What we're trying to do"; 
			entry.content "e.g. Something new"}
	end

  def self.empty_details_entry_hash(key)
		details = Jbuilder.encode do |detail|
		  detail.set! key.to_sym do |entry| 
			  ProjectProfile.empty_details_entry.call(entry) 
			end
		end
		eval MultiJson.load(details, symbolize_keys: true).inspect
	end
		
  def generate_empty_details
		details = Jbuilder.encode do |detail|
		  detail.entry_01 do |entry| 
			  ProjectProfile.empty_details_entry.call(entry) 
			end
		end
		self.details_hash = MultiJson.load(details, symbolize_keys: true).inspect
	end
		
	def destroy
	  generate_empty_details
	end

  def update_details_entry(key,fields)
	  details = self.details
		details[key.to_sym] = fields.symbolize_keys
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
