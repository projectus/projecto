json.array!(@collaboration_applications) do |collaboration_application|
  json.extract! collaboration_application, 
  json.url collaboration_application_url(collaboration_application, format: :json)
end
