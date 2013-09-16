class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activity_entries do |t|
      t.string :headline
      t.string :species
      t.belongs_to :activity_feed, index: true
      t.integer :loggable_id
      t.string  :loggable_type

      t.timestamps
    end

    add_index :activities, :loggable_id
  end
end
