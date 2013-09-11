json.array!(@applications) do |application|
  json.extract! application, 
  json.url application_url(application, format: :json)
end
