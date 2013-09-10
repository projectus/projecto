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
end
