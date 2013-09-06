class CreateProjectProfiles < ActiveRecord::Migration
  def change
    create_table :project_profiles do |t|
      t.integer :project_id
      t.string :outline_xml
      t.belongs_to :Project, index: true

      t.timestamps
    end
  end
end
