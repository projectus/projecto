class CreateProjectProfiles < ActiveRecord::Migration
  def change
    create_table :project_profiles do |t|
      t.belongs_to :project, index: true
      t.string :outline_xml

      t.timestamps
    end
  end
end
