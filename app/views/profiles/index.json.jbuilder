json.array!(@profiles) do |profile|
  json.extract! profile, :card_xml, :resume_xml, :User_id
  json.url profile_url(profile, format: :json)
end
