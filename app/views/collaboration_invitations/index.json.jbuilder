json.array!(@invitations) do |invitation|
  json.extract! invitation, 
  json.url collaboration_invitation_url(invitation, format: :json)
end
