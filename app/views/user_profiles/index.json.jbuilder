json.array!(@user_profiles) do |profile|
  json.extract! profile, :card_xml, :resume_xml, :user_id
  json.url user_profile_url(profile, format: :json)
end