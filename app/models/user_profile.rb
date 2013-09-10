class UserProfile < ActiveRecord::Base
  belongs_to :user

  # Make sure every user profile has a user
  validates :user, presence: true

  def resume
	  eval self.resume_hash
	end
	
	def card
	  eval self.card_hash
	end
	
  def generate_empty_resume
		resume = Jbuilder.encode do |resume|
		  resume.experience do |experience|
			  experience.entry_1 do |entry|
		      entry.title "e.g. Worked at McDonald's"
		      entry.location "e.g. Fredericton, NB"
		      entry.description "e.g. flipped burgs"
		      entry.start_date "e.g. July 16, 2008"
		      entry.end_date "e.g. July 17, 2008"
		    end
		  end
		  resume.education do |education|
			  education.entry_1 do |entry|
		      entry.school "e.g. University of Waterloo"
		      entry.location "e.g. Waterloo, ON"
		      entry.field "e.g. Physics"
		      entry.degree "e.g. BSc"
		      entry.description "e.g. I like school."
		      entry.start_date "e.g. September 1st, 2011"
		      entry.end_date "e.g. September 1st, 2013"
		    end
		  end
		  resume.skills do |skills|
			  skills.entry_1 "e.g. Ruby on Rails"
		  end
		end
		self.resume_hash = MultiJson.load(resume, symbolize_keys: true).inspect
	end

  def generate_empty_card
    contact = Jbuilder.encode do |contact|
      contact.email self.user.email
      contact.name  'e.g. Brian Zhang'
      contact.age  'e.g. 23'
      contact.location 'e.g. Waterloo, ON'
    end
    self.card_hash = MultiJson.load(contact, symbolize_keys: true).inspect
	end
		
	def destroy
	  generate_empty_resume
	  generate_empty_card
	end
end
