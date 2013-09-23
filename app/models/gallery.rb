class Gallery < ActiveRecord::Base
	belongs_to :showcasable, polymorphic: true
end
