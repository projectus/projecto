module UserCollaborationInfoHelper
  def tab_class(tab)
	  'active' if params[:action] == tab
	end
end
