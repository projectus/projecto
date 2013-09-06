json.array!(@messages) do |message|
  json.extract! message, :title, :content, :User_id
  json.url message_url(message, format: :json)
end
