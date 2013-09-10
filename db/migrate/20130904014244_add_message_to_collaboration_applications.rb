class AddMessageToCollaborationApplications < ActiveRecord::Migration
  def change
    add_column :collaboration_applications, :message, :text
  end
end
