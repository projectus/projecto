class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :species
      t.belongs_to :activity_feed, index: true

      t.timestamps
    end
  end
end
