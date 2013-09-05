json.array!(@comments) do |comment|
  json.extract! comment, :content, :user_id, :project_id, :plus, :minus
  json.url comment_url(comment, format: :json)
end
