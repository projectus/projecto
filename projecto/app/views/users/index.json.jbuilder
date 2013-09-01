json.array!(@users) do |user|
  json.extract! user, :username, :password_digest, :email
  json.url user_url(user, format: :json)
end
