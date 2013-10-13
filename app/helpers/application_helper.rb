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
	  return nil if user.nil?
	  return link_to name, user.profile unless name.nil?
	  link_to user.username, user.profile
	end

  # Make a link to profile (not currently using this)	
  def link_to_profile(m,name=nil)
	  return nil if m.nil?
	  return link_to name, m.profile unless name.nil?
	  if m.class == Project
		  mname = m.name
		elsif m.class == User
			mname = m.username
		else
			mname = nil
		end
	  link_to mname, m.profile
	end
	
	# Make a link to project profile from project
  def link_to_project_profile(project,name=nil)
	  return nil if project.nil?
	  return link_to name, project.profile unless name.nil?
	  link_to project.name, project.profile
	end

  # Helper to determine when tab is active based on controller action
  def tab_class(tab)
	  'active' if params[:action] == tab
	end
		
	# Construct activity headline
	def activity_headline(activity)
	  species = activity.species
	  if species == 'news post'
		  post = activity.referenceable_by_type('post')
			post.nil? ? '(news post removed)' : link_to(post.title, post)
		elsif species == 'new collaboration'
			prj = activity.referenceable_by_type('project')
			usr = activity.referenceable_by_type('user')
			x = usr.nil? ? '(user deleted)' : link_to_user_profile(usr)
			y = prj.nil? ? '(project deleted)' : link_to_project_profile(prj)
			x + ' joined ' + y + '!'
		elsif species == 'collaboration ended'
			prj = activity.referenceable_by_type('project')
			usr = activity.referenceable_by_type('user')
			x = usr.nil? ? '(user deleted)' : link_to_user_profile(usr)
			y = prj.nil? ? '(project deleted)' : link_to_project_profile(prj)
			x + ' is no longer with ' + y + '!'
		end
	end

	def avatar_url(m,type=:avatar)
		if m.profile.avatar.image.nil?
			if m.class == Project
        'site/pig.jpeg'
      elsif m.class == User
	      'site/projecticon.png'	  
	    end
    else	    
      m.profile.avatar.image.url(type)
    end
	end
	
	def avatar_tag(m,options={})
		type = options.delete(:type) 
		c = options[:class]
		c.nil? ? options[:class]='avatar' : options[:class]+=' avatar'
		if type.nil?
			image_tag avatar_url(m), options
		else
      image_tag avatar_url(m,type), options
    end 
	end
	
	def avatar_link(m,options={})
		if m.class == Project
		  link_to_project_profile m, avatar_tag(m,options)
		elsif m.class == User
			link_to_user_profile m, avatar_tag(m,options)
		end
	end
end
