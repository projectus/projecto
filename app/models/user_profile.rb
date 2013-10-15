class UserProfile < ActiveRecord::Base
  belongs_to :user

  has_one :avatar, as: :avatarable, dependent: :destroy

  # Make sure every user has only one profile
  validates :user, presence: true, uniqueness: true

  validate :resume_entry_keys_are_formatted_correctly
	  	
  def resume
	  eval self.resume_hash
	end
	
	def card
	  eval self.card_hash
	end

  def self.empty_resume_entry(section)
	  symsec = section.to_sym
    if symsec == :experience
			{ :title => "e.g. Worked at McDonald's",
	      :location => "e.g. Fredericton, NB",
	      :description => "e.g. flipped burgs",
	      :start_date => "1989,7",
	      :end_date => "1989,7" }
	  elsif symsec == :education
			{ :school => "e.g. University of Waterloo",
	      :location => "e.g. Waterloo, ON",
	      :field => "e.g. Physics",
	      :degree => "e.g. BSc",
	      :description => "e.g. I like school.",
	      :start_date => "1989,7",
	      :end_date => "1989,7" }
		elsif symsec == :skills
			{ :title => "e.g. Ruby on Rails" }
	  end
	end

  def generate_empty_avatar(defaults={})
		build_avatar	
	end
			
  def generate_empty_resume(defaults={})
		resume = {}
		resume[:experience] = {:entry_01 => UserProfile.empty_resume_entry(:experience)}
		resume[:education] = {:entry_01 => UserProfile.empty_resume_entry(:education)}
		resume[:skills] = {:entry_01 => UserProfile.empty_resume_entry(:skills)}	
		self.resume_hash = resume.inspect
	end
	
  def generate_empty_card(defaults={})
    contact = {
      :secondary_email => defaults[:email],
      :name =>           'John,S,Doe',
      :birthday =>       '1992,4,11',
      :location =>       'Waterloo, ON'
    }
    self.card_hash = contact.inspect
	end
	
  def update_contact_card(fields)
	  card = self.card
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

	def destroy
		generate_empty_resume
		generate_empty_card
		generate_empty_avatar
	end
						
	private
	  def resume_entry_keys_are_formatted_correctly
		  keys = resume.values.map(&:keys).flatten
		  keys.each do |key|
			  unless key =~ /entry_(\d\d)/
				  errors[:base] << "Incorrect entry key format. You may have too many entries."
				  return 
				end			
			end
		end	
end
