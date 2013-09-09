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
		      entry.content "Worked at McDonald's"
		      entry.location "Fredericton, NB"
		      entry.start_date "July 16, 2008"
		      entry.end_date "July 17, 2008"
		    end
		  end
		end
		self.resume_hash = MultiJson.load(resume, symbolize_keys: true).inspect
	end

  def generate_empty_card
		#self.card_xml = ''
		#xml = ::Builder::XmlMarkup.new(target: self.card_xml)
		#xml.instruct!
		
		#xml.contact do |contact|
		#  contact.email "email@mail.com"
		#  contact.name  "John Doe"
		#  contact.age   "21"
		#  contact.location "Waterloo, ON"
		#end
    contact = Jbuilder.encode do |contact|
      contact.email 'email@mail.com'
      contact.name 'eric webster'
      contact.age  '21'
      contact.location 'waterloo, ON'
    end
    self.card_hash = MultiJson.load(contact, symbolize_keys: true).inspect
	end
		
	def destroy
	  generate_empty_resume
	  generate_empty_card
	end
end
