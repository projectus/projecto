class CreateCollaborations < ActiveRecord::Migration
  def change
    create_table :collaborations do |t|
      t.string :role
      t.references :user, index: true
      t.references :project, index: true

      t.timestamps
    end
  end
end
