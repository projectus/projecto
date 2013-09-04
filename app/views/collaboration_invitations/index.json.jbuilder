json.array!(@collaboration_invitations) do |collaboration_invitation|
  json.extract! collaboration_invitation, 
  json.url collaboration_invitation_url(collaboration_invitation, format: :json)
end
