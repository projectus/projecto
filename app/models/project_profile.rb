class ProjectProfile < ActiveRecord::Base
  belongs_to :project

  # Make sure every project profile has a project
  validates :project, presence: true

  def outline
	  eval self.outline_hash
	end
	
  def generate_empty_outline
		outline = Jbuilder.encode do |outline|
		  outline.about do |about|
			  about.entry_1 do |entry|
				  entry.title "e.g. What we're trying to do"
				  entry.content "e.g. something new"
				end
		  end
		end
		self.outline_hash = MultiJson.load(outline, symbolize_keys: true).inspect
	end
		
	def destroy
	  generate_empty_outline
	end
end
