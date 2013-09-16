class CreateActivityFeeds < ActiveRecord::Migration
  def change
    create_table :activity_feeds do |t|
      t.integer :subscribable_id
      t.string  :subscribable_type

      t.timestamps
    end
    add_index :activity_feeds, :subscribable_id

  end
end
