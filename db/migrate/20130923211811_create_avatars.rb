class CreateAvatars < ActiveRecord::Migration
  def change
    create_table :avatars do |t|
      t.integer :avatarable_id
      t.string :avatarable_type
      t.integer :gallery_image_id

      t.timestamps
    end

    add_index :avatars, [:avatarable_id, :avatarable_type], unique: true
    add_index :avatars, :gallery_image_id
  end
end
