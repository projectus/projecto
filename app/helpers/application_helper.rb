module ApplicationHelper

  def broadcast(channel, &block)
    message = {:channel => channel, :data => capture(&block)}
    uri = URI.parse("http://localhost:9292/faye")
    Net::HTTP.post_form(uri, :message => message.to_json)
  end

  # Determine bootstrap alert type based on rails flash key
  def bootstrap_alert_type(key)
    return 'alert alert-danger' if key.to_s == 'alert'
	  return 'alert alert-success' if key.to_s == 'notice'
  end

  # Make a link to user profile from user
  def link_to_user_profile(user,name=nil)
	  return link_to name, user.profile unless name.nil?
	  link_to user.username, user.profile
	end
	
	# Make a link to project profile from project
  def link_to_project_profile(project,name=nil)
	  return link_to name, project.profile unless name.nil?
	  link_to project.name, project.profile
	end
end
