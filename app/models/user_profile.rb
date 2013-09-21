class UserProfile < ActiveRecord::Base
  belongs_to :user

  # Make sure every user profile has a user
  validates :user, presence: true

  validate :resume_keys_are_formatted_correctly

  def resume
	  eval self.resume_hash
	end
	
	def card
	  eval self.card_hash
	end

  def self.empty_resume_entry(section)
    if section == :experience
			{ :title => "e.g. Worked at McDonald's",
	      :location => "e.g. Fredericton, NB",
	      :description => "e.g. flipped burgs",
	      :start_date => "1989,7,16",
	      :end_date => "1989,7,16" }
	  elsif section == :education
			{ :school => "e.g. University of Waterloo",
	      :location => "e.g. Waterloo, ON",
	      :field => "e.g. Physics",
	      :degree => "e.g. BSc",
	      :description => "e.g. I like school.",
	      :start_date => "1989,7,16",
	      :end_date => "1989,7,16" }
		elsif section == :skills
			{ :title => "e.g. Ruby on Rails" }
	  end
	end
		
  def generate_empty_resume(defaults={})
		resume = {}
		resume[:experience][:entry_01] = UserProfile.empty_resume_entry(:experience)
		resume[:education][:entry_01] = UserProfile.empty_resume_entry(:education)
		resume[:skills][:entry_01] = UserProfile.empty_resume_entry(:skills)		
		self.resume_hash = resume.inspect
	end
	
  def generate_empty_card(defaults={})
    contact = {
      :secondary_email => defaults[:email],
      :name =>           'Brian,Gay,Zhang',
      :birthday =>       '1989,7,16',
      :location =>       'Waterloo, ON'
    }
    self.card_hash = contact.inspect
	end
				
	def destroy
	  generate_empty_resume
	  generate_empty_card
	end

  def update_contact_card(fields)
    card.update(fields.symbolize_keys)
    self.card_hash = card.inspect
	end
	
  def update_resume_entry(section,key,fields)
	  resume = self.resume
	  symkey = key.to_sym
	  symsec = section.to_sym
	  if resume[symsec][symkey].nil?
		  resume[symsec][symkey] = UserProfile.empty_resume_entry(symsec)
		end
		resume[symsec][symkey].update(fields.symbolize_keys)
    self.resume_hash = resume.inspect
	end

	def delete_resume_entry(section,key)
	  resume = self.resume
	  resume[section.to_sym].delete(key.to_sym)
	  self.resume_hash = resume.inspect
	  save!
	end
		
	private
	  def resume_keys_are_formatted_correctly
		  keys = resume.values.map(&:keys).flatten
		  keys.each do |key|
			  unless key =~ /entry_(\d\d)/
				  errors[:base] << "Incorrect entry key format. You may have too many entries."
				  return 
				end			
			end
		end	
end
