class AddActiveToCollaborationInvitation < ActiveRecord::Migration
  def change
    add_column :collaboration_invitations, :active, :string, default: 'yes'
  end
end
