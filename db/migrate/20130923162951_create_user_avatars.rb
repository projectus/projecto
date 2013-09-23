class CreateUserAvatars < ActiveRecord::Migration
  def change
    create_table :user_avatars do |t|
      t.belongs_to :gallery_image, index: true, unique: true
      t.belongs_to :user_profile, index: true, unique: true

      t.timestamps
    end
  end
end
