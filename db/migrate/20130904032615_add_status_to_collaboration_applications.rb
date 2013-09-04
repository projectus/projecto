class AddStatusToCollaborationApplications < ActiveRecord::Migration
  def change
    add_column :collaboration_applications, :status, :string, default: 'pending'
  end
end
