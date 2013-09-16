class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.integer :subscribable_id
      t.string  :subscribable_type
      t.belongs_to :user, index: true

      t.timestamps
    end

    add_index :subscriptions, :subscribable_id
  end
end
