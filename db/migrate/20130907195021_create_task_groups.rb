class CreateTaskGroups < ActiveRecord::Migration
  def change
    create_table :task_groups do |t|
      t.string :name
      t.belongs_to :project, index: true

      t.timestamps
    end
  end
end
