json.array!(@collaborations) do |collaboration|
  json.extract! collaboration, :role, :user_id, :project_id
  json.url collaboration_url(collaboration, format: :json)
end
