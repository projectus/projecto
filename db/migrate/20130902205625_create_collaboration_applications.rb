class CreateCollaborationApplications < ActiveRecord::Migration
  def change
    create_table :collaboration_applications do |t|
      t.belongs_to :project, index: true
      t.integer :applicant_user_id

      t.timestamps
    end

    add_index :collaboration_applications, :applicant_user_id
  end
end
