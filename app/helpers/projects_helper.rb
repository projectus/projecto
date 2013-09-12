module ProjectsHelper
	def category_selected?(category)
	  if params[:cat].nil?
		  category=='all'
	  else
		  category==params[:cat]
		end 
	end
end
