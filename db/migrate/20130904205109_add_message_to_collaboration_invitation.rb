class AddMessageToCollaborationInvitation < ActiveRecord::Migration
  def change
    add_column :collaboration_invitations, :message, :string
  end
end
