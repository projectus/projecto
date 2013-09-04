class CreateCollaborationInvitations < ActiveRecord::Migration
  def change
    create_table :collaboration_invitations do |t|
      t.belongs_to :project, index: true
      t.integer :invited_by_user_id
      t.integer :invited_user_id

      t.timestamps
    end

    add_index :collaboration_invitations, :invited_by_user_id
    add_index :collaboration_invitations, :invited_user_id
  end
end
