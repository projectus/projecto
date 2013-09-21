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
			Proc.new{|entry| 
	      entry.title "e.g. Worked at McDonald's";
	      entry.location "e.g. Fredericton, NB";
	      entry.description "e.g. flipped burgs";
	      entry.start_date "e.g. July 16, 2008";
	      entry.end_date "e.g. July 17, 2008"}
	  elsif section == :education
			Proc.new{|entry| 
	      entry.school "e.g. University of Waterloo";
	      entry.location "e.g. Waterloo, ON";
	      entry.field "e.g. Physics";
	      entry.degree "e.g. BSc";
	      entry.description "e.g. I like school.";
	      entry.start_date "e.g. September 1st, 2011";
	      entry.end_date "e.g. September 1st, 2013"}
		elsif section == :skills
			Proc.new{|entry| 
	      entry.title "e.g. Ruby on Rails"}
	  end
	end
	
  def self.empty_resume_entry_hash(section,key)
		resume = Jbuilder.encode do |resume|
		  resume.set! key.to_sym do |entry| 
			  empty_resume_entry(section.to_sym).call(entry) 
			end
		end
		eval MultiJson.load(resume, symbolize_keys: true).inspect
	end
		
  def generate_empty_resume(defaults={})
		resume = Jbuilder.encode do |resume|
		  resume.experience do |experience|
			  experience.entry_01 do |entry|
		      UserProfile.empty_resume_entry(:experience).call(entry)
		    end
		  end
		  resume.education do |education|
			  education.entry_01 do |entry|
		      UserProfile.empty_resume_entry(:education).call(entry)
		    end
		  end
		  resume.skills do |skills|
			  skills.entry_01 do |entry|
		      UserProfile.empty_resume_entry(:skills).call(entry)	      
		    end
		  end
		end
		self.resume_hash = MultiJson.load(resume, symbolize_keys: true).inspect
	end
	
  def generate_empty_card(defaults={})
    contact = Jbuilder.encode do |contact|
      contact.secondary_email defaults[:email]
      contact.name            'Brian,Gay,Zhang'
      contact.birthday        '1989,7,16'
      contact.location        'Waterloo, ON'
    end
    self.card_hash = MultiJson.load(contact, symbolize_keys: true).inspect
	end
				
	def destroy
	  generate_empty_resume
	  generate_empty_card
	end

  def update_contact_card(fields)
	  #card = self.card
    card = fields.symbolize_keys
    self.card_hash = card.inspect
	end
	
  def update_resume_entry(section,key,fields)
	  resume = self.resume
	  symkey = key.to_sym
	  symsec = section.to_sym
	  if resume[symsec][symkey].nil?
		  resume[symsec][symkey] = UserProfile.empty_resume_entry_hash(symsec,symkey)[symkey]
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
