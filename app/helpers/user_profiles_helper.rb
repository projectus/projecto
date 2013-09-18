module UserProfilesHelper
  def profile_tab_class(tab)
	  'active' if params[:controller] == tab
	end
end
