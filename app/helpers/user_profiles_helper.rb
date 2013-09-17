module UserProfilesHelper
  def tab_class(tab)
	  'active' if params[:controller] == tab
	end
end
