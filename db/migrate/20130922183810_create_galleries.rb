class CreateGalleries < ActiveRecord::Migration
  def change
    create_table :galleries do |t|
      t.integer :showcasable_id
      t.string :showcasable_type

      t.timestamps
    end

    add_index :galleries, [:showcasable_id, :showcasable_type], unique: true
  end
end
