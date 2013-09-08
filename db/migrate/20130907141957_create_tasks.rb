class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title
      t.string :details
      t.integer :priority
      t.string :status, default: 'in progress'
      t.integer :poster_id

      t.timestamps
    end
    add_index :tasks, :poster_id
  end
end
