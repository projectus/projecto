class CreateActivityFeeds < ActiveRecord::Migration
  def change
    create_table :activity_feeds do |t|
      t.integer :feedable
      t.string  :feedable_type

      t.timestamps
    end
    add_index :activity_feeds, :feedable_id

  end
end
