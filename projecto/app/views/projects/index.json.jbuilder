json.array!(@projects) do |project|
  json.extract! project, :name, :category
  json.url project_url(project, format: :json)
end
