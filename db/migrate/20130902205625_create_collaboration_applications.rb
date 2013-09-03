class CreateCollaborationApplications < ActiveRecord::Migration
  def change
    create_table :collaboration_applications do |t|
      t.belongs_to :project, index: true
      t.integer :applicant_user_id, index: true

      t.timestamps
    end
  end
end
