class AddStatusToCollaborationInvitation < ActiveRecord::Migration
  def change
    add_column :collaboration_invitations, :status, :string, default: 'pending'
  end
end
